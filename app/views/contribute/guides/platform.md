---
title: Platform
---

# Platform

This document provides some insight into the inner-workings of Nexmo Developer as platform and where various resources can be found.

## Contents

- [Icons](#icons)
- [Navigation Text](#navigation-text)
- [Pages and content](#pages-and-content)
- [Open API Pages](#open-api-pages)
- [Admin](#admin)
- [Search](#search)
- [Non-markdown pages](#non-markdown-pages)
- [Team listing](#team-listing)
- [Markdown Pipeline](#markdown-pipeline)
- [Webpack](#webpack)
- [Hosting](#hosting)
- [Redirects](#redirects)
- [Notices](#notices)
- [Code Examples](#code-examples)

## Icons

Icons are turned into fonts using a tool called [Icomoon](https://icomoon.io/app/).

We use a mixture of custom icons and ones made available by the packs, a backup file should be maintained so that icons can be added, removed and edited by anybody. You can find the most recent backup file at `/app/assets/fonts/nexmo-developer.json`.

## Navigation Text

The navigation is generated from the file structure of the `/_documentation` folder. The documents get their titles from the front-matter within the Markdown files themselves for example the file at `/_documentation/messaging/sms/code-snippets/send-an-sms.md` has the following front-matter:

```
---
title: Send an SMS
navigation_weight: 1
---
```

The `title` is used for both the meta `<title>` and also the navigation text.

The `navigation_weight` is used to force the order of the page within the navigation in relation to its siblings. By default pages are ordered Alphabetically by giving pages weights this default can be overridden.

Folders however don't have any document that could provide front-matter so these care configured by a configuration YAML documents:

Document | Description
--- | ---
`/config/locales/en.yml` | This file translates the directory name into the display name. For example `in-app-messaging` to `In-app Messaging`.
`/config/navigation.yml` | This file provides the `navigation_weight` for directories so that products or content types can be placed in a defined order.

> **NOTE**: Complex ordering or navigation items that share a display name.
>
> §
>
> The ordering is a flat lookup of the name. This can cause issues if two different orderings are required relating to two or more menu items with the same name. An example of this is that at the time of writing this Concepts sits as the very first and top-most element. If a product was to need a concepts section this would be forced to the top the product tree since they would both share a common name.
>
> §
>
> Although this specific issue hasn't been addressed some work has been made towards having a tree based overrides, this could allow an individual item to be overridden by specifying it's location within the document hirearchy. You can see the start of this work under `navigation_overrides` within the `/config/navigation.yml` file.

## Pages and content

Documentation pages can be created by creating a new Markdown file for the content within the `/_documentation` directory hierarchy. For existing products adding the file is sufficient enough to create new content. To create documentation for new products however requires a small update to the `DocumentationConstraint`.

You can find this at `/app/constraints/documentation_constraint.rb`. The `product` and `product_with_parent` methods supply a hash of constraints back to the router so that context can be inferred by the application. Any new products should be added to this list.

## Open API Pages

API pages use a custom Open API parser and renderer. The parser belongs to a separate dependency you can find at [https://github.com/nexmo/oas_parser](https://github.com/nexmo/oas_parser). The rendering is provided by views that can be found at `/app/views/open_api/`.

Each of the Open API pages consumes an Open API Specification 3 definition for that API. These are held in a separate repo <https://github.com/Nexmo/api-specification> and are brought into NDP as a git submodule.

The parser has been built in such a way that it has tested against several OAS definitions however full compatibility with the specification shouldn't be assumed and development work may be required to support new features as they are authored within our definitions.

## Admin

Our Admin panel uses a framework called [Active Admin](https://github.com/activeadmin/activeadmin). It is used to manage:

- Events
- Job listings
- Feedback
  - Authors
  - Resources
  - Feedbacks
- Admin Users

You should refer to the [Active Admin Docs](https://activeadmin.info/documentation.html) for any information regarding customisation.

## Search

Our search is powered by [Algolia](https://www.algolia.com/). There are indices for development, staging (including review apps) and production.

The indices are automatically refreshed on each deployment by the `refresh` Rake task. There are three Rake tasks available for performing search actions:

```
rake search_terms:algolia:clear         # Clear the index in Algolia
rake search_terms:algolia:generate      # Publish search terms to Algolia
rake search_terms:algolia:refresh       # Refresh the Algolia index
```

Searching is performed directly from the client to Algolia. Protected resources such as restricting the indices or filtering items from the knowlegebase are handled by using [Algolia's Secured API Keys](https://www.algolia.com/doc/tutorials/security/api-keys/secured-api-keys/how-to-restrict-the-search-to-a-subset-of-records-belonging-to-a-specific-user/) functionality.

The configuration object that configures the secured API key can be found in the `ALGOLIA_CONFIG` environment variable or for easier local development the `/config/algolia.yml.example` file can be renamed to `/config/algolia.yml`.

## Non-Markdown pages

Some pages including the landing, tools and community pages are not Markdown pages since they usually have more complicated layouts or database concerns.

Many of these are handled by the `StaticController`, however you can find out which controller and action is handling a particular page by running:

```
$ rails routes
```

## Team listing

The [team page](/team) lists members that are defined in the `/config/team.yml` file. Avatars are pulled from [Gravatar](http://en.gravatar.com/) giving individuals an easy way to choose their image. Lastly, the role defaults to `Developer Advocate` unless provided within the configuration.

> **Tip**: Getting new hires to add themselves onto the team page is a great way to get them setup with the basics of Nexmo Developer, process and to become familiar with deployments.

## Markdown Pipeline

Nexmo Developer has a powerful Markdown pipeline that adds additional support to Markdown providing some tools that support technical writing.

Here is a video to help explain this concept starts at 6 minutes, 58 seconds:

<iframe width="854" height="480" src="https://www.youtube.com/embed/AnvqMb1VT40?t=456" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

### Filters

Here is a quick explanation of all of the filters:

Filter | Current User Context | Type | Description
--- | --- | --- | ---
Frontmatter | No | [Implicit] | Strips frontmatter from documents
PHPInliner | No | [Implicit] | Fixes a quirk with our code parser that requires PHP code to have `<?php` at the start. This filter adds an option onto PHP code examples that makes this not required.
InlineEscape | No | [Extended] | Allows for escaping of inline code where normally the internals would be processes by the markdown. For example this isn't turned into a ``[label]`` when surrounded by two backticks.
BlockEscape | No | [Extended] | Allows for escaping of code fences where normally the internals would be processes by the markdown.
Screenshot | No | [Plugin] | Allows for screenshots be put into documentation that are captured by a headless browser so they can be easily refreshed.
Anchor | No | [Extended] | Useful for when a title changes, an explicit anchor can be added and renders a non-visible anchor link to the same content.
Audio | No | [Extended] | Used to embed audio examples using the `<audio>` element.
Tooltip | No | [Extended] | Allows for ^[Toolips](Hello world!) to be added with a markdown-style syntax.
Collapsible | No | [Extended] | Allows for collapsible and expandable content to be added with a markdown-style syntax.
TabbedExamplesFilter | Yes | [Plugin] | Pulls in code examples into multiple tabs.
TabbedContentFilter | Yes | [Plugin] | Renders markdown files into multiple tabs.
Code | No | [Plugin] | Allows for code to be pulled in as a partial.
Indent | No | [Extended] | Adds an indentation to text with a markdown-style syntax.
Modal | No | [Extended] | Adds a link that launches a modal loaded from another markdown file by using a markdown-style syntax.
JsSequenceDiagram | No | [Extended] | Adds [JS Sequence Diagrams](https://bramp.github.io/js-sequence-diagrams/) rendering in Markdown.
Partial | No | [Plugin] | Pull in another markdown file. Good for content reuse.
Techio | No | [Extended] | Pull in a [Tech.io](https://tech.io) playground widget into the document.
Tutorials | No | [Plugin] | Pull in cars linking to tutorials into the markdown document.
Language | No | [Extended] | Wraps content into a span with a `lang` attribute by using a markdown-style syntax.
Columns | No | [Extended] | Allows for basic column layout  by using a markdown-style syntax.
Markdown | No | - | Converts markdown to HTML
UserPersonalizationFilter | Yes | [Implicit] | Replaces specific keywords with a logged in users values. Can be used to inject credentials into code examples
Heading | No | [Implicit] | Automatically adds parameterized id to heading items avoiding conflicts.
Label | No | [Extended] | Adds support for [labels] by using square brackets as such ``[labels]``.
Break | No | [Extended] | Allows for breaks to be added using the ``§`` symbol. Great for § adding § new § lines § where it would normally be difficult in markdown such as in tables.
Unfreeze | No | [Implicit] | Supports several other filters that Base64 their output to prevent manipulation by other filters especially the MarkdownFilter from changing any further.
Icon | No | [Implicit] | Changes emoji into nice icons.
ExternalLink | No | [Implicit] | Automatically adds an icon and `target="blank"` to links that go off-site such as [Google](https://google.com).

## Webpack

We use [Webpacker](https://github.com/rails/webpacker) to handle JavaScript in webpack with Ruby on Rails. We use the React integration with this tool.

The JavaScript file that is loaded can be found at `/app/javascript/packs/application.js`.

Any further information on how to consume or configure this can be found in [Webpacker Usage Guide](https://github.com/rails/webpacker#usage)

## Hosting

Nexmo Developer is hosted on Heroku which auto-deploys any changes to the `master` branch on the [public repo](https://github.com/nexmo/nexmo-developer).

The EA site automatically deploys from the `private/ea` branch on the [private repo](https://github.com/nexmo/nexmo-developer-private).

Review apps can be created from the Heroku Dashboard, auto-deployment should not be enabled since it could cause a security concern if an outside authors code that dumps `ENV` variables to HTML or externally.

## Redirects

When a documentation page is not found the `Redirector` service is invoked to see if a redirection can be found. If it can it issues a redirection to the client otherwise the `404 Not Found` page is rendered.

## Notices

Notices can be added site-wide or on specific routes. Here are examples of implementing this:

### Site wide

```yaml
some-unique-id:
  content: |-
    <h4>Welcome to Nexmo Developer</h4>
    <p>We are improving our Documentation, API references, learning resources & tooling to help you more effectively use our services. We want to help you find everything you need to integrate Nexmo APIs into your code.</p>
    <p>As we start this transition, we’d love to hear from you with thoughts & suggestions. If you’ve got something, positive or negative, to tell us, please tell us using the feedback tool at the bottom of each guide or <a href="https://github.com/Nexmo/nexmo-developer/issues/new">file an issue</a> on GitHub. - Nexmo</p>
```

### Section Specific (non-dismissible)

```yaml
another-inique-id:
  dismissible: false
  path: '^\/(api\/)?new-product'
  content: |-
    <h4>Welcome to the Developer Preview for New Product</h4>
    <p>If you are interested in participating, have any questions, or feedback you can email us at <a href="mailto:new-product-support@nexmo.com">ea-support@nexmo.com</a>.</p>
```

## Code Examples

Code examples are often pulled in from other repositories using submodules - refer to the project `README` for more information.
