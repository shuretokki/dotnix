export default defineNuxtConfig({
  modules: ['@nuxtjs/i18n', 'nuxt-studio'],
  i18n: {
    defaultLocale: 'en',
    locales: [{
      code: 'en',
      name: 'English',
    }, {
      code: 'id',
      name: 'Bahasa Indonesia',
    }],
  },
  llms: {
    domain: 'http://localhost:3000',
    title: 'SDN Wiki',
    description: 'Wiki documentation for SDN',
  }
})