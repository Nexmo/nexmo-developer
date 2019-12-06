---
title: Understanding custom objects
navigation_weight: 4
description: Understanding custom objects
---

# Custom objects

The Messages API has the concept of a custm object. The custom object allows you to leverage advanced features of the supported messaging platforms.

The custom object takes a partial section of the original messaging API's request format and sends it directly to that platform. 

Taking WhatsApp as an example, here's what Nexmo would send through to WhatsApp in summary format:

``` json
{
  "recipient_type": "individual",
  "to": "$TO_NUMBER",
  {$CUSTOM_OBJECT}
}
```

The Nexmo message format is:

``` json
{
  "from": {
    "type": "whatsapp",
    "number": "447700900001"
  },
  "to": {
    "type": "whatsapp",
    "number": "447700900000"
  },
  "message": {
    "content": {
      "type": "custom",
      "custom": {
          DATA
      }
    }
  }
}
```

The JSON to insert in `DATA` depends on the format of the messaging platform's format.

Using WhatsApp again by way of example, if the original request format is:

``` json
{
  "recipient_type": "individual",
  "to": "447700900000",
  "type": "template",
  "template": {
    "namespace": "whatsapp:hsm:technology:nexmo",
    "name": "parcel_location",
    "language": {
      "policy": "deterministic",
      "code": "en"
    },
    "components": [
      {
        "type": "location",
        "location": {
          "longitude": -122.425332,
          "latitude": 37.758056,
          "name": "Facebook HQ",
          "address": "1 Hacker Way, Menlo Park, CA 94025"
        }
      },
      {
        "type": "body",
        "parameters": [
          {
            "type": "text",
            "text": "Value 1"
          },
          {
            "type": "text",
            "text": "Value 2"
          }
        ]
      }
    ]
  }
}
```

The Nexmo Messages API request format would be:

``` json
{
  "from": {
    "type": "whatsapp",
    "number": "447700900001"
  },
  "to": {
    "type": "whatsapp",
    "number": "447700900000"
  },
  "message": {
    "content": {
      "type": "custom",
      "custom": {
        "type": "template",
        "template": {
          "namespace": "whatsapp:hsm:technology:nexmo",
          "name": "parcel_location",
          "language": {
            "policy": "deterministic",
            "code": "en"
          },
          "components": [
            {
              "type": "header",
              "parameters": [
                {
                  "type": "location",
                  "location": {
                    "longitude": -122.425332,
                    "latitude": 37.758056,
                    "name": "Facebook HQ",
                    "address": "1 Hacker Way, Menlo Park, CA 94025"
                  }
                }
              ]
            },
            {
              "type": "body",
              "parameters": [
                {
                  "type": "text",
                  "text": "Value 1"
                },
                {
                  "type": "text",
                  "text": "Value 2"
                }
              ]
            }
          ]
        }
      }
    }
  }
}
```

In other words when considering this Nexmo request:

``` json
{
  "from": {
    "type": "whatsapp",
    "number": "447700900001"
  },
  "to": {
    "type": "whatsapp",
    "number": "447700900000"
  },
  "message": {
    "content": {
      "type": "custom",
      "custom": {
          DATA
      }
    }
  }
}
```

The custom object, `DATA`, obtained from the original request format is:

``` json
  "type": "template",
  "template": {
    "namespace": "whatsapp:hsm:technology:nexmo",
    "name": "parcel_location",
    "language": {
      "policy": "deterministic",
      "code": "en"
    },
    "components": [
      {
        "type": "location",
        "location": {
          "longitude": -122.425332,
          "latitude": 37.758056,
          "name": "Facebook HQ",
          "address": "1 Hacker Way, Menlo Park, CA 94025"
        }
      },
      {
        "type": "body",
        "parameters": [
          {
            "type": "text",
            "text": "Value 1"
          },
          {
            "type": "text",
            "text": "Value 2"
          }
        ]
      }
    ]
  }
```