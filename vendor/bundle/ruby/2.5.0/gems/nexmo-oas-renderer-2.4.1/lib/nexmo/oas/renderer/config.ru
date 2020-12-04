# frozen_string_literal: true

require_relative './app'
require 'sass/plugin/rack'

Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack

run Nexmo::OAS::Renderer::API
