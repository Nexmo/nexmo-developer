# frozen_string_literal: true

module Nexmo
  module OAS
    module Renderer
      module Presenters
        class Versions
          def initialize(definition_name)
            @definition_name = definition_name
          end

          def base_name
            @base_name ||= @definition_name.gsub(/\.v\d+/, '')
          end

          def current_version
            @current_version ||= begin
                                   m = /\.v(\d+)/.match(@definition_name)
                                   m.nil? ? '1' : m[1]
                                 end
          end

          def available_versions
            @available_versions ||= begin
                                      matches = definitions.select do |definition|
                                        definition.match(/^#{base_name}(\.v\d+)?$/) && !definition.include?("#{base_name}/")
                                      end

                                      matches = matches.map do |definition|
                                        m = /\.v(\d+)/.match(definition)
                                        next { 'version' => '1', 'name' => definition } unless m

                                        { 'version' => m[1], 'name' => definition }
                                      end

                                      matches.sort_by { |v| v['version'] }
                                    end
          end

          def definitions
            @definitions ||= begin
                               Dir.glob("#{API.oas_path}/**/*.yml").map do |file|
                                 file.sub("#{API.oas_path}/", '').chomp('.yml')
                               end
                             end
          end
        end
      end
    end
  end
end
