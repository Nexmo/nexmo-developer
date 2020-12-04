Banzai
======

Simple toolkit for processing input using filter/pipeline concept.

## Installation

Add this line to your application's Gemfile:

    gem 'banzai'

## Usage

First, implement some filters:

```ruby
class GaussianBlur < Banzai::Filter
  def call(input)
    # process input
    # ...
  end
end 

class Nostalgia < Banzai::Filter
  def call(input)
    # process input
    # ...
  end
end
```

Then you can apply them to some input:

```ruby
GaussianBlur.new(radius:1.1).call(image)
```

You can also use class method `call` if filter doesn't have options, or you
want to apply default ones (defined in implementation itself):

```ruby
Nostalgia.call(image)
```

To apply multiple filters to input use `Banzai::Pipeline`. Note that you can
combine filter class and it's instances:

```ruby
blurred_effect = Banzai::Pipeline.new(GaussianBlur.new(radius:1.1), Nostalgia)
blurred_effect.call(image)
```

`Banzai::Pipeline` is just another filter, so you can mix them with filters
into a new pipeline:

```ruby
Banzai::Pipeline.new(blurred_effect, RoundCorners.new(radius:0.87))
```

## Working Example

Here's a simple working example:

```ruby
class StripFilter < Banzai::Filter
  def call(input)
    input.strip
  end
end

class UpcaseFilter < Banzai::Filter
  def call(input)
    input.upcase
  end
end

pipeline = Banzai::Pipeline.new(StripFilter, UpcaseFilter)
puts pipeline.call('    ohai ') # prints "OHAI"
```

## Contributing

Open a pull request but first make sure this is green:

    bundle exec rake

## Code status

[![Circle CI](https://circleci.com/gh/dejan/banzai.svg?style=svg&circle-token=2636aac2d1b87f82160412f7613caa76d66d59ce)](https://circleci.com/gh/dejan/banzai)

## Licence

Banzai is released under the [MIT License](https://raw.githubusercontent.com/dejan/banzai/master/MIT-LICENCE).
