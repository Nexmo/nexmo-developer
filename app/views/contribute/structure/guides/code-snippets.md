---
title: Code Snippets
navigation_weight: 3
---

# Code Snippets

Code snippets provide a quick reference to how to achieve a specific single concern task. They are designed to be easily readable and light on content to allow the user to context switch between the documentation and their codebase without too much distraction. Below you'll find a typical structure of how a code snippet should be structured.

**✅ Examples of when a code snippet is appropriate**

- How to send an SMS
- Making an outbound call
- Send verification code
- Get details about a phone number
- Buy a number

You can see examples of code snippets in the [Voice API docs](/voice/voice-api/code-snippets/before-you-begin).

**❎ Examples of when a code snippet is not appropriate**

- Two factor authentication

    *Although the components of this should be code snippets the subject in itself is too involved for a code snippet.*

## Anatomy of a code snippet

A code snippet is made of many moving parts, so below is a screenshot of an example code snippet, with the various elements labelled. More details on each element is below.

![Screenshot of a sample code snippet](/assets/images/contributing/code-snippet-anatomy.png)

### Introduction

The **introduction** for a code snippet consists of the title, an opening paragraph about the topic, and then a section introducing the example that this block illustrates. All these elements are contained in the [markdown file for the block](#code-snippet-markdown-file).

### Placeholders 

The **placeholder** are also in the [markdown file](#code-snippet-markdown-file), these values are per-block and the same ones should be used by each language-specific code example.

### Tabbed content

The code snippets of the code snippets are available in a variety of programming languages to support developers from different communities. The **tabbed content** contains a tab for each [per-language config file](#language-config-files) available at the path configured in the [markdown file for each code snippet](#code-snippet-markdown-file). If the file exists, then there will be a tab for it.

### Setup steps

The **setup steps** are automatically generated from the information in the [per-language config files](#language-config-files). The renderer (`app/filters/code_snippet_filter.rb`) creates these collapsible sections from the configuration supplied. The filename in the "Write the code" section and the command to "Run your code" are also controlled here.

### Quickstart code snippets

The [source code](#source-code) is actually snippets of **code in the "code-snippets" repos**. These are external repositories that hold full working examples and we use sections of those examples to demonstrate the code. The source repository, file and range of lines to include are all defined in the [per-language config files](#language-config-files) for each code snippet language example.

### Run the code

A user will want to see a **demo** of the code, so this section describes how to interact with or use the main feature of the code snippet. This should be the same for all the languages and is defined in the [markdown file for each code snippet](#code-snippet-markdown-file).

### Further reading

Finally, any additional links and resources may also be added to the [markdown file for each code snippet](#code-snippet-markdown-file). 

## File locations for Code Snippets

### code snippet markdown file

This is the entry point that causes the code snippet to exist in the first place. It's a markdown file in the `code_snippets` directory for the documentation section it applies to, with a path such as `/_documentation/voice/voice-api/code-snippets/my_awesome-block.md`.

It contains some basic front matter include the page title and navigation weight:

```
---
title: Quick howto on a simple thing
navigation_weight: 5
---
```

This file has the title, and some opening content about what the code snippet does or what it's for. Most users may have come from another part of the docs, such as a specific guide, but others may have landed here via search and will lack context.

The [placeholders](#placeholders) are also included here in the markdown file for the code snippet itself.

Within the code snippet markdown file, we define a "code snippet" - this is what renders everything inside the tabbed content block.

````
```code_snippets
source: '_examples/concepts/sample-code-snippet'
application:
  name: 'Example Application'
```
````

This block points to the directory that contains the per-language config files for the tabbed content block. The settings here are combined with the per-language config files, so it's possible to set common settings in this section.

The only other sections coming from this file are the ["Try it out"](#run-the-code) and ["Further reading"](#further-reading) ones.

### Language config files

For each of the tabs in the [tabbed content](#tabbed-content) block, the content is controlled entirely by a language-specific yaml file. This yaml file will be in the location specified by the `source` field in the `code_snippets` code sample, and will be named for the language it covers, such as `ruby.yml` or `python.yml`.

The options available in these config files combine to a very consistent output format across the code snippets. Here's an example from one of our voice applications.

```
---
title: Java
language: java
dependencies:
    - 'com.nexmo:client:4.1.0'
code:
    source: .repos/nexmo/nexmo-java-code-snippets/src/main/java/com/nexmo/quickstart/voice/TransferCall.java
    from_line: 42
    to_line: 42
client:
    source: .repos/nexmo/nexmo-java-code-snippets/src/main/java/com/nexmo/quickstart/voice/TransferCall.java
    from_line: 17
    to_line: 22
run_command: java-ide
file_name: TransferCall.java
unindent: true
```

These options control everything from the pre-requisites and setup steps, to showing and running the code.  Set as many or as few of these options as you need: only `title`, `language` and `code` are vital.

Field | Description 
-- | -- 
`title` | Displayed on the tab, usually the title-cased language name.
`language` | The language used, usually lowercase language name (NodeJS is spelled "node").
`application` | Set up the initial application setup instructions:<br />`name`: Specify the name for the application<br />`disable_ngrok`: Don't include the ngrok mention and link in this block<br />`event_url` and `answer_url`: Specify non-standard URLs for the call events <br />`use_existing`: Direct the user to use an existing Nexmo application rather than telling them to create one  Set as many or as few of these options as you need: only `title`, `language` and `code` are vital.
`dependencies` | If the block needs extra libraries, describe them here in a comma-separated list. This will be transformed into the "Install dependencies" collapsible block.
`code` | Configuration describing the code snippet to display:<br />`source`: The file where the full working quickstart example is<br />`from_line`: Line to start the snippet from<br />`to_line`: Line to end the code snippet on (or the end of the file if this isn't included).
`client` | Configuration describing any setup required, such as setting up the appropriate library. See `code` for details.
`unindent` | If the code samples have leading tabs, remove as many as make the included code not be indented.
`file_name` | Name of the file that the user should put the example code into, used in the copy on the page and closely related to `run_command.
`run_command` | How to run the example once the user created it. Probably related to `file_name` but can take a special value of `java-ide` to give more Java-ish instructions.


> If the same value for an option applies to every language example, it can be set in the code snippet definition in the overall code snippet markdown file.

### Source Code

The code displayed within the [tabbed examples](#tabbed-content) belongs in external repositories; these are our "Quick Start" repositories on the [Nexmo Community GitHub organisation](https://github.com/nexmo-community). The directory structure follows that of the `_documentation` directory on Nexmo Developer.

The examples on the Quick Start repositories should be self-contained and executable. In the Code Snippets, we only include the section(s) that are directly relevant to the task that the code snippet is intended to illustrate.

