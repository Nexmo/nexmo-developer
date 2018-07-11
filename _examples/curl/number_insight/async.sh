curl https://api.nexmo.com/ni/standard/async/json \
-d 'api_key=NEXMO_API_KEY' \
-d 'api_secret=NEXMO_API_SECRET' \
-d 'number=447700900000' \
-d 'callback=https://example.com/webhooks/event'
