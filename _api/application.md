---
title: Application API Reference
api: Application
description: Application API Reference
---

# Application API Reference

<div class="Vlt-callout Vlt-callout--warning">
	<i></i>
	<div class="Vlt-callout__content">
		<h4>This version of the API has been deprecated</h4>
		<p>Please use <a href="/api/application.v2">version 2</a> going forwards</p>
	</div>
</div>

A Nexmo application contains the security and configuration information you need to connect to Nexmo endpoints and easily use our products.

## Create an application

```
[POST] https://api.nexmo.com/v1/applications
```

### Voice

```tabbed_examples
source: _examples/api/application/voice/create-an-application
```

#### Parameters

The following table shows the parameters you use to create a new voice application:

Parameter | Description | Required
-- | -- | -- | --
`name` | The name of your application. | ✓ 
`type` | The Nexmo product or products that you access with this application. Currently only `voice` and `messages` are supported. | ✓ 
`answer_url` | The URL where your webhook delivers the Nexmo Call Control Object that governs this call. As soon as your user answers a call Nexmo makes a request to `answer_url`. | ✓ 
`answer_method` | The HTTP method used to make the request to `answer_url`. The default value is `GET`. | x 
`event_url` | Nexmo sends event information asynchronously to this URL when status changes. | ✓ 
`event_method` | The HTTP method used to send event information to event_url. The default value is POST. | x


<br>

### Messages and Dispatch

```tabbed_examples
source: _examples/api/application/messages/create-an-application
```

#### Parameters

The following table shows the parameters you use to create a new messages and dispatch application:

Parameter | Description | Required
-- | -- | -- | --
`name` | The name of your application. | ✓ 
`type` | The Nexmo product or products that you access with this application. Currently only `voice` and `messages` are supported. | ✓ 
`status_url` | Nexmo sends Submitted, Delivered, Read and Rejected statuses for every message to this URL. | ✓
`inbound_url` | Nexmo sends Inbound Messages to this URL. | ✓

<br>

### Response

The JSON object for a `201 Created` response looks like:

#### Voice

```bash
{
  "id": "aaaaaaaa-bbbb-cccc-dddd-0123456789ab",
  "name": "My Application",
  "voice": {
    "webhooks": [
      {
        "endpoint_type": "answer_url",
        "endpoint": "https://example.com",
        "http_method": "GET"
      },
      {
        "endpoint_type": "event_url",
        "endpoint": "https://example.com",
        "http_method": "POST"
      }
    ]
  },
  "keys": {
    "public_key": "PUBLIC_KEY",
    "private_key": "PRIVATE_KEY"
  },
  "_links": {
    "self": {
      "href": "/v1/applications/aaaaaaaa-bbbb-cccc-dddd-0123456789ab"
    }
  }
}
```

#### Messages and Dispatch

```bash
{
  "id": "aaaaaaaa-bbbb-cccc-dddd-0123456789ab",
  "name": "My Application",
  "messages": {
    "webhooks": [
      {
        "endpoint_type": "status_url",
        "endpoint": "https://example.com/status"
      },
      {
        "endpoint_type": "inbound_url",
        "endpoint": "https://example.com/inbound"
      }
    ]
  },
  "keys": {
    "public_key": "PUBLIC_KEY",
    "private_key": "PRIVATE_KEY"
  },
  "_links": {
    "self": {
      "href": "/v1/applications/aaaaaaaa-bbbb-cccc-dddd-0123456789ab"
    }
  }
}
```

The response contains the following keys and values:

Parameter | Description | Voice | Messages
-- | -- | -- | --
`name` | The name of your application | ✓ | ✓
`type` | The Nexmo product or products that you access with this application. Currently only `voice` and `messages` are supported. | ✓ | ✓
`id` | The ID allocated to your application by Nexmo. | ✓ | ✓
`keys.public_key` | The public key used to validate the [JWT](https://en.wikipedia.org/wiki/JSON_Web_Token). | ✓ | ✓
`keys.private_key` | The private key you use to generate the JSON Web Token (JWT) that authenticates your requests to Voice API. | ✓ | ✓
`answer_url` | The URL where your webhook delivers the Nexmo Call Control Object that governs this call. As soon as your user answers a call Nexmo makes a request to answer_url. | ✓ | x
`answer_method` | The HTTP method used to make the request to answer_url. | ✓ | x
`event_url` | Nexmo sends event information asynchronously to this URL when status changes. | ✓ | x
`event_method` | The HTTP method used to send event information to event_url. | ✓ | x
`status_url` | Nexmo sends Submitted, Delivered, Read and Rejected statuses for every message to this URL. | x | ✓
`inbound_url` | Nexmo sends Inbound Messages to this URL. | x | ✓
`_links` | A series of links between resources in this API in the following [HAL specification](http://stateless.co/hal_specification.html).

## Retrieve your applications

```
[GET] https://api.nexmo.com/v1/applications
```

You use a [GET] request to retrieve details of all applications associated with your account:

```tabbed_examples
source: _examples/api/application/shared/retrieve-your-applications
```

### Parameters

The following table shows the parameters you use to list your apps:

Parameter | Description | Required
-- | -- | --
`page_size` | Set the number of items returned on each call to this endpoint. The default is 10 records. | No
`page_index` | Set the offset from the first page. The default value is `0`. | No

### Response

The JSON object for a 200 success response looks like:

```json
{
  "count": 1,
  "page_size": 10,
  "page_index": 1,
  "_embedded": {
    "applications": [
      {
        "id": "aaaaaaaa-bbbb-cccc-dddd-0123456789ab",
        "name": "My Application",
        "voice": {
          "webhooks": [
            {
              "endpoint_type": "event_url",
              "endpoint": "https://example.com/event",
              "http_method": "POST"
            },
            {
              "endpoint_type": "answer_url",
              "endpoint": "https://example.com/answer",
              "http_method": "GET"
            }
          ]
        },
        "keys": {
          "public_key": "PUBLIC_KEY"
        },
        "_links": {
          "self": {
            "href": "/v1/applications/aaaaaaaa-bbbb-cccc-dddd-0123456789ab"
          }
        }
      },
      {
        "id": "aaaaaaaa-bbbb-cccc-dddd-0123456789ab",
        "name": "My Application",
        "voice": {
          "messages": [
            {
              "endpoint_type": "status_url",
              "endpoint": "https://example.com/status"
            },
            {
              "endpoint_type": "inbound_url",
              "endpoint": "https://example.com/inbound"
            }
          ]
        },
        "keys": {
          "public_key": "PUBLIC_KEY"
        },
        "_links": {
          "self": {
            "href": "/v1/applications/aaaaaaaa-bbbb-cccc-dddd-0123456789ab"
          }
        }
      }
    ]
  },
  "_links": {
    "self": {
      "href": "/v1/applications?page_size=10&page_index=1"
    },
    "first": {
      "href": "/v1/applications?page_size=10"
    },
    "last": {
      "href": "/v1/applications?page_size=10&page_index=5"
    },
    "next": {
      "href": "/v1/applications?page_size=10&page_index=2"
    }
  }
}
```

The response contains:

Parameter | Description
-- | --
`count` | The number of items associated with your account.
`page_size` | Set the number of items returned on each call to this endpoint. The default is 10 records.
`page_index` | Set the offset from the first page. The default value is `0`.
`applications` | The collection of your applications. Each object contains information about an an individual application. The public_key is not included in the application information.
`_links` | A series of links between resources in this API in the following [HAL specification](http://stateless.co/hal_specification.html).

## Retrieve an application

```
[GET] https://api.nexmo.com/v1/applications/:app_id
```

You use a [GET] request to retrieve details about a single application:

```tabbed_examples
source: _examples/api/application/retrieve-an-application
```

### Response

The JSON object for a `200 OK` response looks like:

```json
{
  "id": "aaaaaaaa-bbbb-cccc-dddd-0123456789ab",
  "name": "My Application",
  "voice": {
    "webhooks": [
      {
        "endpoint_type": "answer_url",
        "endpoint": "https://example.com/answer",
        "http_method": "GET"
      },
      {
        "endpoint_type": "event_url",
        "endpoint": "https://example.com/event",
        "http_method": "POST"
      }
    ]
  },
  "keys": {
    "public_key": "PUBLIC_KEY"
  },
  "_links": {
    "self": {
      "href": "/v1/applications/aaaaaaaa-bbbb-cccc-dddd-0123456789ab"
    }
  }
}
```

The response contains:

Parameter | Description
-- | --
`name` | The name of your application
`type` | The Nexmo product or products that you access with this application. Currently only `voice` and `messages` are supported.
`id` | The ID allocated to your application by Nexmo.
`keys.public_key` | The public key used to validate the [JWT](https://en.wikipedia.org/wiki/JSON_Web_Token).
`answer_url` | The URL where your webhook delivers the Nexmo Call Control Object that governs this call. As soon as your user answers a call Nexmo makes a request to answer_url.
`answer_method` | The HTTP method used to make the request to answer_url.
`event_url` | Nexmo sends event information asynchronously to this URL when status changes.
`event_method` | The HTTP method used to send event information to event_url.
`_links` | A series of links between resources in this API in the following [HAL specification](http://stateless.co/hal_specification.html).

## Update an application

```
[PUT] https://api.nexmo.com/v1/applications/:app_id
```

You use a [PUT] request to update an existing application:

```tabbed_examples
source: _examples/api/application/update-an-application
```

### Parameters

The following table shows the parameters you use to update an application:

Parameter | Description | Required
-- | -- | --
`name` | The name of your application. | Yes
`type` | The Nexmo product or products that you access with this application. Currently only `voice` and `messages` are supported. | Yes
`answer_url` | The URL where your webhook delivers the Nexmo Call Control Object that governs this call. As soon as your user answers a call Nexmo makes a request to `answer_url`. | Yes
`answer_method` | The HTTP method used to make the request to `answer_url`. The default value is `GET`. | No
`event_url` | Nexmo sends event information asynchronously to this URL when status changes. | Yes
`event_method` | The HTTP method used to send event information to event_url. The default value is POST. | No

### Response

The JSON object for a 200 success response looks like:

```json
{
  "id": "aaaaaaaa-bbbb-cccc-dddd-0123456789ab",
  "name": "My Application",
  "voice": {
    "webhooks": [
      {
        "endpoint_type": "answer_url",
        "endpoint": "https://example.com/answer",
        "http_method": "GET"
      },
      {
        "endpoint_type": "event_url",
        "endpoint": "https://example.com/event",
        "http_method": "POST"
      }
    ]
  },
  "keys": {
    "public_key": "PUBLIC_KEY"
  },
  "_links": {
    "self": {
      "href": "/v1/applications/aaaaaaaa-bbbb-cccc-dddd-0123456789ab"
    }
  }
}
```

The response contains:

Parameter | Description
-- | --
`name` | The name of your application
`type` | The Nexmo product or products that you access with this application. Currently only `voice` and `messages` are supported.
`id` | The ID allocated to your application by Nexmo.
`keys.public_key` | The public key used to validate the [JWT](https://en.wikipedia.org/wiki/JSON_Web_Token).
`answer_url` | The URL where your webhook delivers the Nexmo Call Control Object that governs this call. As soon as your user answers a call Nexmo makes a request to answer_url.
`answer_method` | The HTTP method used to make the request to answer_url.
`event_url` | Nexmo sends event information asynchronously to this URL when status changes.
`event_method` | The HTTP method used to send event information to event_url.
`_links` | A series of links between resources in this API in the following [HAL specification](http://stateless.co/hal_specification.html).

## Destroy an Application

```
[DELETE] https://api.nexmo.com/v1/applications/:id
```

You use a [DELETE] request to delete a single application:

```tabbed_examples
source: _examples/api/application/destroy-an-application
```

### Response

Nexmo returns a `204 No Content` status code when your application is successfully deleted.
