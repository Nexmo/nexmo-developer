class PhpInlinerFilter < Banzai::Filter
  def call(input)
    input.gsub(/(```php)\n/) do
      "#{$1}?start_inline=1\n"
    end
  end
end
