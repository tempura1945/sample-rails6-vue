const { environment } = require('@rails/webpacker')

module.exports = environment

const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue')
 
environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('vue', vue)

const webpack = require('webpack')
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'admin-lte/plugins/jquery/jquery',
    jQuery: 'admin-lte/plugins/jquery/jquery',
  })
)