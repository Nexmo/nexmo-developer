# clipboard-rails
[![Gem Version](https://badge.fury.io/rb/clipboard-rails.svg)](http://badge.fury.io/rb/clipboard-rails)

clipboard-rails gem is the integration of clipboard.js javascript library for your Rails 4 and Rails 5 applications.

clipboard.js is a modern approach to copy text to clipboard No Flash. No dependencies. Just 2kb
source: https://github.com/zenorocha/clipboard.js

Ruby gems url: https://rubygems.org/gems/clipboard-rails

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'clipboard-rails'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install clipboard-rails

Note: After adding the gem to your gem file and running the bundle, restart rails server.

Now you need to edit your `app/assets/javascripts/application.js` file and add the following line:
``` javascript
//= require clipboard
```

## Usage

Here is the example working code to test with your Rails application.

Add this sample code to your `app/assets/javascripts/application.js` file

``` javascript
$(document).ready(function(){  
  
  var clipboard = new Clipboard('.clipboard-btn');
  console.log(clipboard);
	
});
```

*Note:* Here i am using `gem 'jquery-turbolinks'` for using the jquery $(document).ready function 

Add this sample code to your template file like `index.html.erb`

``` html
<!-- Target -->
<textarea id="bar">Mussum ipsum cacilds...</textarea>

<!-- Trigger -->
<button class="clipboard-btn" data-clipboard-action="copy" data-clipboard-target="#bar">
    Copy to clipboard
</button>
```
## Additional information

Additionally, you can define a **data-clipboard-action** attribute to specify if you want to either **copy** or **cut** content.

If you omit this attribute, **copy** will be used by default.

## Full documentation 

Read the clipboard.js documentation here http://zenorocha.github.io/clipboard.js/ for full usage information.


## Add Tooltips + Highlight animation: 

Add Tooltips + Highlight animation with Clipboard.js on button click using Bootstrap Tooltip

``` javascript

// Tooltip

$('.clipboard-btn').tooltip({
  trigger: 'click',
  placement: 'bottom'
});

function setTooltip(btn, message) {
  $(btn).tooltip('hide')
    .attr('data-original-title', message)
    .tooltip('show');
}

function hideTooltip(btn) {
  setTimeout(function() {
    $(btn).tooltip('hide');
  }, 1000);
}

// Clipboard

var clipboard = new Clipboard('.clipboard-btn');

clipboard.on('success', function(e) {
  setTooltip(e.trigger, 'Copied!');
  hideTooltip(e.trigger);
});

clipboard.on('error', function(e) {
  setTooltip(e.trigger, 'Failed!');
  hideTooltip(e.trigger);
});
```

``` html
<!-- Example 1: Animation with single button HTML source-->
<button class="clipboard-btn btn btn-primary" data-clipboard-text="It worked!">Click me</button>

```

``` html
<!-- Example 2: with Target source -->
<textarea id="bar">Mussum ipsum cacilds...</textarea>

<!-- Trigger -->
<button class="clipboard-btn" data-clipboard-action="copy" data-clipboard-target="#bar">
    Copy to clipboard
</button>
```



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sadiqmmm/clipboard-rails. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

