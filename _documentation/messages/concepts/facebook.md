---
title: Understanding Facebook messaging
navigation_weight: 3
description: Understanding Facebook messaging.
---

# Understanding Facebook messaging

Only an individual may have a Facebook Profile, whereas a business must have a Facebook Page.

A Facebook user must initiate communication using Facebook Messenger via the business's Facebook Page. A message from the business to the Facebook user will otherwise be refused.

Facebook Messenger uses its own form of IDs for the Facebook User and the Facebook Page :

* Facebook User (profile) - Page-Scoped ID (PSID)
* Facebook Page (business) - Page ID

The Facebook User will have a Page-scoped ID (PSID) and this is unique for each Facebook Profile. The business can only obtain the PSID of a user when the user sends a message to the business. In Facebook Messenger, the default is for the customer to initiate a conversation with a business.

In order to get started with Facebook Messenger you will need to link your business's Facebook Page to Nexmo. At this point Nexmo will provide you with your Facebook Page ID.

You can then test things by sending a message as a Facebook User to your own Facebook Page. At this point you will receive an inbound message webhook to your server with the PSID of the Facebook user. You can now use this PSID to send a message back to the user.
