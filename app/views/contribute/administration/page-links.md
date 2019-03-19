---
title: Page Links
---

# Page Link Reporting

Nexmo Developer supports some reporting `rake` commands for showing links in to, and out from pages. This helps us visualise where our heavily linked pages are, and which pages we need to link to more. You can output the data as a table, plain text or as a Graphviz digraph.

This information can be used to improve cross-linking between pages, or identify content that is isolated and potentially unused

## Usage

> [partial_url] can be any string e.g. /voice/voice-api and only
matching source URLs will be returned. (`from` for _outbound and `to`
for _inbound)

* `rake links:report_outbound [partial_url]` - Generate a table containing
a list of pages, and all pages that they link to

* `rake links:report_inbound [partial_url]` - Generate a table containing
a list of pages, and all pages that link to it

* `rake links:no_links_outbound` - Show all pages with no outbound links

* `rake links:no_links_inbound` - Show all pages with no inbound links

* `rake links:graph_outbound [partial_url]` - Generate a Graphviz Digraph
containing all pages that match [partial_url]

* `rake links:graph_inbound [partial_url]` - Generate a Graphviz Digraph
containing all pages that link to [partial_url]


### Examples 

#### Outbound links from urls containing `/voice/voice-api/guides`

```
$ bundle exec rake links:report_outbound /voice/voice-api/guides

+--------------------------------------------+--------------------------------------------------------------------+
| From                                       | To                                                                 |
+--------------------------------------------+--------------------------------------------------------------------+
| /voice/voice-api/guides/legs-conversations | /voice/voice-api/guides/endpoints                                  |
+--------------------------------------------+--------------------------------------------------------------------+
| /voice/voice-api/guides/ncco               | /voice/voice-api/ncco-reference#record                             |
|                                            | /voice/voice-api/ncco-reference#conversation                       |
|                                            | /voice/voice-api/ncco-reference#connect                            |
|                                            | /voice/voice-api/ncco-reference#talk                               |
|                                            | /voice/voice-api/ncco-reference#stream                             |
|                                            | /voice/voice-api/ncco-reference#input                              |
+--------------------------------------------+--------------------------------------------------------------------+
| /voice/voice-api/guides/lex-connector      | /voice/voice-api/guides/websockets                                 |
|                                            | /voice/voice-api/guides/text-to-speech#voice-names                 |
+--------------------------------------------+--------------------------------------------------------------------+
| /voice/voice-api/guides/troubleshooting    |                                                                    |
+--------------------------------------------+--------------------------------------------------------------------+
| /voice/voice-api/guides/endpoints          |                                                                    |
+--------------------------------------------+--------------------------------------------------------------------+
| /voice/voice-api/guides/dtmf               | /voice/voice-api/ncco-reference#input                              |
|                                            | /api/voice#createCall                                              |
+--------------------------------------------+--------------------------------------------------------------------+
| /voice/voice-api/guides/call-flow          | /voice/voice-api/ncco-reference                                    |
|                                            | /voice/voice-api/webhook-reference#event-webhook                   |
|                                            | /concepts/guides/webhooks                                          |
|                                            | /voice/voice-api/guides/legs-conversations                         |
|                                            | /voice/voice-api/webhook-reference                                 |
+--------------------------------------------+--------------------------------------------------------------------+
| /voice/voice-api/guides/recording          | /voice/voice-api/ncco-reference#conversation                       |
|                                            | /voice/voice-api/ncco-reference#record                             |
+--------------------------------------------+--------------------------------------------------------------------+
| /voice/voice-api/guides/text-to-speech     | /api/voice#startTalk                                               |
|                                            | /voice/voice-api/ncco-reference                                    |
+--------------------------------------------+--------------------------------------------------------------------+
| /voice/voice-api/guides/numbers            |                                                                    |
+--------------------------------------------+--------------------------------------------------------------------+
| /voice/voice-api/guides/websockets         | /voice/voice-api/guides/ncco                                       |
|                                            | /voice/voice-api/guides/call-flow#answer-url-payload               |
|                                            | /voice/voice-api/code-snippets/play-an-audio-stream-into-a-call/ |
+--------------------------------------------+--------------------------------------------------------------------+
+--------------------------------------------+--------------------------------------------------------------------+

```

#### No outbound links from these pages
```
$ bundle exec rake links:no_links_outbound

/messages/external-accounts/api-reference
/messages/tutorials
/messages/concepts/facebook
/messages/concepts/viber
/messages/concepts/whatsapp
/messages/api-reference
/messages/code-snippets/client-library
/messages/code-snippets/create-an-application
/messages/code-snippets/install-cli
/verify/tutorials
/verify/api-reference
/dispatch/external-accounts/api-reference
/dispatch/tutorials
/dispatch/concepts/workflows
/dispatch/api-reference
/dispatch/code-snippets/client-library
/dispatch/code-snippets/create-an-application
/dispatch/code-snippets/install-cli
/redact/api-reference
/redact/code-snippets/redact-using-id
/audit/tutorials
/audit/api-reference
/voice/sip/configure/freeswitch
/voice/sip/configure/asterisk
/voice/sip/configure/freepbx
/voice/voice-api/tutorials
/voice/voice-api/guides/troubleshooting
/voice/voice-api/guides/endpoints
/voice/voice-api/guides/numbers
/voice/voice-api/api-reference
/voice/voice-api/code-snippets/mute-a-call
/voice/voice-api/code-snippets/play-text-to-speech-into-a-call
/voice/voice-api/code-snippets/retrieve-info-for-a-call
/voice/voice-api/code-snippets/earmuff-a-call
/voice/voice-api/code-snippets/play-dtmf-into-a-call
/voice/voice-api/code-snippets/play-an-audio-stream-into-a-call
/voice/voice-api/code-snippets/transfer-a-call
/voice/voice-api/code-snippets/retrieve-info-for-all-calls
/stitch/concepts/mos
/stitch/concepts/jwt-acl
/stitch/in-app-voice/call-statuses
/stitch/api-reference
/account/secret-management/api-reference
/account/secret-management/code-snippets/list-all-secrets
/account/secret-management/code-snippets/revoke-a-secret
/account/secret-management/code-snippets/create-a-secret
/account/secret-management/code-snippets/fetch-a-secret
/messaging/sns/code-snippets/subscribe-a-user
/messaging/sns/code-snippets/sending-a-message
/messaging/sms/tutorials
/messaging/sms/guides/SMPP-access
/messaging/sms/api-reference
/number-insight/tutorials
/number-insight/guides/cnam
/number-insight/api-reference
/conversation/tutorials
/conversation/concepts/event
/conversation/concepts/user
/conversation/cli-reference
/conversation/api-reference
/conversation/code-snippets/member/get-member
/conversation/code-snippets/member/create-member
/conversation/code-snippets/member/update-member
/conversation/code-snippets/member/list-members
/conversation/code-snippets/member/delete-member
/conversation/code-snippets/user/update-user
/conversation/code-snippets/user/delete-user
/conversation/code-snippets/user/get-user
/conversation/code-snippets/user/list-user-conversations
/conversation/code-snippets/user/list-users
/conversation/code-snippets/user/create-user
/conversation/code-snippets/leg/delete-leg
/conversation/code-snippets/leg/list-legs
/conversation/code-snippets/event/get-event
/conversation/code-snippets/event/create-event
/conversation/code-snippets/event/list-events
/conversation/code-snippets/event/delete-event
/conversation/code-snippets/conversation/list-conversations
/conversation/code-snippets/conversation/update-conversation
/conversation/code-snippets/conversation/get-conversation
/conversation/code-snippets/conversation/delete-conversation

```

### Render Graphviz digraphs

This example will render a digraph containing all outbound links from `/voice/voice-api/guides` as a file named `voice-graph.png`

```
bundle exec rake links:graph_outbound /voice/voice-api/guides > voice-graph
dot -Tpng voice-graph > voice-graph.png
```

