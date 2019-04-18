const webpack = require('webpack')
const { environment } = require('@rails/webpacker')

const babelLoader = environment.loaders.get('babel')
babelLoader.exclude = []

environment.splitChunks()

module.exports = environment
