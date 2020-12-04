# frozen_string_literal: true

module Banzai
  # Pipeline is a filter that accepts an array of filters that will be applied
  # to input sequentially.
  #
  # @example Create a pipeline and process input
  #   Pipeline.new(GaussianBlur.new(radius:1.1), Nostalgia).call(image)
  #
  class Pipeline < Filter
    # @param [Array<Filter>] filters array of filters that will be in the
    #   pipeline. They can be either Filter class or instance.
    def initialize(*filters)
      @filters = filters.flatten
    end

    # Process input by sending it down the filters pipeline
    #
    # @param [Object] input
    # @return [Object]
    def call(input)
      @filters.inject(input) do |content, filter|
        filter.call(content)
      end
    end
  end
end
