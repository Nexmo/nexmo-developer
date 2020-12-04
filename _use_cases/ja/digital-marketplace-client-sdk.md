---
title:  デジタルマーケットプレイス

products: client-sdk

description:  独自のデジタルマーケットプレイスアプリケーションを構築する方法。

languages:
    - Node
*** ** * ** ***
デジタルマーケットプレイス
=============
このユースケースでは、デジタルマーケットプレイスの構築方法をご紹介します。[ここから、アクション付きでご覧ください](https://green-crowberry.glitch.me/)。
このサンプルアプリケーションは、次のツールと技術を用いて構築されました。
* VonageクライアントSDK
* React（フロントエンド）
* Node JS/Express（バックエンド）
このユースケースでは、クライアントSDKでカスタムイベントを使用します。カスタムイベントは次の場合にアプリケーションに警告するために使用します。
* ユーザーが販売する新しいアイテムを一覧表示する
* 顧客がStripeを使用してアイテムを購入する
準備
---
また、前提として次の動作をすでに行っているものとします。
1. [Vonageアカウント](https://dashboard.nexmo.com/sign-up)を作成する。
2. [Dashboard](https://dashboard.nexmo.com/getting-started-guide)に表示されるVonage APIキーとAPIシークレットをメモする。
手順
---
このユースケースの主な手順は次のとおりです。
1. [Vonageアプリケーションを作成する](#create-a-nexmo-application)
2. [アプリケーションを認証する](#authenticate-your-application)
3. [アプリケーションを構成する](#configure-your-application)
4. [コードを試行する](#code-walkthrough)
Vonageアプリケーションを作成する
-------------------
Vonageアプリケーションは、Dashboardから次の手順で作成できます。
1. Dashboardで、[[Your Applications (アプリケーション)](https://dashboard.nexmo.com/applications)] に移動します。
2. [ **Create a new application (新規アプリケーションを作成)** ] をクリックします。
3. アプリケーションの名前を入力します（「 **クライアントSDKマーケットプレイスアプリ** 」など）。
4. [ **Authentication (認証)** ] セクションで、[ **Generate public and private key (公開鍵と秘密鍵を生成)** ] をクリックします。これにより、公開鍵/秘密鍵のペアが生成されます。秘密鍵ファイルがコンピュータにダウンロードされます。このファイルは後で使用します。
5. [ **Capabilities (機能)** ] セクションで、[RTC] を選択します。
6. RTC機能の場合は、イベントURL（`https://example.com/event`）を入力できます。
7. [ **Generate new application (新規アプリケーションを生成)** ] をクリックします。
8. 生成されたアプリケーションIDをメモします。
これで、DashboardからVonageアプリケーションを作成できました。
このとき重要なのは、秘密鍵ファイルとアプリケーションIDです。これらは以降のセクションで必要になってきます。
コードリポジトリ
--------
次のいずれかを実行することで、既存のコードを使用して、このプロジェクトのオリジナルバージョンを構築できます。
* [Glitchプロジェクトをリミックスする](https://glitch.com/edit/#!/remix/green-crowberry)
* [GitHubリポジトリのクローンを作成する](https://github.com/nexmo-community/client-sdk-marketplace-use-case)
アプリケーションを認証する
-------------
[生成した](#create-a-nexmo-application)秘密鍵ファイルを使用して、アプリケーションを認証する必要があります。
### Glitchを使用する
テキストエディタで`private.key`ファイルを開きます。Glitchプロジェクトで`/.data/private.key`ファイルを作成し、`private.key`の内容をコピーして貼り付けます。
![Vonageアプリケーションの秘密鍵があるGlitchのスクリーンショット](/screenshots/use-cases/digital-marketplace-client-sdk/private-key-location-glitch.png)
### GitHubを使用する
`private.key`ファイルをプロジェクトのルートに移動します。
![Vonageアプリケーションの秘密鍵があるローカルのスクリーンショット](/screenshots/use-cases/digital-marketplace-client-sdk/private-key-location-local.png)
アプリケーションを構成する
-------------
Glitchプロジェクトをリミックスする場合でも、GitHubリポジトリのクローンを作成する場合でも、`.env`ファイルを使用してアプリケーションを構成する必要があります。
各変数に、これまでの手順で取得した関連する値を割り当てます。
`.env`ファイルの構造は、GlitchとGitHubのどちらを使用しているかによって多少異なります。以降のセクションで、`.env`ファイルの編集方法について説明します。
### Glitchの場合
`.env`を次のように修正します。プレースホルダのテキストはそれぞれの値に置き換えてください。
    DANGEROUSLY_DISABLE_HOST_CHECK=true
    API_KEY="your-value-here"
    API_SECRET="your-value-here"
    APP_ID="your-value-here"
    PRIVATE_KEY="/.data/private.key"
### GitHubの場合
`.env`を次のように修正します。プレースホルダのテキストはそれぞれの値に置き換えてください。
    API_KEY="your-value-here"
    API_SECRET="your-value-here"
    APP_ID="your-value-here"
    PRIVATE_KEY="/private.key"
これですべての構成が完了しました。
コードを試行する
--------
このセクションでは、アプリケーションの最も重要な部分に関するコードを試行します。
### ログイン
ログイン画面は、次のようになっています。
![マーケットプレイスアプリのログイン画面のスクリーンショット](/screenshots/use-cases/digital-marketplace-client-sdk/app-login.png)
ユーザーはユーザー名を入力し、[Seller (販売者)] または [Buyer (購入者)] のどちらかの役割を選択します。
`POST`リクエストの本文には、ユーザー名、表示名、画像URLの設定に使用できるプロパティがありますが、役割を指定するプロパティはありません。独自のプロパティを`custom_data`に追加できるため、次のようにして`role`を作成することができます。
*NexmoMarketplaceApp.js* 
```jsx
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
### 認証
クライアントSDKは、[JWT](/concepts/guides/authentication#json-web-tokens-jwt)を使用して認証します。アプリケーションがNode Expressサーバーを呼び出してJWTを取得し、ユーザーをログインさせます。サーバー側のコードは次のようになります。
*server.js* 
```js
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
// the client calls this endpoint to create a new user in the Vonage application,
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
クライアントアプリ自体には、 JWTを取得し、ユーザーをログインさせる機能があります。
*NexmoMarketplaceApp.js* 
```jsx
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
### 販売アイテムを表示する
ユーザーがログインすると、アプリはすべての販売アイテムのリスト（会話オブジェクトのリスト）を取得します。クライアントはサーバーを呼び出し、サーバーは会話のリストを返します。クライアント側のコードは次のようになります。
*NexmoMarketplaceApp.js* 
```jsx
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
サーバーは会話のリストを取得し、これをクライアントに返します。
*server.js* 
```js
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
### 販売する新しいアイテムを一覧表示する
役割が販売者の場合、アプリケーションにはユーザーが販売アイテムを追加できるフォームが表示されます。これは次のような画面です。
![マーケットプレイスアプリのリストに販売アイテムを追加するスクリーンショット](/screenshots/use-cases/digital-marketplace-client-sdk/app-listing-item-for-sale.png)
フォームに入力して [submit (送信)] を押すと、VonageクライアントSDKによって会話を作成する呼び出しが行われます。会話が作成された後、ユーザーをメンバーとして会話に参加させます。
アプリケーションは、アイテムの詳細をハンドラに渡す`item_details`というカスタムイベントを使用して、新しいアイテムが販売リストに追加されたという通知を受け取ります。
*NexmoMarketplaceApp.js* 
```jsx
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
次に、アプリケーションのリストが更新され、追加したアイテムが一番上に表示されます。
### アイテムの詳細ページ
アイテムをクリックすると、クライアントSDKの`getConversation`機能が呼び出されます。コードは、現在のユーザーが会話のメンバーかどうかをチェックします。メンバーでない場合は、ユーザーをメンバーとして追加します。
次に、ユーザーが会話に参加する前に発生したイベント（チャットメッセージなど）がロードされます。
*NexmoMarketplaceApp.js* 
```jsx
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
### アイテムを購入する
アイテムを購入したいとします。[ **Pay Now (今すぐ支払い)** ] ボタンをクリックすると、別のカスタムイベントである`stripe_payment`がVonageクライアントSDKで発生します。

> **注：** このユースケースでは、Stripeからの応答はモックです。支払いゲートウェイの実装はお客様側で行うため、選択したプロバイダーによって異なります。
*NexmoMarketplaceApp.js* 
```jsx
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
```js
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
`stripe_payment`イベントに対してハンドラが登録されます。
*NexmoMarketplaceApp.js* 
```jsx
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
リスナーが、チャットメッセージ形式で支払い通知を表示します。支払いが`succeeded`の場合、アイテムのステータスが`Sold`に更新され、UIが更新されます。
まとめ
---
このユースケースでは、アイテムを売買できるデジタルマーケットプレイスの構築方法についてご紹介しました。具体的にはVonageクライアントSDKを使用してクライアントアプリケーションを構築し、カスタムイベントを送信する方法と、これらのイベントをリッスンしてアプリケーションのステータスを更新する方法について説明しました。また、サーバーコードは、認証を実装して会話のリストを返すなど、クライアントアプリからのリクエストに応答しました。
次の作業
----
このサンプルを、本番アプリケーションのベースとして使用する場合は、より堅牢な認証を追加する必要があります。また、ユーザーの購入・販売体験を向上させるためのカスタムイベントを追加することもできます。たとえば、ユーザーが購入したいアイテムをお気に入りリストに追加できるようにするといったことです。さらに、販売者が販売中のアイテムを編集できるようにすることもできます。
役立つリンク

---

* [概要](/client-sdk/overview)
* [チュートリアル](/client-sdk/tutorials)
* [ユースケース](/client-sdk/use-cases)

