module Enumerable
  def each_with_position
    each_with_index do |element, index|
      first = index.zero?
      last = index.equal?(size - 1)
      yield(element, first, last)
    end
  end
end
