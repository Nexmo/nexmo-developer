module Enumerable
  def each_with_position(&block)
    each_with_index do |element, index|
      first = index == 0
      last = index.equal?(size - 1)
      block.call(element, first, last)
    end
  end
end
