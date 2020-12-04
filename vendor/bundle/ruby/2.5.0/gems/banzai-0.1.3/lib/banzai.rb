# frozen_string_literal: true

# Banzai is a simple toolkit for processing any input using filters.
# Multiple filters can be combined into a pipeline that will transform input
# by appliyng filters in chain feeding next one with the output of the previous.
module Banzai
  autoload :Version,  'banzai/version'
  autoload :Filter,   'banzai/filter'
  autoload :Pipeline, 'banzai/pipeline'
end
