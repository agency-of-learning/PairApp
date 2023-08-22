const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
  content: [
    "./public/*.html",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/*.{erb,haml,html,slim}",
    "./app/components/**/*.{rb,erb,html}",
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ["Inter var", ...defaultTheme.fontFamily.sans],
      },
    },
  },
  daisyui: {
    themes: [
      {
        light: {
          ...require("daisyui/src/colors/themes")["[data-theme=light]"],
          primary: "#38d68e",
          "primary-focus": "#03985c",
          "primary-content": "#ecfdf3",
          neutral: "#363942",
          "neutral-focus": "#2C2E36",
          "neutral-content": "#ededf1",
          secondary: "#45aeeb",
          "secondary-focus": "#0e5e96",
          "secondary-content": "#f1f8fe",
        },
      },
    ],
  },
  plugins: [
    require("@tailwindcss/aspect-ratio"),
    require("@tailwindcss/typography"),
    require("daisyui"),
  ],
  purge: {
    safelist: ["alert-error", "alert-success"],
  },
};
