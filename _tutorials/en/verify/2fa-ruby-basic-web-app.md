---
title: Create the basic application
description: Download the basic web application from GitHub
---

# Create the basic application

In this step, you will install the code you will use as the starting point for this tutorial.

The application is a fictional social network site called Kittens and Co. It currently enables you to register with a user name and password but you will improve it to support two-factor authentication (2FA) for added security.

First, ensure that you have Ruby and `bundler` installed by running:

```sh
ruby --version
bundler --version
```

Then, clone the tutorial application from its GitHub repository and run it locally:

```sh
git clone https://github.com/nexmo-community/nexmo-rails-devise-2fa-demo.git
cd nexmo-rails-devise-2fa-demo
bundle install
rake db:migrate RAILS_ENV=development
rails server
```

At this point you can start the app, register for an account with a user name and password and log in and out. The application implements registration and login using [Devise](https://github.com/heartcombo/devise) but most of this tutorial applies similarly to applications that use other authentication methods. Additionally, the application uses the `bootstrap-sass` and `devise-bootstrap-templates` gems for styling.

The next step is to add two-factor authentication to the registration and login process.

All the code you need to complete this tutorial is on the `basic-login` branch. The completed code is on the `two-factor` branch.

Ensure that you are on the `basic-login` branch before continuing. You can display the current branch in `git` by running:

```sh
git rev-parse --abbrev-ref HEAD
```

Switch branches if necessary by executing:

```sh
git checkout basic-login
```

