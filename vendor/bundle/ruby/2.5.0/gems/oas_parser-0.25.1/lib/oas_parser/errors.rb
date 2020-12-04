module OasParser
  class Error < StandardError; end
  class CallbackNotFound < Error; end
  class MethodNotFound < Error; end
  class ParameterNotFound < Error; end
  class PathNotFound < Error; end
  class ResponseCodeNotFound < Error; end
end
