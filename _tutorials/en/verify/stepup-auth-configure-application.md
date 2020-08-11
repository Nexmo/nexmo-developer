---
title: Configure the application
description: Create a configuration file to store your authentication and other details
---

# Configure the application

You will store your API key and secret (which you can find in the [Developer Dashboard](https://dashboard.nexmo.com)) and the name of your organization in a configuration file.

Create a file called `.env` in the root of your application directory and enter the following information, replacing `YOUR_API_KEY` and `YOUR_API_SECRET` with your own key and secret:

```
NEXMO_API_KEY=YOUR_API_KEY
NEXMO_API_SECRET=YOUR_API_SECRET
NEXMO_BRAND_NAME=AcmeInc
```