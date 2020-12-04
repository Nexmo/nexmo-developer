# Nexmo Markdown Renderer

![Build Status](https://github.com/Nexmo/nexmo-markdown-renderer/workflows/CI/badge.svg)
[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](./LICENSE.txt)

This gem facilitates the presentation of markdown documents in a Rails app by applying custom filters for tabs, code snippets, icons, indentation and more. It is used in the [Nexmo Developer Platform](https://developer.nexmo.com).

* [Installation and Usage](#installation-and-usage)
* [Contributing](#contributing)
* [License](#license)

## Installation and Usage

To use this gem you must install it in your application's Gemfile:

```ruby
gem 'nexmo-markdown-renderer'
```

Then run `bundle install` to install it.

The gem requires an environment variable to be set of `DOCS_BASE_PATH` that should point to the top level directory of your markdown content to be rendered. For example:

```
DOCS_BASE_PATH = '/path/to/markdown`
```

Once you have installed it, you can use it by instantiating an instance of it by passing in the options you require:

```ruby
content = Nexmo::Markdown::Renderer.new()
```

Once you have instantiated an instance, you can then invoke the `#call` method with the markdown you wish to render. You can either point to a file or pass in the markdown directly:

Passing in the markdown directly:

```ruby
rendered = content.call( "with markdown" )
```

Passing in a markdown file:

```ruby
rendered = content.call("/_documentation/example/example_markdown.md")
```

## Contributing

We ❤️ contributions from everyone! [Bug reports](https://github.com/Nexmo/nexmo-markdown-renderer/issues), [bug fixes](https://github.com/Nexmo/nexmo-markdown-renderer/pulls) and feedback on the gem is always appreciated. Look at the [Contributor Guidelines](https://github.com/Nexmo/nexmo-markdown-renderer/blob/master/CONTRIBUTING.md) for more information.

## License

This project is under the [MIT LICENSE](https://github.com/Nexmo/nexmo-markdown-renderer/blob/master/LICENSE.txt)
