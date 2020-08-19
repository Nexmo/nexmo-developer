---
title: Using CDN
---

### Load the Client SDK package

Load the Client SDK from a Content Delivery Network (CDN):

Inside the `<head>` of your HTML file, add:

```html
<!-- ******* Load nexmoClient from a CDN ****** -->
<script type="module" src="https://unpkg.com/nexmo-client@latest/dist/nexmoClient.js?module"></script>
```

### Add the Client SDK into your code

Near the top of your application code, add:

```javascript
//********* Get a reference to NexmoClient **********
const NexmoClient = window.NexmoClient;
```

