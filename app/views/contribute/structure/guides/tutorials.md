---
title: Tutorials
navigation_weight: 4
---

# Tutorials

Tutorials are complete example of how to build something practical. They are step-by-step and self-contained providing all necessary content inline and may combine many different products. They usually cover a single specific use case.

## Opening

Explain what the problem is and outline the steps that you'll take to overcome it in bullet points.

> Note: The opening has no heading as the heading should serve this purpose.

## Guide

Every tutorial has its own problem to solve. Use headings and sections that align with the steps one would take to overcome the problem.

## Conclusion

Reflect on:

* What you have done
* How you could extend on what you have learnt

Point to resources:

* Guides - Guides covering the concepts used in the tutorial.
* Code Snippets - cover specific bits of code to do single function operations.
* API Reference - Given that the tutorial is opinionated, provide this as a resource to allow the user to see what other options are available to them.
* Tutorials - Other relevant tutorials.

## External Tutorials

We can include tutorial entries for content that is actually elsewhere, such as on the blog. This is useful for bringing Tutorial Tuesday content and X with Y posts into the developer portal so that users can find other content that may be of interest.

To create an external tutorial, create a markdown file with _just_ frontmatter. It should look something like this:

```
---
title: Anything-to-SMS with IFTTT and Nexmo
products: messaging/sms
description: This is a description that will be shown on the tutorials list page
external_link: https://www.nexmo.com/blog/2018/09/18/anything-to-sms-ifttt-nexmo-dr/
languages:
    - Node
---
```

These will be rendered as tutorials in the tutorial listing pages, but when clicked the user will go to the original source of the content.
