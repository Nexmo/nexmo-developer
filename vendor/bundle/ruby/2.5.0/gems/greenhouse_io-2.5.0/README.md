# Greenhouse IO

[![Gem
Version](https://badge.fury.io/rb/greenhouse_io.png)](http://badge.fury.io/rb/greenhouse_io)
[![Build Status](https://travis-ci.org/grnhse/greenhouse_io.svg?branch=master)](https://travis-ci.org/grnhse/greenhouse_io)
[![Test Coverage](https://codeclimate.com/github/grnhse/greenhouse_io/badges/coverage.svg)](https://codeclimate.com/github/grnhse/greenhouse_io/coverage)
[![Dependency Status](https://gemnasium.com/grnhse/greenhouse_io.svg)](https://gemnasium.com/grnhse/greenhouse_io)

A Ruby interface to
[Greenhouse.io's](https://app.greenhouse.io/jobboard/jsonp_instructions)
API (requires Ruby 1.9.3 or greater).

## Installation

Add the gem to your application's Gemfile:

    gem 'greenhouse_io'

Or install it yourself as:

    $ gem install

## API Documentation

Documentation for the Harvest and Job Board web APIs can be found at [developers.greenhouse.io](https://developers.greenhouse.io).
    
## Configuration

You can assign default configuration values when using this gem.  
Here is an example `config/initializers/greenhouse_io.rb` file used in a Rails application:

```ruby
GreenhouseIo.configure do |config|
	config.symbolize_keys = true # set response keys as strings or symbols, default is false
	config.organization = 'General Assembly'
	config.api_token = ENV['GREENHOUSE_API_TOKEN']
end
```

## Usage

Greenhouse's two APIs, **[Harvest](https://app.greenhouse.io/configure/dev_center/harvest)** and **[Job Board](https://app.greenhouse.io/configure/dev_center/api_documentation)**, can now be accessed through the gem. The [`GreenhouseIo::JobBoard`](#greenhouseiojobboard) is nearly identical to the old `GreenhouseIo::API` class. [`GreenhouseIo::Client`](#greenhouseioclient) connects to the new Harvest API.

### GreenhouseIo::JobBoard

Creating an instance of the JobBoard client:
```ruby
gh = GreenhouseIo::JobBoard.new("api_token", organization: "your_organization")
```

If you've configured the gem with a default `organization` and `api_token`, then you can just instantiate the class.
```ruby
gh = GreenhouseIo::JobBoard.new
```

`api_token` is only required for `#apply_to_job` and `organization` is also optional during initialization if an organization is passed in during method requests.

#### Fetching Office Data
```ruby
gh.offices
gh.offices(organization: 'different_organization')
# returns a hash containing all of the organization's department and jobs grouped by office
```

```ruby
gh.office(id)
gh.office(id, organization: 'different_organization')
# returns a hash containing the departments and jobs of a specific office
```

#### Fetching Department Data
```ruby
gh.departments
gh.departments(organization: 'different_organizaton')
```

```ruby
gh.department(id)
gh.department(id, organization: 'different_organization')
```

#### Fetching Job Data
```ruby
gh.jobs
gh.jobs(content: 'true')
# includes the job description in the response
gh.jobs(organization: 'different_organization')
```

```ruby
gh.job(id)
gh.job(id, questions: true)
# returns the specified job and the array of questions on the application
gh.job(id, organization: 'different_organization')
```

#### Submitting a Job Application
This is the only API method that **requires** an API token from Greenhouse
```ruby
gh.apply_to_job(form_parameter_hash)

# form_parameter_hash should match the questions array of a given job opening
# there should be a hidden input with name id in your form that
# has the value of the job ID on Greenhouse.io
```

### GreenhouseIo::Client

Creating an instance of the API client:
```ruby
gh_client = GreenhouseIo::Client.new("api_token")
```

If you've configured the gem with a default `api_token`, then you can just instantiate the class.
```ruby
gh_client = GreenhouseIo::Client.new
```

#### Listing candidates

```ruby
gh_client.candidates
```

#### Creating a candidate note
Use this method to attach a new note to a candidate.

```ruby
candidate_id = 4567
author_id = 123 # ID of the user who wrote this note
note = {
  :user_id => 123,
  :message => "This candidate has very strong opinions about Node.JS.",
  :visibility => "public"
}

gh_client.create_candidate_note(candidate_id, note, author_id)
```

#### Throttling

Rate limit and rate limit remaining are available after making an API request with an API client:

```ruby
gh_client.rate_limit # => 20
gh_client.rate_limit_remaining  # => 20
```

#### Pagination

All `GreenhouseIo::Client` API methods accept `:page` and `:per_page` options to get specific results of a paginated response from Greenhouse.

```ruby
gh_client.offices(id, page: 1, per_page: 2)
```

You can determine the last page and next page by looking at the `link` header from the last response:

```ruby
gh_client.link

# => '<https://harvest.greenhouse.io/v1/candidates?page=2&per_page=100>; rel="next",<https://harvest.greenhouse.io/v1/candidates?page=142&per_page=100>; rel="last"'
```

You'll need to manually parse the `next` and `last` links to tell what the next or final page number will be.

#### Available methods

Methods for which an `id` is optional:

* `offices`
* `departments`
* `candidates`
* `applications`
* `jobs`
* `users`
* `sources`
* `all_scorecards`
* `offers`

Methods for which an `id` is **required**:

* `activity_feed` *(requires a candidate ID)*
* `scorecards` *(requires an application ID)*
* `scheduled_interviews` *(requires an application ID)*
* `offers_for_application` *(requires an application ID)*
* `current_offer_for_application` *(requires an application ID)*
* `stages` *(requires a job ID)*
* `job_post` *(requires a job ID)*
* `create_candidate_note` *(requires a candidate ID)*

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Contributions are always welcome!