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
        sans: ["Roboto", "Inter var", ...defaultTheme.fontFamily.sans],
      },
      colors: {
        "twitter-brand": "#26a7de",
        "linkedin-brand": "#0072b1",
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
          "primary-content-dark": "#022c1e",
          neutral: "#363942",
          "neutral-focus": "#2C2E36",
          "neutral-content": "#ededf1",
          secondary: "#45aeeb",
          "secondary-focus": "#0e5e96",
          "secondary-content": "#f1f8fe",
          success: "#ecfdf3",
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
    safelist: [
      "alert-error",
      "alert-success",
      "text-success",
      "border-success",
      "border-error",
      "bg-success",
      "bg-error",
      "direct-upload",
      "direct-upload--pending",
      "direct-upload__progress",
      "direct-upload--error",
      "direct-upload--complete",
    ],
  },
};
