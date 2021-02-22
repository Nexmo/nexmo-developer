---
title: Require Dependencies
description: Require dependencies for a Vonage Ruby Voice application to stream audio
---

# Require Dependencies

Near the top of the `server.rb` file add the following `require` statements to include the dependencies in the application:

```ruby
require 'sinatra'
require 'vonage'
require 'dotenv'
require 'json'

Dotenv.load
```
