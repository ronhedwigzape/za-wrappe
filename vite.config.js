import { fileURLToPath, URL } from 'node:url';
import { defineConfig, loadEnv, splitVendorChunkPlugin } from 'vite';
import vue from '@vitejs/plugin-vue';
import VueDevTools from 'vite-plugin-vue-devtools';
import vuetify from 'vite-plugin-vuetify';

// https://vitejs.dev/config/
export default ({ mode }) => {
  process.env = { ...process.env, ...loadEnv(mode, process.cwd()) };
  const SKIP_BASE_PATH = process.env.VITE_SKIP_BASE_PATH;

  return defineConfig({
    plugins: [
      vue(),
      VueDevTools(),
      vuetify({
        autoImport: true
      }),
      splitVendorChunkPlugin() // Automatically split vendor modules into a separate chunk
    ],
    resolve: {
      alias: {
        '@': fileURLToPath(new URL('./src', import.meta.url))
      }
    },
    base: SKIP_BASE_PATH === undefined || SKIP_BASE_PATH === 'false' ? '/za-wrappe/' : undefined,
    publicDir: 'assets',
    server: {
      host: 'localhost',
      port: 5004,
      strictPort: true
    },
    build: {
      outDir: 'public',
      chunkSizeWarningLimit: 1600, // Increase the limit to 1600 KB to reduce warnings
      rollupOptions: {
        output: {
          manualChunks(id) {
            if (id.includes('node_modules')) {
              // Split node_modules into a separate chunk
              return id.split('node_modules/')[1].split('/')[0];
            }
          }
        }
      }
    }
  });
};
