---
title: Run the Ruby App
description: Run the Vonage Ruby Voice application to stream audio
---

# Run the Ruby App

In your terminal navigate to the project directory and execute the following command:

```bash
bundle exec ruby server.rb
```

This will start the application on `http://localhost:4567`. Making a web request to that URL will initiate a new call. You can do so by either opening up your preferred web browser and visiting that link or sending a cURL request by running `curl http://localhost:4567` from your terminal.