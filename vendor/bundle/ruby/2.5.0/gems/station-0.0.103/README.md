# Station: The Nexmo Developer Gem

[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-v2.0%20adopted-ff69b4.svg)](CODE_OF_CONDUCT.md)
![Actions Status](https://github.com/nexmo/nexmo-developer/workflows/CI/badge.svg)
[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](./LICENSE.txt)

Station provides a documentation platform ready to use with your custom documentation.

The [documentation for Station](https://nexmo.github.io/station) covers detailed installation, setup and configuration instructions. Please refer to the documentation as the primary resource for getting started with Station.

* [Documentation](https://nexmo.github.io/station)
* [Troubleshooting](#troubleshooting)
* [Contributing](#contributing)
* [License](#license)

## Troubleshooting

<details>
<summary>
How do I add a database to a review application?
</summary>

In the Heroku review app that you'd like a database for, visit `More -> Run Console` then run the following command:

```bash
cd lib/nexmo_developer/ && bin/rails db:migrate
```
</details>

<details>
<summary>
What do I do if I encounter the ActionView::Template::Error: Webpacker can't find application.js error?
</summary>
    
From the command line execute the following from within the `lib/nexmo_developer` folder in Station changing the paths for your local file paths to the API specification and documentation files:

```bash
rm -rf public/packs &&  DOCS_BASE_PATH=/path/to/docs RAILS_SERVE_STATIC_FILES=1 DISABLE_SSL=1 RAILS_LOG_TO_STDOUT=1 OAS_PATH=/path/to/oas/specs RAILS_ENV=production bundle exec rails assets:precompile --trace
```
</details>


## Contributing

We :heart: contributions from everyone! It is a good idea to [talk to us](https://nexmo-community-invite.herokuapp.com/) first if you plan to add any new functionality. Otherwise, [bug reports](https://github.com/Nexmo/nexmo-developer/issues/), [bug fixes](https://github.com/Nexmo/nexmo-developer/pulls) and feedback on the library is always appreciated. Look at the [Contributor Guidelines](CONTRIBUTING.md) for more information and please follow the [GitHub Flow](https://guides.github.com/introduction/flow/index.html).

## [![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/dwyl/esta/issues) [![GitHub contributors](https://img.shields.io/github/contributors/Nexmo/nexmo-developer.svg)](https://GitHub.com/Nexmo/nexmo-developer/graphs/contributors/)

## License

This library is released under the [MIT License][LICENSE]

[signup]: https://dashboard.nexmo.com/sign-up?utm_source=DEV_REL&utm_medium=github&utm_campaign=nexmo-developer
[license]: LICENSE.txt
