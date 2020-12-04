# frozen_string_literal: true
GEM_ROOT = File.expand_path("../..", __FILE__)
require 'banzai'
require 'octicons_helper'
require 'nokogiri'
require 'open-uri'
require 'active_model'
require 'i18n'

require_relative 'nexmo_markdown_renderer/config/load_config'
require_relative 'nexmo_markdown_renderer/initializers/redcarpet'
require_relative 'nexmo_markdown_renderer/initializers/i18n'
require_relative 'nexmo_markdown_renderer/core_ext/string'

require_relative 'nexmo_markdown_renderer/services/code_snippet_renderer/base'
require_relative 'nexmo_markdown_renderer/services/code_snippet_renderer/android'
require_relative 'nexmo_markdown_renderer/services/code_snippet_renderer/curl'
require_relative 'nexmo_markdown_renderer/services/code_snippet_renderer/dotnet'
require_relative 'nexmo_markdown_renderer/services/code_snippet_renderer/java'
require_relative 'nexmo_markdown_renderer/services/code_snippet_renderer/javascript'
require_relative 'nexmo_markdown_renderer/services/code_snippet_renderer/kotlin'
require_relative 'nexmo_markdown_renderer/services/code_snippet_renderer/objective_c'
require_relative 'nexmo_markdown_renderer/services/code_snippet_renderer/php'
require_relative 'nexmo_markdown_renderer/services/code_snippet_renderer/python'
require_relative 'nexmo_markdown_renderer/services/code_snippet_renderer/ruby'
require_relative 'nexmo_markdown_renderer/services/code_snippet_renderer/swift'
require_relative 'nexmo_markdown_renderer/services/code_snippet_renderer/go'

require_relative 'nexmo_markdown_renderer/services/doc_finder'
require_relative 'nexmo_markdown_renderer/services/doc_finder/doc'

require_relative 'nexmo_markdown_renderer/models/code_language'
require_relative 'nexmo_markdown_renderer/models/code_snippet'
require_relative 'nexmo_markdown_renderer/models/concept'
require_relative 'nexmo_markdown_renderer/models/tutorial'
require_relative 'nexmo_markdown_renderer/models/tutorial/file_loader'
require_relative 'nexmo_markdown_renderer/models/tutorial/metadata'
require_relative 'nexmo_markdown_renderer/models/tutorial/prerequisite'
require_relative 'nexmo_markdown_renderer/models/tutorial/task'
require_relative 'nexmo_markdown_renderer/models/use_case'

require_relative 'nexmo_markdown_renderer/filters/code_snippet/binding'
require_relative 'nexmo_markdown_renderer/filters/code_snippet/renderable'
require_relative 'nexmo_markdown_renderer/filters/code_snippet/create_application'
require_relative 'nexmo_markdown_renderer/filters/code_snippet/initialize_dependencies'
require_relative 'nexmo_markdown_renderer/filters/code_snippet/instructions'
require_relative 'nexmo_markdown_renderer/filters/code_snippet/import_dependencies'
require_relative 'nexmo_markdown_renderer/filters/code_snippet/install_dependencies'
require_relative 'nexmo_markdown_renderer/filters/code_snippet/run'

Dir[File.join(__dir__, 'nexmo_markdown_renderer/filters/concerns', '*.rb')].each { |file| require_relative file }
Dir[File.join(__dir__, 'nexmo_markdown_renderer/filters', '*.rb')].each { |file| require_relative file }
Dir[File.join(__dir__, 'nexmo_markdown_renderer/filters/i18n', '*.rb')].each { |file| require_relative file }
Dir[File.join(__dir__, 'nexmo_markdown_renderer/filters/i18n/smartling', '*.rb')].each { |file| require_relative file }
Dir[File.join(__dir__, 'nexmo_markdown_renderer/pipelines/smartling', '*.rb')].each { |file| require_relative file }
require_relative 'nexmo_markdown_renderer/markdown_renderer'
