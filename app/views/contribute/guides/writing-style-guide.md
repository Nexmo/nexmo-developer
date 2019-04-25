---
title: Writing Style Guide
navigation_weight: 2
---

# Writing Style Guide

These are technical writing guidelines that can be used across all Nexmo technical documentation as well as blog posts.

These guidelines are designed to improve clarity and consistency. Some of the benefits of writing in this style are:

* Easier to read and understand, especially for readers whose first language is not English.
* More professional appearance.
* Easier to translate.

As with most guidelines these are suggestions, not hard and fast rules. Use your best judgement.

## Use present tense

Use present tense. It’s easier to read and translate.

Examples:

* *Future:* Command X will start the server.
* *Present:* Command X starts the server.

## Use simple language

Use clear, simple, and direct language. Avoid flowery and verbose writing styles.

* Avoid filler words and superfluous adjectives 'really nice feature', 'easily', ‘simple’, 'just', 'please', 'it may be that', 'and that's it'.
* Avoid subjective phrases. "You can easily...". "It is simple to...".

## Use active voice

Use active voice. In active voice the *Subject* *Verbs* the *Object*. Remember SVO.

Examples:

* *Active voice:* The man ate the apple.
* *Passive voice:* The apple was eaten by the man.
* *Active voice:* The NCCO controls the call.
* *Passive voice:* The call is controlled by the NCCO.
* *Active voice:* Nexmo provides a Messages API.
* *Passive voice:* A Messages API is provided by Nexmo.

Active voice leads to text that is simpler and more direct, and is easier to translate.

## Paragraph breaks

In technical writing, and especially blog posts, you can be a little more generous with your use of paragraph breaks. Paragraph breaks make the text less overwhelming and easier to read.

## Avoid vague and cautious language

Avoid words like would, should, might and so on.

Example:

* *Avoid:* If you run the Nexmo CLI with no parameters you might see some text, or possibly an error, or something!
* *Better:* If you run the Nexmo CLI without specifying parameters a help message is displayed.

## Use second person

Use 'you' rather than 'we' when referring to the reader.

Example:

* *Avoid:* We now need to enter an API Key.
* *Better:* You now need to enter an API Key.
* *Avoid:* We can now click the button to register our Nexmo Number.
* *Better:* You can now click the button to register your Nexmo Number.
* *Best:* Click the button to register your Nexmo Number.

Use Nexmo rather than 'we' when referring to the company.

Example:

* *Avoid:* We also provide an SMS API.
* *Better:* Nexmo also provides an SMS API.

## Use American English

The company standard is, as with most software companies, to use American English.

The industry standard dictionary is [Merriam Webster](https://www.merriam-webster.com/).

## Avoid Latin phrases and slang

Latin phrases and abbreviations can sometimes cause confusion. They can also be less convenient to translate.

Examples:

* Use ‘for example’, instead of 'e.g.' and 'that is' rather than 'i.e.'.
* Don't use words like 'crash', use 'error'. Use 'launch' or 'start' rather than 'fire up'.
* Bear in mind the reader’s first language may not be English.
* Mouse is clicked and keyboard is pressed. Avoid terms such as 'hit' when referring to the keyboard.

## Headings

Try to be consistent with capitalization of headings. You can follow these guidelines:

* Use title case (also sometimes known as word case as significant words are capitalized) for top-level topics and sections. For example, 'Code Snippets', 'Guides', 'Markdown Guide', 'Writing Style Guide', 'Installation Guide', 'Messages and Dispatch API'.
* Use sentence case for topic titles below a top-level section. For example, 'This is the topic title'. The exception to this is if the heading references a top-level section. For example, 'How to use the Getting Started Guide', as Getting Started Guide is a top-level section in this example.
* Use sentence case for sub-section headings. For example, 'This is a sub-section heading'.

There is no need to capitalize minor words in headings. For example:

* *Avoid:* Messages And Dispatch API.
* *Better:* Messages and Dispatch API.

Always capitalize words that would normally be capitalized. For example:

* *Avoid:* How to send an sms
* *Better:* How to send an SMS

The following shows an example of correct heading case:

```
Getting Started Guide (top-level topic)
  Overview
    Concepts
    How to send an SMS
    How to use the Installation Guide

Installation Guide
  Configure your Dashboard
  Install the client library
    How to install the Node library
      Clone the source code from GitHub (sub-section heading, not visible in TOC)
    How to install the Python library
      Clone the source code from GitHub (sub-section heading, not visible in TOC)
  Test the installation
```

Another example demonstrates correct heading case:

```
Code Snippets  (main section)
  Before you begin
  Connect an inbound call
  Download a recording
  Earmuff a call
  Handle user input with DTMF
  ...
```

## Blog article titles

For Nexmo developer blog article titles, use title case. Blog article sub-headings should also use title case.

You can refer to [these guidelines](https://www.bkacontent.com/wp-content/uploads/2015/10/Rules-of-AP-Title-Case.png) on using title case.

## Bulleted lists

This is an example of a bulleted list:

* Precede a list with a sentence and a colon.
* Terminate each sentence in a list with a full stop.
* Use bulleted lists for lists.
* Use numbered lists for ordered sequences (procedures, tasks and so on).

Note the following points:

* The list has a piece of text introducing the list followed by a colon.
* Each item in the list is terminated by a full-stop (period).
* If each item in the list is a single word a terminating period is not required.

## Codeblocks

When inserting codeblocks for example code in the text:

* Specify the coding language where possible.
* Break the text before a codeblock with a colon, not a period (which is a hard stop in the mind of the reader, rather than a continuation).
* There should not be a space before the colon.

## Acronyms

Define acronyms before first use. On subsequent use on a page/section you do not need to redefine the acronym.

## Be explicit

Try to be explicit, that is use precise terms where necessary to improve clarity and avoid ambiguity.

Some examples are given here:

* Using 'Nexmo Number' rather than 'number'.
* Using 'Nexmo Application' rather than 'application' (where appropriate).
* Using 'web application' rather than 'application' (where appropriate).
* Using 'webhook URL' rather than 'endpoint' or 'callback URL'.
* Using Nexmo Client Library rather than 'library'.
* Using Nexmo Command Line Interface, or Nexmo CLI, rather than 'command line'.

## Avoid using 'he or she' constructs

Avoid "He or she" (use user/developer/caller as appropriate). Do not replace 'he or she' by 'they'.

Example:

* *Avoid:* The user answers the phone and then he or she hears a voice.
* *Avoid:* The user answers the phone and then they hear a voice.
* *Better:* The user answers the phone and then the user hears a voice.
* *Best:* The user answers the phone and then hears a voice.

## Miscellaneous

Some additional points to bear in mind:

* Explain to the reader *why* they need a particular feature and not just what the feature is.
* Avoid statements that predict the future, for example, "the next version will have feature X". There are good legal reasons for avoiding predicting the future.
* Avoid time sensitive information. Specify an exact version where possible, for example '1.1', rather than 'current version' as the current version may change.
* Avoid using ampersand ('&') instead of 'and', unless you are specifying a programming language operator or similar.
* "It's" _always_ means 'it is'.

## Replaceable values

When working with keys, phone numbers, or accounts be clear where values should be replaced by customer-specific values. 

Key | Markdown Value | Rendered Value  <small>(if different)</small>
-- | -- | --
Timestamp | `2020-01-01 12:00:00` | -
ISO8601 Timestamp | `2020-01-01T12:00:00.000Z` | -
Epoch | `1577880000` | -
HTTP Method | ``[GET]`` or ``[POST]`` | [GET] or [POST]
HTTP Response | `` `200 OK` `` or §§ `` `404 Not Found` `` | `200 OK` or §§ `404 Not Found`
Balance | `3.14159` | -
Latency | `3000` | -
UUID | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | -

## Numbers

When use of a real phone number can't be avoided, for example when listing out the result of `nexmo numbers:list` in the CLI, use the following numbers:

### US Numbers

Human readable format | E.164 format
-- | --
`(415) 555-0100` | `14155550100`
`(415) 555-0101` | `14155550101`
`(415) 555-0102` | `14155550102`
`(415) 555-0103` | `14155550103`
`(415) 555-0104` | `14155550104`
`(415) 555-0105` | `14155550105`

### GB Numbers

Human readable format | E.164 format
-- | --
`020 7946 0000` | `442079460000`
`020 7946 0001` | `442079460001`
`020 7946 0002` | `442079460002`
`020 7946 0003` | `442079460003`
`020 7946 0004` | `442079460004`
`020 7946 0005` | `442079460005`

### GB Mobile Numbers

Human readable format | E.164 format
-- | --
`07700 900000` | `447700900000`
`07700 900001` | `447700900001`
`07700 900002` | `447700900002`
`07700 900003` | `447700900003`
`07700 900004` | `447700900004`
`07700 900005` | `447700900005`

## Examples of writing style guides

Some further examples of writing style guides are:

* [Microsoft Style for Technical Publications](https://books.google.co.uk/books/about/The_Microsoft_Manual_of_Style_for_Techni.html)
* [Kubernetes](https://kubernetes.io/docs/home/contribute/style-guide/)
* [.NET](https://github.com/dotnet/docs/blob/master/styleguide/voice-tone.md)
