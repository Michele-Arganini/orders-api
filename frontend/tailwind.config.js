/** @type {import('tailwindcss').Config} */
export default {
  content: [
    './index.html',
    './src/**/*.{vue,js,ts,jsx,tsx}',
  ],
  theme: {
    extend: {
      // Breakpoints personalizzati
      screens: {
        xxs: '340px',
        xs: '375px',
        sm: '576px',
        md: '768px',
        lg: '980px',
        xl: '1200px',
        '2xl': '1440px',
      },
      // Colori personalizzati
      colors: {
        primary: '#007bb5',
        secondary: '#282828',
        muted: '#999790',
        light: '#F5F5F5',
      },
      borderColor: theme => ({
        light: '#d3d3d3',
        lighter: '#F1F1F1',
      }),
      // Spazio personalizzato
      spacing: {
        '7.5': '1.875rem',  // 30px
        '5.5': '1.375rem',  // 22px
        '10.5': '2.625rem', // 42px
      },
      // Bordi personalizzati
      borderWidth: {
        '10': '10px',
      },
      // Ombreggiature personalizzate
      boxShadow: {
        'card': '0 2px 5px rgba(0, 0, 0, 0.08)',
      }
    }
  },
  plugins: [],
}