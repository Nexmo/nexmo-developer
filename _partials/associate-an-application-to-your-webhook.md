## Associate a Nexmo Application with your server

You need to do two things:

1. Create a Nexmo Application and specify the webhook URLs to match
   your server. Note that in this building block only the Answer URL
   webhook is used:

    ``` shell
    $ nexmo app:create demo <YOUR_HOSTNAME>/webhooks/answer <YOUR_HOSTNAME>/webhooks/event
    ```
    
    This will return a Nexmo Application ID which is used in the following step.

2. Link your Nexmo Number to your Nexmo Application:

    ``` shell
    $ nexmo link:app <NEXMO_NUMBER> <NEXMO_APPLICATION_ID>
    ```
