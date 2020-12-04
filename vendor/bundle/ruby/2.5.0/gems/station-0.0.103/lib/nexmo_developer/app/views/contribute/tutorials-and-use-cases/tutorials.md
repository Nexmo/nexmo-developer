---
title: Creating a Tutorial
navigation_weight: 1
---

# Tutorials

Step-by-step procedures are documented using tutorials in Nexmo Developer. This topic describes how to create a new tutorial.

> **Wait!** Are you sure that a Tutorial is the right format for what you want to achieve? Please read our [Tutorials and Use Cases guide](/contribute/guides/tutorials-and-use-cases)

Tutorials support multiple programming languages. You can select the language you require from the list provided.

## Directory structure

Tutorials have a specific directory layout for content. The whole tutorial structure is driven by a root configuration file, which is described in more detail later in this topic. If your tutorial is called `my-tutorial` you would create a file called `my-tutorial.yml`. Configuration files are located in `config/tutorials`. Content files are located in `_tutorials`.

### Configuration files

```
config/tutorials/en/product/my-tutorial/my-tutorial.yml
```

Note that tutorials may be organized on a per-product basis. In the previous example `product` might be `voice-api` or `client-sdk` for example. This structure is preferable but optional.

If you have steps in the tutorial that are specific to other languages these would also have driver configuration files:

```
config/
  tutorials/
    en/
      product/
        my-tutorial.yml
        my-tutorial/
          javascript.yml
          python.yml
          kotlin.yml
```

As shown there can be a generic 'driver' file to define the order of the steps, or you can have language specific driver files that define the sequence of steps for a specific language. For example, `javascript.yml` would define the steps for a JavaScript-specific version of the tutorial.

### Content files

The content files pointed to by the configuration files are located in a separate directory structure. The root directory is `_tutorials/en`. For the example here your content would be located in `_tutorials/en/my-tutorial`:

```
_tutorials/en/
  step-a.md
  step-b.md
  product/
    step-c.md
    step-d.md
    my-tutorial/
      step-e.md
      step-f.md
      step-g/
        python.md
        kotlin.md
      step-h/
        javascript.md
```

You may also have steps that are specific to a programming language, such as Python. In this case you would locate language specific steps in a subfolder for that step. In the previous example:

* Steps `step-a` and `step-b` are shared across all tutorials.
* Steps `step-c` and `step-d` are shared across all tutorials of the product `product`.
* Steps `step-e` and `step-f` are specific to `my-tutorial`.
* Steps `step-g` contains language-specific versions of the step, although some steps may only be required for a single language.
* Step `step-h` is only relevant for JavaScript.

Remember that all steps are referenced from the configuration file in the step-order they are to be displayed in the rendered tutorial.

## Tutorial config file

Tutorial configuration files are located in `config/tutorials` and the name of the file is used as the name of the tutorial in the URL.

For example, the configuration for `https://developer.nexmo.com/client-sdk/tutorials/in-app-messaging` is located in `config/tutorials/en/in-app-messaging/*.yml`. The contents of the JavaScript config file is shown here:

```yaml
title: Creating a web-based chat app
description: Create a web application that enables users to message each other
products:
  - client-sdk

introduction:
  title: Introduction to this task
  description: This task shows you how to create a web chat application using the JavaScript Client SDK.
  content: |
    # Introduction
    In this task, you will learn how to create and configure a Client SDK Application and then code a web app that enables two users to send messages to each other.

    First, you will create a Conversation and two Users. Then, you will authenticate these Users and add them to the Conversation as Members.

    Finally, you will implement chat functionality in your application, including the ability to view and send messages and be notified when either party is currently typing.

    The source code is available [on GitHub](https://github.com/nexmo-community/ip-messaging-tutorial).

prerequisites:
  - create-nexmo-account
  - install-nodejs
  - install-nexmo-cli-beta
  - install-node-client-sdk
  - run-ngrok

tasks:
  - client-sdk/create-application
  - client-sdk/create-conversation
  - client-sdk/create-users
  - client-sdk/in-app-messaging/add-users-to-conversation
  - client-sdk/generate-jwts
  - client-sdk/in-app-messaging/create-ui
  - client-sdk/in-app-messaging/authenticate-users
  - client-sdk/in-app-messaging/join-conversation
  - client-sdk/in-app-messaging/show-message-history
  - client-sdk/in-app-messaging/send-message
  - client-sdk/in-app-messaging/typing-indicators
  - client-sdk/in-app-messaging/run-application

conclusion:
  title: What's next?
  description: What else can you do with the Client SDK?
  content: |

    # What's next?
    You can do a lot more with the Client SDK.

    We want to hear what ideas you have in mind? Contact us at <a href="mailto:devrel@vonage.com">devrel@vonage.com</a>

    See [Client SDK documentation](/client-sdk/overview).
```

You see the `prerequisites` section which is a list of files that provide Markdown content for each of the prerequisites list:

![Prerequisites](/assets/images/contributing/prereqs.png)

Clicking on any prerequisite displays the content.

The main steps of the tutorials are defined in the `tasks` section. This is a list of subtasks, or steps, that are combined to produce a single parent tutorial.

Each of these files live in the `_tutorials` folder and are written using Markdown. For example `client-sdk/create-application` is located in `_tutorials/client-sdk/create-application.md` with the following contents:

```yaml
---
title: Create a Nexmo Application
description: In this step you learn how to create a Nexmo Application.
---

# Create your Nexmo Application

...
```

## Content reuse

The idea behind having standalone step files is that you can define each task once, such as for create application, and then reference it in every tutorial that requires it.

Being able to reuse content in this way leads to far greater consistency, more rapid documentation development, and ease of maintenance.

## Adding more context

Although you want as much content reuse as possible, each step you want a customer to perform will need some context. To provide this, you can define an `introduction` and `conclusion` in a tutorial config file (`config/tutorials/tutorial-name.yml`):

```yaml
title: Creating a web-based chat app
description: Create a web application that enables users to message each other
products:
  - client-sdk

introduction:
  title: Introduction to this task
  description: This task shows you how to create a web chat application using the JavaScript Client SDK.
  content: |
    # Introduction
    In this task, you will learn how to create and configure a Client SDK Application and then code a web app that enables two users to send messages to each other.

    First, you will create a Conversation and two Users. Then, you will authenticate these Users and add them to the Conversation as Members.

    Finally, you will implement chat functionality in your application, including the ability to view and send messages and be notified when either party is currently typing.

    The source code is available [on GitHub](https://github.com/nexmo-community/ip-messaging-tutorial).

...

conclusion:
  title: What's next?
  description: What else can you do with the Client SDK?
  content: |

    # What's next?
    You can do a lot more with the Client SDK.

    We want to hear what ideas you have in mind? Contact us at <a href="mailto:devrel@vonage.com">devrel@vonage.com</a>

    See [Client SDK documentation](/client-sdk/overview).
```

This content is provided directly in the tutorial configuration file as it is specific to the current tutorial and is not intended to be reused. Remember if you have language-specifc tutorials there will be one configuration file for each supported language.
