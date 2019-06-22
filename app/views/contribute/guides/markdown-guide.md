---
title: Markdown Guide
navigation_weight: 3
---

⚓ Anchor Example

# Markdown Guide

Here is a complete overview of the basic markdown and custom plugins that Nexmo Developer supports.

We use plugins sparingly to extend functionality where the only other option would be HTML.

You can find this document in `/app/views/contribute/guides/markdown-guide.md`. The side navigation has been left present to be an accurate representation of the content width.

There is no markdown syntax in here as this document is rendered with the same engine and no support exists for escaping Markdown. Examples would ultimately be rendered. To understand recursion you must first understand recursion.

## Typography

**Headings**

# I am a H1
## I am a H2
### I am a H3

> Custom extension: Headings have their own slugified ID's for deep linking. For example the `h1` has an ID of `i-am-a-h1`

**Paragraphs**

Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras mattis consectetur purus sit amet fermentum. Donec id elit non mi porta gravida at [eget metus](#). Vestibulum id ligula porta felis euismod semper. Donec id elit non mi porta gravida at eget metus. Cras mattis consectetur purus sit amet fermentum. Sed posuere consectetur est at lobortis.

**Inline styles**

Text can be **bold**, *italic* or ***bold and italic***. You could use ~~strikethrough~~ but please don't.

You can define inline `code block` with backticks.

This is a [link](http://google.com) to Google.

> **Note**: You can use a `>` to specify a blockquote. We use these for tips like this.

**Labels**

You can have [labels].

They auto-magically color when you use verbs like [POST] or [DELETE]

**Collapsible Content (custom plugin)**

| ### Click me
|
| Here is some hidden content.
|
| Markdown _still_ works `here`!
|
| Nullam id dolor id nibh ultricies vehicula ut id elit. Donec ullamcorper nulla non metus auctor fringilla. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.

| ### Alpha
|
| Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Donec id elit non mi porta gravida at eget metus. Sed posuere consectetur est at lobortis. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ullamcorper nulla non metus auctor fringilla.
|
| Donec id elit non mi porta gravida at eget metus. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Nulla vitae elit libero, a pharetra augue. Donec sed odio dui. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Cras mattis consectetur purus sit amet fermentum.
|
| Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Donec id elit non mi porta gravida at eget metus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla vitae elit libero, a pharetra augue. Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Aenean lacinia bibendum nulla sed consectetur. Nullam quis risus eget urna mollis ornare vel eu leo.

**Tooltips (custom plugin)**

Find out ^[more](Tooltips are useful for when you have more information to convey, but don't want to break context.).

## Images

![Please always add alt-text](https://media.giphy.com/media/pDTLSpqNvNxlu/giphy.gif)

> Images should be used sparingly, try to avoid using screenshots that might go out of date.
>
> Also... Please ALWAYS write descriptive alt text.

## Lists

**Unordered Lists**

> List items have `*` in front of them.
>
> Indentations are 4 spaces.

* Alpha
* Bravo
    * Charlie
    * Delta
        * Echo
    * Foxtrot
* Golf

**Ordered Lists**

> List items have `1.`, `2.`, `3.` etc in front of them.
>
> Indentations are 4 spaces.

1. One
2. Two
    1. Three
    2. Four
        1. Five
    1. Six
3. Seven

## Code

See our detailed [code examples guide](/contribute/guides/code-examples) for advice on including code.

## Tables

> Pipes should only be between cells. Two hyphens `--` should be used to 'underline' the headings.
>
> You'll have to view the `markdown-guide.md` source to see how since showing you the syntax would result in it being processed.

Key | Description
-- | --
`TO_NUMBER` | The number you are sending the SMS to
`API_KEY` | You can find this in your [account overview](https://dashboard.nexmo.com/account-overview)
`API_SECRET` | You can find this in your [account overview](https://dashboard.nexmo.com/account-overview)

## Tabbed Content (custom plugin)

To use the tabbed content block, add a section like this to your markdown to point out where the directory holding the examples is:

````
```tabbed_content
source: '/_examples/styleguide/tabbed-content'
```
````

Each file becomes a tab, as you can see:

```tabbed_content
source: '/_examples/styleguide/tabbed-content'
```

## Mermaid (custom plugin)

You can use any [Mermaid](https://mermaidjs.github.io/) diagram using the `mermaid` filter. 

````
```mermaid
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
```
````

Some common diagrams e.g. sequence diagrams may have specific extensions, so keep reading!

## Sequence Diagram (custom plugin, using Mermaid)

Our sequence diagrams are simple markup that is rendered to a graphical representation by a custom plugin. Starting with code like this:

````
```sequence_diagram
Andrew->China: Says Hello
Note right of China: China thinks\nabout it
China-->Andrew: How are you?
Andrew->>China: I am good thanks!
```
````

Creates the following diagram:

```sequence_diagram
Andrew->China: Says Hello
Note right of China: China thinks\nabout it
China-->Andrew: How are you?
Andrew->>China: I am good thanks!
```

## Languages (custom plugin)

Inline [IETF language tag](https://en.wikipedia.org/wiki/IETF_language_tag) support, using both primary language tags and subtags, is provided using the following syntax.

Language | Key | Text
-- | -- | --
English | none | Hello World
Spanish | `es` | [Hola Mundo](lang: 'es')
French | `fr` | [Bonjour le monde](lang: 'fr')
Brazilian Portuguese | `pt-BR` | [Olá Mundo](lang: 'pt-BR')
Hebrew | `il` | [שלום עולם](lang: 'il')

## Anchors (custom plugin)

Adding custom anchors and retaining support for old headings can be done as such:

````
⚓ This is the old heading
````

This would produce the following HTML:

```html
<a name="this-is-the-old-heading"></a>
```

If you are adding support for a changed header this would normally go above the old heading as such:

````
⚓ Send with Short Message Service
⚓ Send with SMS

# Sending an SMS
````

### Example

[Go to the anchor](#anchor-example). I've placed at the top of this document.

## Screenshots

Webpage screenshots can be scripted so that they only require sourcing once. Define a screenshot as such:

````
```screenshot
script: app/screenshots/webhook-url-for-delivery-receipt.js
```
````

Run the following command:

```
$ rake screenshots:new
```

This changes the original source document to add an `image` value pointing to the screenshot:

````
```screenshot
script: app/screenshots/webhook-url-for-delivery-receipt.js
image: public/assets/screenshots/da5f952d465355c19eb888fa1049844b31e090c2.png
```
````

You can also update all examples by running the following command:

```
$ rake screenshots:all
```

Here is the example of the final rendered output:

```screenshot
script: app/screenshots/webhook-url-for-delivery-receipt.js
image: public/assets/screenshots/da5f952d465355c19eb888fa1049844b31e090c2.png
```

## Audio (custom plugin)

The HTML `<audio>` element can be utilised in Markdown with the following syntax:

````
🔈[https://developer.nexmo.com.s3.amazonaws.com/assets/ssml/06-phonemes.mp3]
````

This produces the following output:

🔈[https://developer.nexmo.com.s3.amazonaws.com/assets/ssml/06-phonemes.mp3]

## Dynamic content

You can use syntax such as:

````
Welcome to [~dynamic_content_example~]
````

This will render as:

Welcome to [~dynamic_content_example~]

## Concept list (custom plugin)

If you need to produce a list of concepts (also known as guides) on a page, you can specify a product and have it render an unstyled `<ul>`

````
```concept_list
product: voice/voice-api
```
````

This produces the following output:

```concept_list
product: voice/voice-api
```

Alternatively, you can specify the concepts to list manually if you need to show a subset of concepts, or concepts from multiple different products:

````
```concept_list
concepts: 
  - voice/voice-api/call-flow
  - messaging/sms/delivery-receipts
```
````

This produces the following output:

```concept_list
concepts: 
  - voice/voice-api/call-flow
  - messaging/sms/delivery-receipts
```
