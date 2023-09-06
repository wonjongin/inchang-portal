const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  prefix: 'tw-',
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    './app/components/**/*.erb',
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ],
  corePlugins: {
    preflight: true,
  },

  safelist: [
    {
      pattern: /tw-bg-(red|green)-(500|600|700)/,
      variants: ['hover'],
    },
    {
      pattern: /tw-text-(red|green|blue)-700/,
    },
    {
      pattern: /tw-border-violet-600/,
    },
    {
      pattern: /tw-border-2/,
    },
  ],
}
