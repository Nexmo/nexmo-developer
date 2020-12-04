---
title:  注文サポートシステム

products: client-sdk

description:  VonageクライアントSDKとSendinblueを使用して、製品の注文確認とサポートシステムを構築する方法

languages:
    - Node
*** ** * ** ***
注文サポートシステム
==========
始める前に
-----
[Vonageアカウント](https://dashboard.nexmo.com/sign-in)と[Sendinblueアカウント](https://app.sendinblue.com/account/register)の両方、および関連するAPIキーとシークレットを持っていることが前提となります。
概要
---
このユースケースでは、VonageクライアントSDKとSendinblueを使用して、注文確認およびサポートシステムの構築方法を学習します。このユースケースは、サポートエージェントとの双方向のチャットと、Sendinblue経由での注文確認メールの送信を取り上げます。
シナリオは次のとおりです。
1. ユーザーが注文を作成します。注文確認メールが[Sendinblue](https://www.sendinblue.com)経由でユーザーに送信されます。注文メールには、ユーザーがクリックすることで注文についてサポートエージェントとチャットできるリンクが記載されています。
2. 確認メールが送信されると、[カスタムイベント](/client-sdk/custom-events)が作成されます。これは、そのユーザーの会話で保持されます。
3. 現在の注文データ、注文履歴、メッセージ履歴を含むチャット画面が読み込まれます。注文とメッセージの履歴は、そのユーザーが関連する会話に保存されます。
4. その後、顧客とサポートエージェントとの間で双方向チャットを行うことができます。
インストール
------
次の手順は、コマンドラインで`git`コマンドと`npm`コマンドを使用できることを前提としています。
**1\.** Nexmo CLIをインストールします：
```bash
npm install nexmo-cli@beta -g
```

> **注：** このデモには、Nexmo CLIのベータ版が必要です。
**2\.** Nexmo CLIで使用するために認証情報を初期化します。
```bash
nexmo setup NEXMO_API_KEY NEXMO_API_SECRET
```
これにより、LinuxまたはmacOS上の`~/.nexmorc`ファイルが更新されます。Windowsでは、このファイルはたとえば`C:\Users\James\.nexmorc`などのユーザーディレクトリに保存されます。
**3\.** このユースケースのGitHubリポジトリのクローンを作成します：
```bash
git clone https://github.com/nexmo-community/sendinblue-use-case.git
```
**4\.** クローンされたプロジェクトディレクトリに移動します。
**5\.** 必要なNPMモジュールをインストールします。
```bash
npm install
```
これにより、`package.json`ファイルに基づいて必要なモジュールがインストールされます。
**6\.*  - example.env`をプロジェクトディレクトリ内の`.env`にコピーします。後のステップで`.envを編集して、認証情報およびその他の設定情報を指定します。
**7\.** Vonageアプリケーションを[インタラクティブ](/application/nexmo-cli#interactive-mode)に作成します。次のコマンドはインタラクティブモードに入ります：
```bash
nexmo app:create
```
a. アプリケーション名を指定します。Enterキーを押して続行します。
b. 矢印キーでRTC機能を指定し、スペースバーを押して選択します。Enterキーを押して続行します。
c.「デフォルトのHTTP方式を使用しますか？」の場合は、Enterキーを押してデフォルトを選択します。
d.「RTCイベントURL」の場合は、`https://example.ngrok.io/webhooks/rtc`または他の適切なURL（テスト方法によって異なる）を入力します。
e.「公開キーのパス」の場合は、Enterキーを押してデフォルトを選択します。
f.「秘密キーのパス」の場合は、`private.key`を入力し、Enterキーを押します。
その後、アプリケーションが作成されます。
`.nexmo-app`ファイルは、アプリケーションIDとプライベートキーを含むプロジェクトディレクトリに作成されます。
**8\.** エディタを使用して、プロジェクトディレクトリ内に`.env`ファイルを開きます。
**9\.** VonageアプリケーションIDを`.env`ファイル（`NEXMO_APPLICATION_ID`）に追加します。
構成
---
次の内容を設定します。
```text
NEXMO_APPLICATION_ID=App ID for the application you just created
NEXMO_API_KEY=
NEXMO_API_SECRET=
NEXMO_APPLICATION_PRIVATE_KEY_PATH=private.key
CONVERSATION_ID=
PORT=3000
SENDINBLUE_API_KEY=
SENDINBLUE_FROM_NAME=
SENDINBLUE_FROM_EMAIL=
SENDINBLUE_TO_NAME=
SENDINBLUE_TO_EMAIL=
SENDINBLUE_TEMPLATE_ID=
```
1. Vonage APIのキーとシークレットを設定します。Vonage APIのキーとVonage APIのシークレットは、[Dashboard](https://dashboard.nexmo.com)から取得できます。
2. ポート番号を設定します。この例ではポート3000を使用していることを前提としていますが、任意の適切な空きポートを使用できます。

> **注：** カンバセーションIDは、テスト目的でのみ使用されます。この段階で設定する必要はありません。
では、これからSendinblueの設定に進みます。
### Sendinblueの設定
[Sendinblue API キー](https://account.sendinblue.com/advanced/api)が必要です。
このユースケースのテストでは、Sendinblueの「送信者」情報を保有していることを前提としています。情報は、メールの **送信元** のメールアドレスと名前です。
また、注文確認メールを受信するユーザー名とメールアドレスを指定する必要があります。通常、この情報はユーザーデータベースで顧客ごとに使用できますが、このユースケースでは、テストでの便宜上、環境ファイルに設定されます。情報は、メールの **送信先** のメールアドレスと名前です。
また、使用している[メールテンプレート](https://account.sendinblue.com/camp/lists/template)のIDも必要です。テンプレートはSendinblue UIで作成されます。テンプレートを作成してアクティブ化したら、UIで指定されたIDをメモします。ここではこの番号が使用されます。
このデモで使用できるサンプルテンプレートを以下に示します。
    ORDER CONFIRMATION
    
    Dear {{params.name}},
    
    Thank you for your order!
    
    ORDER_ID
    
    {{params.order_id}}
    
    ORDER_TEXT
    
    {{params.order_text}}
    
    If you would like to discuss this order with an agent please click the link below:
    
    {{params.url}}
    
    Thanks again!
このサンプルを使用して、Sendinblueでテンプレートを作成できます。
独自のテンプレートの作成については、[Sendinblueテンプレートの作成](https://help.sendinblue.com/hc/en-us/articles/209465345-Where-do-I-create-and-edit-the-email-templates-used-in-SendinBlue-Automation-)を参照してください。

> **重要：** テンプレートを作成したら、続行する前に、テンプレートID（Sendinblue UIから取得可能な整数）を`.env`ファイルに追加してください。
コードの実行
------
デモを実行するにはいくつかのステップがあります。
**1\.** プロジェクトディレクトリでサーバーを起動します。
```bash
npm start
```
これにより、`node.js`を使用してサーバーが起動します。
**2\.** 次のCurlコマンドを使用して、サポートエージェントユーザーを作成します。
    curl -d "username=agent" -H "Content-Type: application/x-www-form-urlencoded" -X POST http://localhost:3000/user
次のような応答が返されるサーバーコンソールのログを確認します。
    Creating user agent
    User agent and Conversation CON-7f1ae6c9-9f52-455e-b8e4-c08e96e6abcd created.
これにより、ユーザー「エージェント」が作成されます。「エージェント」の場合、このデモで会話は使用されません。

> **重要：** この簡単なデモでは、他のユーザーよりも先にサポートエージェントを作成する必要があります。このユースケースでは、エージェントはユーザー名`agent`を持っている必要があります。
**3\.** 顧客ユーザーを作成します。
    curl -d "username=user-123" -H "Content-Type: application/x-www-form-urlencoded" -X POST http://localhost:3000/user
これにより、ユーザー「user-123」が作成されます。ここで任意のユーザー名を指定できます。指定したユーザー名をメモしておいてください。
サーバーコンソールのログから、ユーザーに対する会話も作成されていることがわかります。
    Creating user user-123
    User user-123 and Conversation CON-7f1ae6c9-9f52-455e-b8e4-c08e96e6abcd created.
**4\.** 顧客の注文を作成します。
    curl -d "username=user-123" -H "Content-Type: application/x-www-form-urlencoded" -X POST http://localhost:3000/order
これにより、ユーザー「user-123」の注文が作成されます。簡単にするために、本格的なショッピングカートではなく、事前定義された単純な静的注文とします。サーバーコンソールのログを確認すると、次のようなものが表示されます。
```text
Creating order...
Order URL: http://localhost:9000/chat/user-1234/CON-7f1ae6c9-9f52-455e-b8e4-c08e96e6abcd/1234
Sending order email user-1234, 1234, Dear user-1234, You purchased a widget for $4.99! Thanks for your order!, http://localhost:9000/chat/user-1234/CON-7f1ae6c9-9f52-455e-b8e4-c08e96e6abcd/1234
API called successfully. Returned data: [object Object]
```
このステップでは、注文の詳細を含む`custom:order-confirm-event`タイプのカスタムイベントも生成されます。
さらに、Sendinblue経由で確認メールが送信されます。このメールには、ユーザーが注文のサポートを希望する場合にチャットするためのリンクが含まれています。
**5\.** 注文メールを受け取ったことを確認します。設定で定義されている受信トレイに移動して、確認メールを開きます。
**6\.** メール内のリンクをクリックして、顧客をチャット画面にログインさせます。
**7\.** エージェントをチャットにログインさせます。この手順では、ブラウザで「シークレット」タブを追加で起動することをお勧めします（または新しいブラウザインスタンスを使用します）。
簡単にするために、サポートエージェントは顧客と同様の方法でチャットにログインします。クライアントがメールでクリックしたリンクをコピーし、`agent`リンクのユーザー名を変更することができます。
    localhost:3000/chat/agent/CON-ID/ORDER-ID
これで、ユーザーとサポートエージェントは双方向のチャットメッセージセッションに参加して、注文について話し合うことができます。
コードの探索
------
主なコードファイルは`client.js`と`server.js`です。
**サーバー** は、ユーザーと注文を作成するための単純なREST APIを実装しています。
1. `POST` `/user`でユーザーを作成します。ユーザー名は本文に渡されます。
2. `POST` `/order`で注文を作成します。注文を作成するユーザーのユーザー名が本文に渡されます。
3. `GET` `/chat/:username/:conversation_id/:order_id`で、`username`に基づいてユーザーまたはエージェントをチャットルームにログインさせます。
**クライアント** は、VonageクライアントSDKを使用します。次の主な機能を実行します。
1. `NexmoClient`インスタンスを作成します。
2. サーバーによって生成されたJWTに基づいて、ユーザーを会話にログインさせます。
3. 会話オブジェクトを取得します。
4. メッセージ送信ボタンと`text`イベントのイベントハンドラを登録します。
5. 現在の注文、注文履歴、メッセージ履歴、および進行中のチャットを表示するための基本UIを提供します。
まとめ
---
このユースケースでは、注文確認とサポートシステムの構築方法を学びました。ユーザーはSendinblue経由で注文確認メールを受信します。その後、ユーザーは、必要に応じてサポートエージェントと双方向のメッセージングを行い、注文について話し合うことができます。
次に行うこと
------
デモを改善するためのいくつかの提案：
* CSSを使用してUIを改善します。
* より洗練された注文システムを追加します。おそらく、各注文はJSONスニペットになります。
* [クリックしてサポートエージェントに電話する](/client-sdk/tutorials/app-to-phone/introduction)機能を追加します。
* ユーザーがチャットルームに参加したときにSMS通知をエージェントに送信します。
関連情報

---

* [GitHubのデモコードリポジトリ](https://github.com/nexmo-community/sendinblue-use-case)
* [Node用のSendinblueクライアントライブラリ](https://github.com/sendinblue/APIv3-nodejs-library)
* [Sendinblueでのトランザクションメールの送信](https://developers.sendinblue.com/docs/send-a-transactional-email)
* [クライアントSDKのドキュメント](/client-sdk/overview)
* [Conversation APIのドキュメント](/conversation/overview)
* [Conversation API関連情報](/api/conversation)

