---
title: Tutorials and Use Cases
navigation_weight: 5
---

# Tutorials and Use Cases

Our documentation allows for three different types of "how-to" content:

* Code snippets
* Tutorials
* Use cases

If you just want to show a bit of sample code that demonstrates to a reader how to perform a single task, then you need a [code snippet](/contribute/structure/content-types/code-snippets).

If you want to teach a reader how to build something, then you'll need either a **Tutorial** or a **Use Case**. This page will help you decide which of those two formats is right for your content.

## Characteristics of a Tutorial

Tutorials demonstrate how to complete a specific, well-defined task, using a step-by-step format. They nearly always involve a single product.

If all of the following apply, then use the Tutorial format:

* You want to show the user how to create a simple application from scratch using one or more of our SDKs (Tutorials support multiple languages)
* You will guide them through the process step-by-step
* You are focusing on a single Vonage API
* You do not rely heavily on third party APIs or frameworks that you cannot reasonably assume that our readers will be proficient in

### Tutorial examples:

* See [Sending a Facebook message with Failover](/dispatch/tutorials/send-facebook-message-with-failover/introduction) for an example of a single-language tutorial.
* See [Creating a chat app](/client-sdk/tutorials/in-app-messaging/introduction) for an example of a multi-language tutorial.


## Characteristics of a Use Case

While Tutorials provide step-by-step instructions on how to do specific things with one product, Use Cases describe far more complex scenarios, that may use several Vonage API products, and optionally products from other vendors.

Use Cases do not have to provide a step-by-step approach, although sometimes they do. Tutorials always use the step-by-step approach.

If several of the following apply, then consider the Use Case format:

* You have a demo app that you want to show our readers and then break it down to explain how it works
* You are demonstrating the basis of a "real world" application that someone might actually want to build
* You might focus on a single Vonage API, or use multiple APIs to build it
* You rely on third party frameworks or solutions and will link to suitable tutorials and other information on the vendors' sites to help your readers learn more about them beyond what you cover in your use case

### Use Case examples

* [Order Support System](/use-cases/client-sdk-sendinblue-order-confirm) - A Use Case demonstrating Conversation API, Client SDK and SendInBlue API for email. This describes implementing an Order Support System scenario.
* [Transcribe a recorded call with Amazon Transcribe](/use-cases/trancribe-amazon-api) This use case relies heavily on Amazon Web Services (AWS) to transcribe calls recorded by the Voice API.


## Building your Tutorial or Use Case

Once you have decided on the appropriate format, you should first learn how to structure the content of your Tutorial or Use Case:

* [Tutorial structure](/contribute/structure/content-types/tutorials)
* [Use Case structure](/contribute/structure/content-types/use-cases)

Then, see the appropriate guide to learn how to add your new Tutorial or Use Case to our documentation platform:

* [Creating a Tutorial](/contribute/tutorials-and-use-cases/tutorials)
* [Creating a Use Case](/contribute/tutorials-and-use-cases/use-cases)