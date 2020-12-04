---
title:  コンタクトセンター

products: client-sdk

description:  独自のコンタクトセンターアプリケーションを構築する方法。

languages:
    - Node
*** ** * ** ***
独自のコンタクトセンターを構築する
=================
このユースケースでは、コンタクトセンター機能を使用してアプリケーションを構築する方法を学びます。
コンタクトセンターアプリケーションにはクライアント側アプリケーションのユーザーである`Jane`と`Joe`の2人のエージェントがいます。エージェントはアプリ内通話を発信・受信しますが、発信者は通常の電話を使用できます。
これを実現するために、このガイドは次の3つの部分で構成されています。
1. ユーザーの管理や承認などの基本的なサーバー側機能のための[**サーバー側アプリケーション**](#set-up-your-backend)。これは、[Conversation API](/conversation/overview)で実装されます。
2. コンタクトセンターのユーザーがログインして電話をかけたり受けたりするための[**クライアント側アプリケーション**](#set-up-your-client-side-application)。これは、[VonageクライアントSDK](/client-sdk/in-app-voice/overview)を統合するWeb、iOS、またはAndroidアプリケーションにすることができます。
3. バックエンド側のアプリケーションで[音声用API](/voice/voice-api/overview)を利用する、[追加された高度な音声機能](#add-voice-functionality)。

> **注：** 内部的には、音声用APIとクライアントSDKの両方がConversation APIを使用します。つまり、すべてのコミュニケーションは[会話](/conversation/concepts/conversation)を通じて行われます。これにより、どのようなコミュニケーションチャネルでも、ユーザーのコミュニケーションコンテキストを維持することができます。会話と[イベント](/conversation/concepts/event)はすべて、[Conversation API](/conversation/overview)を通じて利用することができます。
始める前に
-----
Vonageアカウントを持っていることを確認するか、[サインアップ](https://dashboard.nexmo.com/)して無料で開始しましょう！
バックエンドをセットアップする
---------------
クライアントSDKを使用するには、[Conversation API](/conversation/overview)を使用するバックエンドアプリケーションが必要です。ユーザーの管理などの一部の機能は、バックエンドを介してのみ実行できます。会話の作成などの他の機能は、クライアント側とサーバー側の両方で実行できます。
### サーバー側アプリケーションをデプロイする
[必要なConversation API機能](/conversation/guides/application-setup)に使用するバックエンドを実装できます。
ただし、このガイドの使用に役立つように、デモサンプルバックエンドアプリケーションを使用してください。
#### Ruby on Railsのバージョン
[![デプロイ](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/nexmo-community/contact-center-server-rails)
オープンソースであり、[GitHub](https://github.com/nexmo-community/contact-center-server-rails)で入手できるこのプロジェクトに参加または貢献する
#### Node.jsのバージョン
[![デプロイ](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/nexmo-community/contact-center-server-node)
オープンソースであり、[GitHub](https://github.com/nexmo-community/contact-center-server-node)で入手できるこのプロジェクトに参加または貢献する
### Vonageアプリケーションを作成する
Vonageアカウントを作成すると、複数の[Vonageアプリケーション](/conversation/concepts/application)を作成できるようになります。Vonageアプリケーションには、[ユーザー](/conversation/concepts/user)および[会話](/conversation/concepts/conversation)の一意のセットを含めることができます。
前のステップでデモバックエンドアプリケーションをデプロイした後、次の操作を行う必要があります。
1. [Dashboard](https://dashboard.nexmo.com/)から取得できる *APIキー* と *APIシークレット* を使用してログインします
   ![ログイン](/images/client-sdk/contact-center/login.png)
2. アプリケーション名を入力して *[作成]* をクリックして、新しいVonageアプリケーションを作成します
   ![設定](/images/client-sdk/contact-center/setup.png)

> これは[VonageアプリケーションAPI](/api/application.v2)を使用します。デモアプリケーションは必要なWebhookを設定し、使いやすいように公開します。詳細については、以下で説明します。
### Vonage番号を接続する
電話をかけたり受けたりするには、[Vonage番号](/numbers/overview)をレンタルしてVonageアプリケーションに接続する必要があります。
デモバックエンドアプリケーションを使用して、トップバーの **[番号]** タブに移動し、番号を検索します。
![番号の検索](/images/client-sdk/contact-center/numbers-search.png)
番号をレンタルした後、作成したVonageアプリケーションに割り当てます。
![番号の割り当て](/images/client-sdk/contact-center/numbers.png)

> その他の機能と番号管理については、[Numbers API](/numbers/overview)の詳細を読むか、[Dashboard](https://dashboard.nexmo.com/buy-numbers)にアクセスしてください。
### ユーザーを作成する
[ユーザー](/conversation/concepts/user)は、会話の作成、会話への参加、コールの発信および受信などの目的で、アプリケーションにログインすることができます。
このガイドでは、`Jane`という名前のユーザーと`Joe`という名前のユーザーの2人を使用します。それぞれ、コンタクトセンターアプリケーションにログインできるエージェントです。
ユーザーを作成するには、デモバックエンドアプリケーションインターフェースのトップメニューで、 **[ユーザー]** 、 **[新規ユーザー]** の順に選択します。
![新規ユーザー](/images/client-sdk/contact-center/users-new.png)
裏では、[Conversation API](https://developer.nexmo.com/api/conversation#createUser)を使用しています。
簡単にするために、デモアプリケーションはログインを試みるときにユーザーを作成します。
### ユーザーを認証する
VonageクライアントSDKは、SDKおよびAPIにログインするときに[JWT](https://jwt.io/)を使用してユーザーを認証します。これらのJWTは、新しいVonageアプリケーションの作成時に提供されるアプリケーションIDと秘密鍵を使用して生成されます。
セキュリティ上の理由から、クライアントアプリでは秘密鍵を保持しないでください。したがって、JWTはバックエンドによって提供される必要があります。
バックエンドは、クライアント側アプリがユーザーごとに有効なJWTをリクエストできるようにするエンドポイントを公開する必要があります。実際のシナリオでは、アプリにログインしようとするユーザーのIDを確認するために、認証システムを追加することになると思います。
このガイドでは、バックエンドのデモアプリケーションは、デモアプリケーションが提供するAPIキーとともに、ユーザー名を使用する単純なエンドポイントを公開します。
    POST YOUR_BACKEND/api/jwt
このリクエストの本文のペイロードは次のとおりです。
    Payload: {"mobile_api_key":"xxxxxxx","user_name":"Jane"}
`mobile_api_key`は、基本的なセキュリティメカニズムとして、`SDK Integration`のページに記載されています。

> 実際のユースケースでの認証システムの実装については、[こちらのトピックをご覧ください](/conversation/guides/user-authentication)。[このトピック](/conversation/concepts/jwt-acl)では、JWTとACLの詳細をご確認いただけます。
クライアント側アプリケーションを設定する
--------------------
### クライアントアプリを選択する
VonageクライアントSDKは、Web（JavaScript）、iOSおよびAndroidをサポートしています。
ご自分のクライアント側アプリケーションに[SDKを統合](/client-sdk/setup/add-sdk-to-your-app)し、[アプリ内音声機能](/client-sdk/in-app-voice/guides/make-call)を追加することができます。
ただし、開始するために、デモクライアント側アプリケーションのいずれかのクローンを作成して実行できます。
#### iOS（Swift）バージョン
オープンソースであり、[GitHub](https://github.com/nexmo-community/contact-center-client-swift)で入手できるこのプロジェクトをダウンロードして参加または貢献する
#### Android（Kotlin）バージョン
オープンソースであり、[GitHub](https://github.com/nexmo-community/contact-center-client-android-kt)で入手できるこのプロジェクトをダウンロードして参加または貢献する
#### Web（JavaScript/React）バージョン
オープンソースであり、[GitHub](https://github.com/nexmo-community/contact-center-client-react)で入手できるこのプロジェクトをダウンロードして参加または貢献する

> **重要：** クローン作成後、`README`ファイルを確認し、必要なクライアント側のアプリ構成を更新してください。
### クライアントアプリを実行する
この時点で、クライアント側アプリケーションと、それをサポートするバックエンドアプリケーションがあります。
クライアントアプリを2つの異なるデバイスで実行し、一方のデバイスでユーザー`Jane`として、もう一方のデバイスではユーザー`Joe`としてログインできます。
これで、音声用APIを使用して、コールの受信および発信を行ったり、その他の高度な音声機能を追加したりする準備が整いました。
音声機能を追加する
---------
Vonageアプリケーションを作成したら、そのアプリケーションに`answer_url` [Webhook](/concepts/guides/webhooks)を割り当てます。`answer_url`には、Vonageアプリケーションに割り当てられたVonage番号にコールが発信されるとすぐに実行されるアクションが含まれます。これらのアクションは、`answer_url`が返すJSONコードで定義され、[Nexmo Call Control Object（NCCO）](/voice/voice-api/ncco-reference)の構造に従います。
`answer_url`から返されるNCCOを更新すると、コール機能が変更され、コンタクトセンターアプリケーションに豊富な機能を追加できます。
バックエンドデモアプリケーションには、`answer_url`エンドポイントがすでに設定されています。NCCOのコンテンツと有効な機能を更新するには、トップメニューの [ **App Settings (アプリ設定)** ] に移動します。サンプルのNCCOを含むボタンと、カスタムのNCCOを提供するボタンがあります。
### 通話を受信する
主なユースケースでは、発信者がコンタクトセンターアプリケーションに電話をかけたときに、そのコールをエージェントに接続します。エージェント`Jane`はアプリ内でコールを受信します。
[`Inbound Call`] ボタンをクリックすると、NCCOは次のようになります。
```json
[
    {
        "action": "talk",
        "text": "Thank you for calling Jane"
    },
    {
        "action": "connect",
        "endpoint": [
            {
                "type": "app",
                "user": "Jane"
            }
        ]
    }
]
```
次の手順を実行して、これを試してください。
1. クライアント側のアプリを実行します。
2. `Jane`としてログインします。
3. 別の電話で、Vonage アプリケーションに割り当てられた Vonage 番号に発信します。
4. クライアント側のアプリでコールを受信します。
### 通話を発信する
ログインしているユーザー（例：エージェント`Jane`) が、アプリから電話番号に電話をかけることを許可するには、[`Outbound Call`] ボタンをクリックします。その結果、NCCOは次のようになります。
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
                "number": "PARAMS_TO"
            }
        ]
    }
]
```

> **注：*  - PARAMS_TO`は、実行時にアプリユーザーがかけた電話番号に置き換えられます。アプリはこの番号をSDKに渡し、SDKはこの番号を、`answer_url`リクエストパラメーターのパラメーターとして渡します。デモバックエンドアプリケーションはそのパラメーターを受け取り、ユーザーに代わってこのNCCOの`PARAMS_TO`に置き換えます。`answer_urlを介してパラメーターを渡す方法について詳しくは、[このトピック](/voice/voice-api/webhook-reference#answer-webhook-data-field-examples)を参照してください。
試してみましょう。既にログインしている場合は、クライアントアプリの [Call (通話)] ボタンをタップします。アプリからNCCOで設定した電話番号にコールが発信されます。
### 自動音声応答（IVR）の作成
IVRを使用すると、ユーザーの入力に応じてコールを指示できます。たとえば、発信者が`1`を押すと、通話はエージェント`Jane`に転送されます。あるいは、発信者が`2`を押すと、通話がエージェント`Joe`に転送されます。
これを実装するには、[`IVR`] ボタンをクリックします。すると、NCCOは次のようになります。
```json
[
    {
        "action": "talk",
        "text": "Thank you for calling my contact center."
    },
    {
        "action": "talk",
        "text": "To talk to Jane, please press 1, or, to talk to Joe, press 2."
    },
    {
        "action": "input",
        "eventUrl": ["DTMF_URL"]
    }
]
```
NCCOでは、`input`アクションがユーザーが押した数字を収集し、指定された`eventUrl`に送信します。`eventUrl`は、ユーザーの入力に応じて、コールの処理を継続するために実行される、別のNCCOです。この場合、`DTMF_URL`は、バックエンドデモアプリケーションによって実装および公開され、コールをそれぞれのエージェントに接続するためのエンドポイントです。
この例では、NCCOは単に発信者を各エージェントに接続するだけです。`DTMF_URL`は、前に見たものと非常に似ています。
```json
[
    {
        "action": "talk",
        "text": "Please wait while we connect you to Jane"
    },
    {
        "action": "connect",
        "endpoint": [
            {
                "type": "app",
                "user": "Jane"
            }
        ]
    }
]
```
`Joe`に接続されるために実行されるNCCOは、ユーザー名以外同じです。
1. クライアント側のアプリの2つの異なるインスタンスを、2つのエミュレーター、デバイス、ブラウザータブで実行します。
2. 1つのインスタンスで`Jane`としてログインし、もう1つのインスタンスで`Joe`としてログインします。
3. 別の電話で、Vonage アプリケーションに割り当てられた Vonage 番号に発信します。
4. 電話で、接続するエージェントの数字を押します。
5. 接続を要求したエージェントのクライアントアプリで、コールを受信します。
カスタムNCCO
--------
[`Custom`] ボタンをクリックして、さらに多くの[NCCO機能](/voice/voice-api/ncco-reference)を検討し、上記で使用したサンプルNCCOを更新することをお勧めします。
まとめ
---
おめでとうございます！これで、コンタクトセンターアプリケーションが実行されました。
以下のことを実行しました。
* ユーザー管理、承認、Webhookなどを有効にするバックエンドアプリケーションを使用しました。
* Nexmoclient SDKを使用してアプリ内コールの発信および受信を実行するクライアント側のアプリケーションを使用しました。
* Vonageアプリケーション`answer_url`によって返されるNCCOを更新して、音声機能を有効にしました。
次に行うこと
------
* [さまざまなVonageコンポーネント間のイベントフローについて詳しく学ぶ](/conversation/guides/event-flow)。
* [Conversation APIとクライアントSDKアプリケーションを設定するときに必要なコンポーネントについて詳しく学ぶ](/conversation/guides/application-setup)。
* [モバイルアプリにプッシュ通知を追加する](/client-sdk/setup/set-up-push-notifications)。
関連情報

---

* [クライアントSDK](/client-sdk/overview)について調べる
* [音声用API](/voice/voice-api/overview) について調べる
* [Conversation API](/conversation/overview)について調べる

