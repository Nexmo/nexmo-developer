---
title: Python
language: python
---

```python
import nexmo

client = nexmo.Client(key=API_KEY, secret=API_SECRET)
client.buy_number({"country": "GB", "msisdn": "447700900000"})
```
