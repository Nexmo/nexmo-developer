---
title: "Getting Started"
permalink: /Getting-Started
---

# Contents

1. [Dependencies](#dependencies)
2. [Booting Up For the First Time](#booting-up-for-the-first-time)

## Dependencies

Station is a platform tool built with Ruby on Rails. All of its attendant dependencies are managed internally and require only itself to be included as a dependency for installation.

Either within the top-level folder of the content to be served or in a separate folder structure create a `Gemfile` and include the following in it:

```ruby
source "https://rubygems.pkg.github.com/nexmo" do
  gem "nexmo-developer"
end
```

Station is hosted on the GitHub Package registry, and requires its own credentials to be added to your system to download the package from it. The GitHub Package Registry documentation includes [step-by-step instructions](https://help.github.com/en/packages/using-github-packages-with-your-projects-ecosystem/configuring-rubygems-for-use-with-github-packages) on setting up your system to authenticate to the registry if it is the first time downloading a package from the registry.

Once the `Gemfile` is completed, Station can be downloaded and installed locally by executing `bundle install` from the command line. 

## Booting Up For The First Time

Station requires a certain defined file structure in the content file path provided to the CLI when booting it up. Please refer to the [How To Use](How-To-Use.md#configuration-files) page for detailed instructions. Without this file structure, Station will not run correctly.

To start Station the following command can be executed from the command line, replacing `/content/path` with the absolute file path to your content:

```bash
$ bundle exec nexmo-developer --docs=/content/path
```

For troubleshooting diagnosis you can turn on logging output to the console by prepending `RAILS_LOG_TO_STDOUT=true` to the command. This can also be defined permanently in a dotenv file in the top-level folder of your content.

Station is also available as a Docker image. Please refer to the [How To Use](How-To-Use.md#running-with-docker) page for instructions on booting it up with Docker.
