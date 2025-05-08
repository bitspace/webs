// @ts-check
import { defineConfig } from 'astro/config';

// https://astro.build/config
export default defineConfig({
  // Configure build settings
  output: 'static',
  build: {
    // generate HTML files for specific domains
    format: 'file',
    outDir: '../dist'
  },

  // Configure site paths
  site: 'https://example.com',
  
  // Configure server settings for development
  server: {
    port: 3000,
    host: true
  }
});
