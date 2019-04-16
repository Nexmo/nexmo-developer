const webpack = require('webpack')
const { environment } = require('@rails/webpacker')

const babelLoader = environment.loaders.get('babel')
babelLoader.exclude = []

environment.plugins.append(
  'CommonsChunkCommons',
  new webpack.optimize.CommonsChunkPlugin({
    name: 'commons',
    minChunks: (module) => {
      return module.context && module.context.indexOf('node_modules') !== -1
    },
  })
)

environment.plugins.append(
  'CommonsChunkManifest',
  new webpack.optimize.CommonsChunkPlugin({
    name: 'manifest',
    minChunks: Infinity,
  })
)

module.exports = environment
