# frozen_string_literal: true

module Nexmo
  module OAS
    module Renderer
      module Presenters
        class RequestBodyRaw
          def initialize(parameters, options = {}, endpoint = nil)
            @parameters = parameters
            @options = options
            @endpoint = endpoint
          end

          def to_format(format)
            return to_urlencoded if format == 'application/x-www-form-urlencoded'

            to_json
          end

          def to_urlencoded
            example = ''
            body = URI.encode_www_form(generate_request)
            if @endpoint
              servers = @endpoint.path.servers || @endpoint.definition.servers
              path = @endpoint.path.path.gsub(/\{(.+?)\}/, ':\1')
              uri = URI("#{servers[0]['url']}#{path}")
              example += "#{@endpoint.method.upcase} #{uri.path} HTTP/1.1\n"
              example += "Host: #{uri.host} \n"
              example += "Content-Type: application/x-www-form-urlencoded\n"
              example += "Content-Length: #{body.length}\n"
              example += "\n"
            end
            example += body
            example
          end

          def to_json(*_args)
            JSON.pretty_generate(generate_request)
          end

          def generate_request(parameters = nil, options = nil)
            parameters ||= @parameters
            options ||= @options
            output = {}

            parameters.each do |parameter|
              next if options['required_only'] && optional?(parameter, options['required'])

              parameter_name = name(parameter)
              param = parameter

              # This is all required to handle an edge case where parameter.name is an OasParser::Property
              # Which happens when you use a oneOf inside items in a property.
              # I believe this is a bug, but it's a BC break in the parser

              if parameter_name.instance_of?(OasParser::Property)
                parameter_name = parameter.owner.name
                param = OasParser::Parameter.new(parameter_name, parameter.schema)
              end

              if param.raw['items'] && param.raw['example']
                output[parameter_name] = param.raw['example']
              elsif param.raw['items'] && param.raw['items']['oneOf']
                param = param.raw['items']['oneOf'][0]
                output[parameter_name] = [generate_request(properties(param).map(&:name))]
              elsif collection?(param) && properties?(param)
                nested_output = generate_request(properties(param))
                next unless nested_output.keys.length.positive?

                nested_output = [nested_output] if param.array?
                output[parameter_name] = nested_output
              else
                ex = example(param)
                next unless ex

                if ex.is_a?(String)
                  # Remove line breaks
                  ex = ex.gsub('<br />', ' ')
                end
                output[parameter_name] = ex
              end
            end
            output
          end

          def items(parameter)
            return parameter['items'] unless parameter.respond_to?(:items)

            parameter.items
          end

          def example(parameter)
            return parameter['example'] unless parameter.respond_to?(:example)

            parameter.example
          end

          def name(parameter)
            return parameter['name'] unless parameter.respond_to?(:name)

            parameter.name
          end

          def properties(parameter)
            return parameter['properties'] unless parameter.respond_to?(:properties)

            parameter.properties
          end

          def array?(parameter)
            return parameter['items'] unless parameter.respond_to?(:array?)

            parameter.array?
          end

          def collection?(parameter)
            return parameter['properties'] unless parameter.respond_to?(:collection?)

            parameter.collection?
          end

          def properties?(parameter)
            return parameter['properties'] unless parameter.respond_to?(:collection?)

            parameter.properties.size.positive?
          end

          def optional?(parameter, allow_list)
            return false if allow_list&.include?(name(parameter))

            return false unless parameter.respond_to?(:required)

            return false unless parameter.schema

            !parameter.required
          end
        end
      end
    end
  end
end
