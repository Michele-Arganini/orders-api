import { defineConfig, loadEnv } from 'vite'
import vue from '@vitejs/plugin-vue'

export default defineConfig(({ mode }) => {
  // Carica variabili d'ambiente
  const env = loadEnv(mode, process.cwd())
  const VITE_API_URL = env.VITE_API_URL

  return {
    plugins: [vue()],
    server: {
      // Imposta il proxy per le API
      proxy: {
        '/api': {
          target: VITE_API_URL,
          changeOrigin: true,
          secure: false,
        }
      }
    }
  }
})
