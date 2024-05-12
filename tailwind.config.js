/** @type {import('tailwindcss').Config} */
import { tailwindConfig } from '@storefront-ui/vue/tailwind-config';
export default {
  prefix: 'tw-',
  presets: [tailwindConfig],
  content: [
    './index.html',
    './src/**/*.{vue,js,ts,jsx,tsx}',
    './**/*.vue',
    './node_modules/@storefront-ui/vue/**/*.{js,mjs}'
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}

