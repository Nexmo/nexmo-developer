module Nexmo
  module Markdown
    class CodeSnippetFilter < Banzai::Filter
      include OcticonsHelper

      def call(input)
        input.gsub(/```single_code_snippet(.+?)```/m) do |_s|
          @config = YAML.safe_load($1)
          @binding = ::Nexmo::Markdown::Filters::CodeSnippet::Binding.new(@config)

          return instructions if @config['code_only']

          "#{prerequisites}#{instructions}#{run}"
        end
      end

      def prerequisites
        @prerequisites ||= begin
          prereqs = [application_html, install_dependencies, import_dependencies, initialize_dependencies].join.strip
          prereqs = "<h2>#{::I18n.t('.filters.prerequisites')}</h2>#{prereqs}" unless prereqs.empty?
          prereqs
        end
      end

      def application_html
        @application_html ||= ::Nexmo::Markdown::Filters::CodeSnippet::CreateApplication.new(@config['application']).render
      end

      def install_dependencies
        @install_dependencies ||= ::Nexmo::Markdown::Filters::CodeSnippet::InstallDependencies.new(@config['dependencies'], @config['version'], @binding).render
      end

      def import_dependencies
        @import_dependencies ||= ::Nexmo::Markdown::Filters::CodeSnippet::ImportDependencies.new(@config['import_dependencies'], @binding).render
      end

      def initialize_dependencies
        @initialize_dependencies ||= ::Nexmo::Markdown::Filters::CodeSnippet::InitializeDependencies.new(@config['client'], @binding).render
      end

      def instructions
        @instructions ||= ::Nexmo::Markdown::Filters::CodeSnippet::Instructions.new(@config, @binding).render
      end

      def run
        @run ||= ::Nexmo::Markdown::Filters::CodeSnippet::Run.new(@config, @binding).render
      end
    end
  end
end
