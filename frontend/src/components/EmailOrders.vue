<template>
  <div class="min-h-screen flex items-center justify-center">
    <section class="w-full max-w-[636px] lg:max-w-[970px] mx-auto bg-white pt-8 pb-8 px-2.5 rounded-none shadow-none font-serif">
      <!-- Titolo principale -->
      <h2 class="text-[38px] md:text-[34px] leading-[34px] font-bold pt-4 pb-5.5 text-secondary border-t-10 border-t-secondary border-b border-b-light">
        Ricerca <span class="text-primary">i tuoi ordini</span>
      </h2>

      <!-- Input email + bottone di ricerca -->
      <div class="mt-7.5">
        <div class="flex flex-col lg:flex-row gap-4">
          <input
            id="email-input"
            v-model="email"
            type="email"
            placeholder="Inserisci la tua email"
            @focus="handleFocus"
            @blur="handleBlur"
            class="flex-grow text-lg bg-light rounded-sm py-2 px-5 placeholder:text-muted focus:ring-primary focus:border-primary outline-none"
            :class="email
              ? 'text-secondary placeholder:text-muted focus:ring-primary focus:border-primary'
              : 'text-muted'"
          />
          <button
            title="Cerca"
            @click="fetchOrders"
            class="border-primary leading-7 border text-primary py-2 px-11 transition-colors duration-200 text-lg w-fit hover:bg-primary hover:text-white"
            :disabled="loading"
          >
            <span v-if="!loading">Cerca</span>
            <span v-else>Ricerca...</span>
          </button>
        </div>
        <!-- Messaggio di validazione -->
        <p v-if="validationError" class="mt-2 text-sm text-red-600">
          {{ validationError }}
        </p>
      </div>

      <!-- Messaggio di errore server -->
      <div v-if="errorMessage" class="mb-6 p-4 bg-red-100 text-red-700 rounded-sm border border-red-200">
        {{ errorMessage }}
      </div>

      <!-- Lista ordini (accordion) -->
      <div v-if="paginatedOrders.length">
        <p class="text-xl mt-7.5 font-bold mb-3 text-secondary border-light border-t pt-4">
          I tuoi ordini degli ultimi 30 giorni
        </p>

        <div
          v-for="(order, index) in paginatedOrders"
          :key="order.id"
          class="mb-4 overflow-hidden"
        >
          <!-- Intestazione dell'accordion -->
          <div
            class="bg-secondary py-1.5 px-4 flex justify-between items-center cursor-pointer"
            @click="toggleAccordion(order.id)"
          >
            <p class="text-xs font-bold font-serif lining-nums text-white mb-0">
              {{ formatDate(order.order_date) }}
            </p>
            <span class="text-white text-xl">{{ openOrderId === order.id ? '-' : '+' }}</span>
          </div>

          <!-- Contenuto dell'accordion -->
          <div
            ref="accordionContent"
            class="accordion-content bg-light overflow-hidden"
            :style="getAccordionStyle(order.id)"
          >
            <div class="px-4 py-4">
              <div class="flex flex-row justify-between items-center">
                <ul class="space-y-2">
                  <li
                    v-for="(product, idx) in order.products"
                    :key="idx"
                    class="flex items-center text-sm font-bold text-primary mb-1 pr-3"
                  >
                    <span class="flex-none mr-1 text-primary">-</span>
                    <a :title="product.name" href="#" class="hover:underline transition-colors duration-200">
                      {{ product.name }} x {{ product.quantity }}
                    </a>
                  </li>
                </ul>
                <button
                  title="Dettagli"
                  class="border-primary ml-auto leading-7 border text-primary xs:py-0.5 px-1.5 xs:px-2.5 transition-colors duration-200 text-sm w-fit hover:bg-primary hover:text-white"
                >
                  Dettagli
                </button>
              </div>
            </div>
          </div>
        </div>

        <!-- Paginazione -->
        <div class="flex justify-center mt-14 space-x-2 border-t pt-[32px]">
          <button
            v-for="page in totalPages"
            :key="page"
            @click="currentPage = page"
            :class="[
              'px-3 py-1 border',
              currentPage === page ? 'bg-primary text-white' : 'border-primary text-primary'
            ]"
          >
            {{ page }}
          </button>
        </div>
      </div>

      <!-- Messaggio se nessun ordine viene trovato -->
      <div v-else-if="fetched && !loading" class="mt-6 p-6 bg-light text-muted text-center italic rounded-md">
        Nessun ordine trovato negli ultimi 30 giorni.
      </div>
    </section>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, nextTick } from 'vue'
import axios from 'axios'

// --- STATE reactive ---
const email = ref('')                // valore dell'input email
const orders = ref([])               // lista ordini caricati
const fetched = ref(false)           // flag se fetch è stato eseguito
const loading = ref(false)           // flag loading spinner
const errorMessage = ref('')         // messaggio di errore server
const validationError = ref('')      // messaggio di validazione email
const placeholderTimeout = ref(null) // timer per nascondere placeholder
const API_BASE = import.meta.env.VITE_API_URL // base URL API

// Accordion
const openOrderId = ref(null)       // id ordine aperto
const currentPage = ref(1)          // pagina corrente
const perPage = 5                   // ordini per pagina
const accordionHeights = ref({})    // memorizza altezze accordion

// --- computed per paginazione ---
const paginatedOrders = computed(() => {
  const start = (currentPage.value - 1) * perPage
  return orders.value.slice(start, start + perPage)
})
const totalPages = computed(() => Math.ceil(orders.value.length / perPage))

// --- funzioni di interazione ---

/** Apre/chiude accordion e misura altezza dinamicamente */
const toggleAccordion = async (orderId) => {
  if (openOrderId.value !== orderId) {
    openOrderId.value = orderId
    await nextTick()  // aspetto il DOM aggiornato
    calculateAccordionHeights()
  } else {
    openOrderId.value = null
  }
}

/** Restituisce lo stile dinamico per l'apertura/chiusura */
const getAccordionStyle = (orderId) => ({
  height: openOrderId.value === orderId ? accordionHeights.value[orderId] || 'auto' : '0',
  opacity: openOrderId.value === orderId ? '1' : '0',
  transition: 'height 0.3s ease-in-out, opacity 0.2s ease-in-out',
  padding: openOrderId.value === orderId ? undefined : '0'
})

/** Nasconde gradualmente il placeholder dopo 500ms di focus */
const handleFocus = () => {
  clearTimeout(placeholderTimeout.value)
  placeholderTimeout.value = setTimeout(() => {
    const input = document.getElementById('email-input')
    input.classList.add('hide-placeholder')
  }, 500)
}
/** Mostra di nuovo il placeholder al blur */
const handleBlur = () => {
  clearTimeout(placeholderTimeout.value)
  const input = document.getElementById('email-input')
  input.classList.remove('hide-placeholder')
}

/** Validazione con regex */
function validateEmail(val) {
  const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
  return re.test(val)
}

/** Richiama l’API e popola orders */
const fetchOrders = async () => {
  validationError.value = ''
  errorMessage.value = ''
  orders.value = []
  fetched.value = false

  // validazione lato client
  if (!email.value) {
    validationError.value = 'Inserisci un indirizzo email'
    return
  }
  if (!validateEmail(email.value)) {
    validationError.value = 'Inserisci un indirizzo email valido'
    return
  }

  loading.value = true
  try {
    const response = await axios.get(`${API_BASE}/api/orders`, {
      params: { email: email.value }
    })
    if (response.data.success) {
      // ordini più recenti per primi
      orders.value = response.data.orders.sort((a, b) =>
        new Date(b.order_date) - new Date(a.order_date)
      )
      openOrderId.value = orders.value.length ? orders.value[0].id : null
      currentPage.value = 1
      await nextTick()
      calculateAccordionHeights()
    } else {
      errorMessage.value = response.data.error || 'Errore sconosciuto'
    }
    fetched.value = true
  } catch (err) {
    console.error('Errore completo server:', err)
    errorMessage.value = err.response?.data?.error
      ? `Errore server: ${err.response.data.error}`
      : 'Nessuna risposta dal server.'
  } finally {
    loading.value = false
  }
}

/** Calcola dinamicamente le altezze reali degli accordion chiusi */
const calculateAccordionHeights = async () => {
  await nextTick()
  document.querySelectorAll('.accordion-content').forEach(el => {
    const container = el.closest('[data-order-id]')
    if (container) {
      // mostra temporaneamente per scrollHeight
      el.style.height = 'auto'
      accordionHeights.value[container.dataset.orderId] = `${el.scrollHeight}px`
      el.style.height = ''
    }
  })
}

/** All’avvio, assegna data-order-id ai container (per misura) */
onMounted(() => {
  nextTick(() => {
    document.querySelectorAll('.accordion-content').forEach((el, i) => {
      const ord = paginatedOrders.value[i]
      if (ord) el.closest('div').setAttribute('data-order-id', ord.id)
    })
  })
})

/** Formatta la data in ITA es: “01 MAG 2025” */
const formatDate = (dateString) => {
  const dt = new Date(dateString)
  return dt.toLocaleDateString('it-IT', {
    day: '2-digit',
    month: 'short',
    year: 'numeric'
  }).replace(/\./g, '').toUpperCase()
}
</script>

<style scoped>
/* Import font CSS da Internazionale */
@import url('https://static.internazionale.it/assets/fonts/Lyon-Text-OSF/fonts.css');
@import url('https://static.internazionale.it/assets/fonts/Stencil/fonts.css?2');

/* Corpo usa Lyon Text */
.container-orders{
  font-family: "Lyon Text OSF Web", Georgia, "Times New Roman", Times, serif;
}

/* Titoli (h2,h3,h4) usano Stencil */
section h2,
section h3,
section h4 {
  font-family: "Stencil", Georgia, "Times New Roman", Times, serif;
}

/* Form label, button, input restano in Lyon Text */
label,
button,
input,
td,
th {
  font-family: "Lyon Text OSF Web", Georgia, "Times New Roman", Times, serif;
}

/* Transizione del placeholder - solo quando sparisce */
input::placeholder {
  opacity: 1;
  transition: opacity 0.3s ease;
}

.hide-placeholder::placeholder {
  opacity: 0;
}

</style>