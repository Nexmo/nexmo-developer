
For your application to place a phone call, you'll need to provide a URL as the `Answer URL` webhook. For the purpose of this tutorial, you will create a [gist](https://gist.github.com/NexmoDev/f11d10f21fe426ddac4e30b94c6b28dc) with the content below:

```json
[
    {
        "action": "talk",
        "text": "Please wait while we connect you."
    },
    {
        "action": "connect",
        "timeout": 20,
        "from": "YOUR_NEXMO_NUMBER",
        "endpoint": [
            {
                "type": "phone",
                "number": "CALLEE_PHONE_NUMBER"
            }
        ]
    }
]
```

> **Do not forget to replace `YOUR_NEXMO_NUMBER` and `CALLEE_PHONE_NUMBER` with the relevant values for your app.**

Once created, add the gist raw URL (make sure you're using the raw version) to your [Vonage API dashboard](https://dashboard.nexmo.com). To do this, navigate to [applications](https://dashboard.nexmo.com/voice/your-applications), select your application and click the 'Edit' button. Set the application's `Answer URL` and click 'Save changes'.

You will need to repeat this process every time you're changing the gist as a new revision (with the new raw URL) is being created.

> **Note:** The gist you created is specific to this tutorial. In a real-life scenario, the `Answer URL` should be provided by a purposely built web solution. Your backend should provide that can serve custom NCCOs and, for this case, receive and validate the phone number dialled from the app.
