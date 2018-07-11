## Associate an application to your webhook

To link your number to the endpoint you've just created we'll need an Application.

```
$ nexmo app:create demo <YOUR_HOSTNAME>/webhooks/answer <YOUR_HOSTNAME>/webhooks/event
$ nexmo link:app <NEXMO_NUMBER> <NEXMO_APPLICATION_ID>
```
