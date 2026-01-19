export default defineAppConfig({
  seo: {
    // Default to `%s - ${site.name}`
    titleTemplate: '',
    // Default to package.json name
    title: '',
    // Default to package.json description
    description: ''
  },
  header: {
    // Title to display if no logo
    title: 'SDNwiki',
    // Logo configuration
    logo: {
      alt: 'SDN',
      // Light mode
      light: '/logo.svg',
      // Dark mode
      dark: '/logo.svg'
    },
  },
  socials: {
    nuxt: 'https://nuxt.com',
  },
  github: {
    url: 'https://github.com/dotnix/',
    branch: 'stable/26.01',
    rootDir: 'docs/wiki'
  },
  toc: {
    // Rename the title of the table of contents
    title: 'On this page',
    // Add a bottom section to the table of contents
    bottom: {
      title: 'Community',
      links: [{
        icon: 'i-lucide-book-open',
        label: 'Nuxt UI docs',
        to: 'https://ui.nuxt.com/getting-started/installation/nuxt',
        target: '_blank'
      }]
    }
  },
  ui: {
    colors: {
      primary: 'teal',
      neutral: 'zinc'
    },
  }
})
