---
title: Digital Marketplace
products: client-sdk
description: How to build your own digital marketplace application.
languages: 
    - Node
---

# Digital Marketplace

In this use case, you’ll learn how to build a digital marketplace. [View it in action here](https://green-crowberry.glitch.me/).

The example application was built using the following tools and technologies:

* Nexmo Client SDK
* React for the front end
* Node JS / Express for the backend

In this use case you use custom events in the Client SDK. Custom events are used here to alert your application when:

* A user lists a new item for sale
* A customer purchases an item using Stripe

## Prerequisites

It is assumed you have done the following:

1. Created a [Nexmo Account](https://dashboard.nexmo.com/sign-up).
2. Made a note of your Nexmo API key and API secret, which are displayed in the [Dashboard](https://dashboard.nexmo.com/getting-started-guide).

## Steps

The main steps in this use case are as follows:

1. [Create a Nexmo application](#create-a-nexmo-application)
2. [Authenticate your application](#authenticate-your-application)
3. [Configure your application](#configure-your-application)
4. [Code walkthrough](#code-walkthrough)

## Create a Nexmo application

You can create a Nexmo Application in the Dashboard. You can do this with the following steps:

1. In the Dashboard go to [Your Applications](https://dashboard.nexmo.com/applications).
2. Click **Create a new application**.
3. Enter a name for your application, such as **Client SDK Marketplace App**.
4. In the **Authentication** section click **Generate public and private key**. This generates a public/private key pair. The private key file is downloaded to your computer. You will use this file later.
5. In the **Capabilities** section select RTC.
6. For RTC capabilities you can enter an Event URL of `https://example.com/event`.
7. Click **Generate new application**.
8. Make a note of the generated Application ID.

You have now created a Nexmo application using the Dashboard.

At this point the important things are the private key file and the Application ID. You will need these for the following sections.

## Code repositories

If you’d like to work with existing code to build your own version of this project to experiment with, you can do one of the following:

* [Remix the Glitch project](https://glitch.com/edit/#!/remix/green-crowberry)
* [Clone the GitHub repository](https://github.com/nexmo-community/client-sdk-marketplace-use-case)

## Authenticate your application

You need to authenticate your application using the private key file you [previously generated](#create-a-nexmo-application).

### Using Glitch

Open the `private.key` file in a text editor. Then, in your Glitch project, create the file `/.data/private.key` and copy and paste in the contents of the `private.key`:

![Nexmo Application private key location Glitch screenshot](/assets/screenshots/use-cases/digital-marketplace-client-sdk/private-key-location-glitch.png)

### Using GitHub

Move the `private.key` file to the root of your project:

![Nexmo Application private key location local screenshot](/assets/screenshots/use-cases/digital-marketplace-client-sdk/private-key-location-local.png)

## Configure your application

Whether you are remixing the Glitch project, or cloning the GitHub repository, you must configure the application using the `.env` file.

Assign each variable with the relevant value you obtained from the preceding steps.

The structure of the `.env` file is slightly different depending on whether you are using Glitch or GitHub. The following sections show you how to edit the `.env` file.

### For Glitch

Modify the `.env` to be as follows, replacing the placeholder text with your values:

```
DANGEROUSLY_DISABLE_HOST_CHECK=true
API_KEY="your-value-here"
API_SECRET="your-value-here"
APP_ID="your-value-here"
PRIVATE_KEY="/.data/private.key"
```

### For GitHub

Modify the `.env` to be as follows, replacing the placeholder text with your values:

```
API_KEY="your-value-here"
API_SECRET="your-value-here"
APP_ID="your-value-here"
PRIVATE_KEY="/private.key"
```

This concludes all configuration.

## Code walkthrough

This section provides a walkthrough of the code for the most important pieces of the application.

### Login

The login screen is shown in the following screenshot:

![Marketplace App login screenshot](/assets/screenshots/use-cases/digital-marketplace-client-sdk/app-login.png)

The user enters a username and selects either the Seller or Buyer role.

The `POST` request body has properties that can be used for setting the user name, display name and image URL, but there is no such property for specifying the role. It is possible to add your own properties in `custom_data`, so you can create `role` in there:

*NexmoMarketplaceApp.js*

``` jsx
  const submitUser = async (e) => {
    try{
      const results = await fetch('/createUser', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          name: name.split(' ').join('-'),
          display_name: name.trim(),
          image_url: `https://robohash.org/${name.split(' ').join('-')}`,
          properties: {
            custom_data: {
              "role": role
            }
          }
        })
      });
      await results.json();
      await login();
    } catch(err){
      console.log('getJWT error: ',err);
    }
  };
```

### Authentication

The Client SDK authenticates using [JWTs](/concepts/guides/authentication#json-web-tokens-jwt). The application makes a call to the Node Express server to retrieve the JWT and then logs the user in. The code on the server side is as follows:

*server.js*

``` js
...
// the client calls this endpoint to request a JWT, passing it a username
app.post('/getJWT', function(req, res) {
    const jwt = nexmo.generateJwt({
        application_id: process.env.APP_ID,
        sub: req.body.name,
        exp: Math.round(new Date().getTime()/1000)+86400,
        acl: {
            "paths": {
                "/*/users/**":{},
                "/*/conversations/**":{},
                "/*/sessions/**":{},
                "/*/devices/**":{},
                "/*/image/**":{},
                "/*/media/**":{},
                "/*/applications/**":{},
                "/*/push/**":{},
                "/*/knocking/**":{}
            }
        }
    });
    res.send({jwt: jwt});
});

// the client calls this endpoint to create a new user in the Nexmo application,
// passing it a username and optional display name
app.post('/createUser', function(req, res) {
    console.log('/createUser: ',req);
    nexmo.users.create({
        name: req.body.name,
        display_name: req.body.display_name || req.body.name,
        image_url: req.body.image_url,
        properties: req.body.properties
    },(err, response) => {
        if (err) {
            res.sendStatus(500);
        } else {
            res.send({id: response.id});
        }
    });
});
```

The client app itself has functions for obtaining a JWT and then logging the user in:

*NexmoMarketplaceApp.js*

``` jsx
...
  // Get JWT to authenticate user
  const getJWT = async () => {
    try{
      const results = await fetch('/getJWT', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          name: name.split(' ').join('-')
        })
      });
      const data = await results.json();
      return data.jwt;
    } catch(err){
      console.log('getJWT error: ',err);
    }
  };

  // Log in the user
  const login = async () => {
    try{
      const userJWT = await getJWT();
      const app =  await new NexmoClient({ debug: false }).login(userJWT);
      setNexmoApp(app);
      await getConversations();
      setStage('listings');
    } catch(err){
      console.log('login error: ',err);
    }
  };
```

### Displaying items for sale

When the user is logged in, the app retrieves a list of all the items for sale, which is a list of Conversation objects. The client calls the server and the server returns a list of Conversations. The client-side code is as follows:

*NexmoMarketplaceApp.js*

``` jsx
  // Get all conversations, even the ones the user isn't a member of, yet.
  const getConversations = async() => {
    try{
        const results = await fetch('/getConversations', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            page_size: 100
          })
        });
        const data = await results.json();
        setItems(data.conversations);
    } catch(err) {
      console.log('getConversations error: ',err);
    }
  };
```

The server obtains a list of Conversations and returns it to the client:

*server.js*

``` js
app.post('/getConversations', function(req, res) {
    console.log('/getConversations: ',req);
    nexmo.conversations.get({page_size: req.body.page_size},(err, response) => {
        if (err) {
            res.sendStatus(500);
        } else {
            res.send(response._embedded);
        }
    });
});
```

### Listing a new item for sale

If the role of Seller was selected, the application displays a form that allows the User to add an item for sale. This is shown in the following screenshot:

![Marketplace App listing add item for sale screenshot](/assets/screenshots/use-cases/digital-marketplace-client-sdk/app-listing-item-for-sale.png)

When you fill out the form and press ‘submit’, a call to create a Conversation is made by the Nexmo Client SDK. Once the Conversation is created, you then join the User to the Conversation as a Member.

The application is alerted that a new item has been listed for sale using a custom event called `item_details`, which passes the item details to the handler.

*NexmoMarketplaceApp.js*

``` jsx
  const createConversation = async() => {
    try{
      const conversation = await nexmoApp.newConversation({
        name: itemName.split(' ').join('-'), // comment out to get a GUID
        display_name: itemName.trim(),
        properties:{
          custom_data:{
            title: itemName,
            description: itemDescription,
            price: itemPrice,
            image_url: itemImage,
          }
        }
      });
      await conversation.join();
      await conversation.sendCustomEvent({ type: 'custom:item_details', body: { title: itemName, description: itemDescription, price: itemPrice, image_url: itemImage }})
      await getConversations();
      setItemName('');
      setItemImage('');
      setItemDescription('');
      setItemPrice('');
    } catch(err){
      console.log('createConversation error: ',err);
    }
  };
```

Then application then displays an updated list with your item at the top.

### The item details page

Clicking on an item calls the Client SDK’s `getConversation` function.  The code checks to see if the current user is a Member of the Conversation. If not, it adds the User as a Member.

Next, events are loaded (such as chat messages) that may have happened prior to the User joining the Conversation.

*NexmoMarketplaceApp.js*

``` jsx
  const getConversation = async (item) => {
    try {
      const conversation = await nexmoApp.getConversation(item.uuid);
      setNexmoConversation(conversation);
      if (!conversation.me){
        await conversation.join();
      }
      let allEvents = await conversation.getEvents({page_size: 100});
      for(const [,event] of allEvents.items) {
        let user = await nexmoApp.getUser(conversation.members.get(event.from).user.id);
        switch(event.type){
          case 'text':
            setChatMessages(chatMessages => [...chatMessages,{avatar: user.image_url, sender:conversation.members.get(event.from), message:event, me:conversation.me}]);
            break;
          case 'custom:item_details':
            setConversationItem({...conversationItem,...event.body, seller: user});
            break;
          case 'custom:stripe_payment':
            setChatMessages(chatMessages => [...chatMessages,{avatar: '', sender:{user:{name:'Stripe'}}, message:{body:{text:`${event.body.paymentDetails.description}: ${event.body.paymentDetails.status}`}}, me:''}]);
            if (event.body.paymentDetails.status === 'succeeded'){
              setConversationItem(prevState => {
                return { ...prevState, status: 'Sold' }
              });
            }
            break;
          default:
        }
      }
      setStage('conversation');
    } catch(err){
      console.log('getConversation error: ',err);
    }
  };
```

### Purchasing items

Let’s say you want to purchase the item. When you click the **Pay Now** button, another custom event, `stripe_payment`, is raised with the Nexmo Client SDK.

> **NOTE:** In this use case, the response from Stripe is mocked. Implementation of a payment gateway is left to you, and depends on your preferred provider.

*NexmoMarketplaceApp.js*

``` jsx
  // Mock a Stripe Payment call. Reference: https://stripe.com/docs/api/charges/create
  const postStripePayment = async() => {
    try{
      const results = await fetch('https://green-crowberry.glitch.me/stripePayment', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          amount: parseFloat(conversationItem.price.replace('$','')) * 100,
          currency: "usd",
          source: "tok_amex", // obtained with Stripe.js
          description: `Charge for ${conversationItem.title} from ${name}.`
        })
      });
      const data = await results.json();
      await nexmoConversation.sendCustomEvent({ type: 'custom:stripe_payment', body: { paymentDetails: data.response }});
    } catch(err){
      console.log('createConversation error: ',err);
    }
  };
```

*server.js*

``` js
// Create a mock Stripe API Response Reference: https://stripe.com/docs/api/charges/create
app.post('/stripePayment', function(req, res) {
    console.log('/stripePayment: ',req);
    res.send({
        response: {
            "id": "ch_1FSNhf2eZvKYlo2CodbBPmwQ",
            "object": "charge",
            "amount": req.body.amount,
            "amount_refunded": 0,
            "application": null,
            "application_fee": null,
            "application_fee_amount": null,
            "balance_transaction": "txn_19XJJ02eZvKYlo2ClwuJ1rbA",
            "billing_details": {
                "address": {
                    "city": null,
                    "country": null,
                    "line1": null,
                    "line2": null,
                    "postal_code": null,
                    "state": null
                },
                "email": null,
                "name": null,
                "phone": null
            },
            "captured": false,
            "created": 1570798723,
            "currency": req.body.currency,
            "customer": null,
            "description": req.body.description,
            "destination": null,
            "dispute": null,
            "failure_code": null,
            "failure_message": null,
            "fraud_details": {},
            "invoice": null,
            "livemode": false,
            "metadata": {},
            "on_behalf_of": null,
            "order": null,
            "outcome": null,
            "paid": true,
            "payment_intent": null,
            "payment_method": "card_1FSNha2eZvKYlo2CtZjDglzU",
            "payment_method_details": {
                "card": {
                    "brand": "visa",
                    "checks": {
                        "address_line1_check": null,
                        "address_postal_code_check": null,
                        "cvc_check": null
                    },
                    "country": "US",
                    "exp_month": 8,
                    "exp_year": 2020,
                    "fingerprint": "Xt5EWLLDS7FJjR1c",
                    "funding": "credit",
                    "installments": null,
                    "last4": "4242",
                    "network": "visa",
                    "three_d_secure": null,
                    "wallet": null
                },
                "type": "card"
            },
            "receipt_email": null,
            "receipt_number": null,
            "receipt_url": "https://pay.stripe.com/receipts/acct_1032D82eZvKYlo2C/ch_1FSNhf2eZvKYlo2CodbBPmwQ/rcpt_FyKMJVAk8reFPxol3uqojWqKWDWCRsv",
            "refunded": false,
            "refunds": {
                "object": "list",
                "data": [],
                "has_more": false,
                "total_count": 0,
                "url": "/v1/charges/ch_1FSNhf2eZvKYlo2CodbBPmwQ/refunds"
            },
            "review": null,
            "shipping": null,
            "source": {
                "id": "card_1FSNha2eZvKYlo2CtZjDglzU",
                "object": "card",
                "address_city": null,
                "address_country": null,
                "address_line1": null,
                "address_line1_check": null,
                "address_line2": null,
                "address_state": null,
                "address_zip": null,
                "address_zip_check": null,
                "brand": "Visa",
                "country": "US",
                "customer": null,
                "cvc_check": null,
                "dynamic_last4": null,
                "exp_month": 8,
                "exp_year": 2020,
                "fingerprint": "Xt5EWLLDS7FJjR1c",
                "funding": "credit",
                "last4": "4242",
                "metadata": {},
                "name": null,
                "tokenization_method": null
            },
            "source_transfer": null,
            "statement_descriptor": null,
            "statement_descriptor_suffix": null,
            "status": "succeeded",
            "transfer_data": null,
            "transfer_group": null
        }
    })
});
```

A handler is registered for the `stripe_payment` event:

*NexmoMarketplaceApp.js*

``` jsx
  useEffect(()=>{
    const setStripePayment = async (sender, event) => {
      setChatMessages(chatMessages => [...chatMessages,{sender:{user:{name:'Stripe'}}, message:{body:{text:`${event.body.paymentDetails.description}: ${event.body.paymentDetails.status}`}}, me:''}]);
      if (event.body.paymentDetails.status === 'succeeded'){
        setConversationItem(prevState => {
          return { ...prevState, status: 'Sold' }
        });
      }
    };
    if(nexmoConversation){
      nexmoConversation.on('custom:stripe_payment', setStripePayment);
      return () => {
        nexmoConversation.off('custom:stripe_payment', setStripePayment);
      };
    }
  });
```

The listener displays the payment notification as a chat message. If the payment `succeeded`, the status of the Item is updated to `Sold`, and the UI refreshed.

## Conclusion

In this use case, you learned how to build a digital marketplace, where you could buy and sell items. The use case demonstrated how to build a client application using the Nexmo Client SDK to send custom events, and then listen for those events to update the state of the application. The server code responded to requests from the client app, for example to implement authentication and return a list of Conversations.

## Where Next?

You should add more robust authentication if you are using this example as the basis for a production application. You can also add custom events to make the buying and selling experience a better one for your users. For example, you could allow users to add items they are interested in purchasing to a list of favorites. Further, you could enable sellers to edit an item that they have listed for sale.

## Useful links

* [Overview](/client-sdk/overview)
* [Tutorials](/client-sdk/tutorials)
* [Use Cases](/client-sdk/use-cases)
