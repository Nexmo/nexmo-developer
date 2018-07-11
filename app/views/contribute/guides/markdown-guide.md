---
title: Markdown guide
navigation_weight: 3
---

⚓ Anchor Example

# Markdown guide

Here is a complete overview of the basic markdown and custom plugins that Nexmo Developer supports.

We use plugins sparingly to extend functionality where the only other option would be HTML.

You can find this document in `/app/views/contribute/guides/markdown-guide.md`. The side navigation has been left present to be an accurate representation of the content width.

There is no markdown syntax in here as this document is rendered with the same engine and no support exists for escaping markdown. Examples would ultimately be rendered. To understand recursion you must first understand recursion.

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

**Code blocks**

Normal code blocks are specified using three backticks at the start and end.

```
This is a normal code block.

It does not specify a language so is not syntax highlighted.
```

Here is some Ruby:

```ruby
def print_hi(name)
  puts "Hi #{name}"
end

print_hi('Adam')
#=> prints 'Hi Adam' to STDOUT.
```

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

**Tabbed Examples (custom plugin)**

For tabbed code we use a custom plugin.

> You'll have to view the `markdown-guide.md` source to see how since showing you the syntax would result in it being processed.

```tabbed_examples
source: '/_examples/messaging/sending-an-sms/basic'
```

**Tabbed Examples (custom plugin) + pulling code in from external repository**

For tabbed code we use a custom plugin.

> You'll have to view the `markdown-guide.md` source to see how since showing you the syntax would result in it being processed.

```tabbed_examples
tabs:
  Ruby:
    source: .repos/nexmo-community/nexmo-ruby-quickstart/sms/send.rb
    from_line: 9
    language_key: php
```

**Tabbed Examples (via config)**

```tabbed_examples
config: messaging.sms.send
```

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

```tabbed_content
source: '/_examples/styleguide/tabbed-content'
```

## JS Sequence Diagram (custom plugin)

> You'll have to view the `markdown-guide.md` source to see how since showing you the syntax would result in it being processed.

```js_sequence_diagram
Andrew->China: Says Hello
Note right of China: China thinks\nabout it
China-->Andrew: How are you?
Andrew->>China: I am good thanks!
```

## Modals (custom plugin)

Sometimes content is too verbose to put on the surface (particularly if it's in a table). You can include a file in a modal:

Why not @[give it a try](/_modals/styleguide/example.md) now?

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

You can use sytax such as:

````
Welcome to [~dynamic_content_example~]
````

This will render as:

Welcome to [~dynamic_content_example~]
