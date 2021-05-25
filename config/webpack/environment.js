const { environment } = require('@rails/webpacker')

module.exports = environment

const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue')
 
environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('vue', vue)

const webpack = require('webpack')
environment.plugins.prepend(
  "Provide",
  new webpack.ProvidePlugin({
    $: "jquery",
    jQuery: "jquery",
    jquery: "jquery",
    "window.Tether": "tether",
    Popper: ["popper.js", "default"] // for Bootstrap 4
  })
);

module.exports = environment;
