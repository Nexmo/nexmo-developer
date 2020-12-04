# frozen_string_literal: true

module Banzai
  # Filter transforms an input into desired output. The process of
  # transformation should be implemented in the {#call} method.
  class Filter
    attr_reader :options

    # @param [Hash] options The parameters that method {#call} can  utilize
    #   to make processing customizable
    def initialize(options = {})
      @options = options
    end

    # Subclass should redefine this method to transform input to desired output.
    # Input and return value should be the same type to provide way of chaining
    # filters
    #
    # @param [Object] input
    # @return [Object] the desired output
    def call(input)
      input
    end

    # Delegates to {#call} by creating an instance with default options
    #
    # @param [Object] input
    def self.call(input)
      new.call(input)
    end
  end
end
