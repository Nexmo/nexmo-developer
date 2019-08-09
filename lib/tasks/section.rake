require 'yaml'
namespace :section do
  desc 'Bootstrap a new section'
  task create: :environment do
    ARGV.each { |a| task a.to_sym }
    section_name = ARGV[1]
    current_dir = Dir.pwd
    slug = section_name.parameterize

    base_url = "#{current_dir}/_documentation/#{slug}"

    if File.exist? base_url
      warning = "The section '#{section_name}' already exists. Stopping generation"
      puts warning.colorize(:red)
      next
    end

    # Create our folders
    FileUtils.mkdir_p base_url
    FileUtils.mkdir_p "#{base_url}/code-snippets"
    FileUtils.mkdir_p "#{base_url}/guides"

    # Create some placeholder content
    File.write("#{base_url}/overview.md", overview_content(section_name, slug))
    File.write("#{base_url}/api-reference.md", api_reference_content)
    File.write("#{base_url}/code-snippets/block-title.md", code_snippet_content(section_name, slug))
    File.write("#{base_url}/guides/guide-title.md", guide_content(section_name, slug))

    # Create the initial translation for the sidebar
    locale_path = "#{current_dir}/config/locales/en.yml"
    locale = YAML.load_file(locale_path)
    locale['en']['menu'][slug] = section_name
    File.write(locale_path, locale.to_yaml)

    # Create the redirect from /{section_name} to /{section_name}/overview
    redirect_path = "#{current_dir}/config/redirects.yml"
    redirect = YAML.load_file(redirect_path)
    redirect["/#{slug}"] = "/#{slug}/overview"
    File.write(redirect_path, redirect.to_yaml)
  end
end

def overview_content(section_name, slug)
  <<~HEREDOC
    ---
    title: Overview
    ---

    # Overview

    Nexmo's #{section_name} API allows you to...

    * Selling point one
    * Selling point two
    * Selling point three

    ## Contents

    In this document you can learn about:

    * [Nexmo #{section_name} Concepts](#concepts)
    * [How to Get Started with the #{section_name} API](#getting-started)
    * [Code Snippets](#code-snippets)
    * [Guides](#guides)
    * [Use Cases](#use-cases)
    * [Reference](#reference)

    ## Concepts

    * [Title](/url/goes/here)

    ## Getting Started

    * [Title](/url/goes/here)

    ## Code Snippets

    * [Title](/url/goes/here)

    ## Guides

    * [Title](/url/goes/here)

    ## Tutorials

    * [Title](/url/goes/here)

    ## Reference

    * [#{section_name} API Reference](/api/#{slug})

  HEREDOC
end

def code_snippet_content(section_name, slug)
  <<~HEREDOC
    ---
    title: Snippet Title
    description: How do to this cool thing with the Nexmo #{section_name} API
    navigation_weight: 1
    ---

    # Title Goes Here

    The #{section_name} API is great. So great that we're going to show you how
    it works right now!

    Sign up for an account and replace the following variables in the example below:

    Key |	Description
    -- | --
    `TO_NUMBER` |	The number you are sending a #{section_name} to in E.164  format. For example `447700900000`.
    `NEXMO_API_KEY` | You can find this in your account overview
    `NEXMO_API_SECRET` | You can find this in your account overview

    ```tabbed_content
    source: '_examples/#{slug}/code-snippet-name-here'
    ```
  HEREDOC
end

def guide_content(section_name, _slug)
  <<~HEREDOC
    ---
    title: #{section_name} Guide Title
    ---

    # #{section_name} Guide Here

    This is a placeholder page. Please update it with real content or delete this
    file
  HEREDOC
end

def api_reference_content
  <<~HEREDOC
    ---
    title: API Reference
    ---

    # API Reference

    This page is never rendered, it is used as a placeholder to generate
    the necessary navigation item.
  HEREDOC
end
