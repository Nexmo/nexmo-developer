---
title:  FacebookページをVonageアカウントにリンクする
description:  このステップでは、Facebookページを Vonageアカウントにリンクする方法を学びます。

---

FacebookページをVonageアカウントにリンクする
=============================

アプリケーションをFacebookに完全にリンクするプロセスは、2つの部分で構成されています：

1. FacebookページをVonageアカウントにリンクする
2. Facebookページを特定のVonageアプリケーションにリンクする

VonageアカウントをFacebookページにリンクしたいけれど、まだVonageアプリケーションを作成していないという場合があります。Vonageアプリケーションを作成後、そのアプリケーションをFacebookページにリンクしている限り、これは問題ありません。この手順では、完全なプロセスの両方の部分を示します。

パート 1：FacebookページをVonageアカウントにリンクする
-----------------------------------

FacebookページをVonageアカウントにリンクすると、Vonageは着信メッセージを処理し、VonageメッセージAPIからメッセージを送信できるようになります。

1. FacebookページをVonageアカウントにリンクするには、[[Link your Facebook Page to Vonage (FacebookページをVonageにリンクする)]](https://messenger.nexmo.com/)をクリックします。

2. ドロップダウンリストから、Vonageアカウントに接続するFacebookページを選択します。

3. VonageアカウントのAPIキーとAPIシークレットを入力します。

4. **[Subscribe (登録)]** をクリックします。登録が成功したことを確認するメールが届きます。

この時点で、VonageアカウントとこのFacebookページがリンクされています。VonageアカウントとFacebookページ間のリンクは90日後に失効します。その後は、[再度リンクする](#re-linking-your-facebook-page-to-your-nexmo-account)必要があります。

パート 2：FacebookページをVonageアプリケーションにリンクする
--------------------------------------

FacebookページがVonageアカウントにリンクされると、どのアプリケーションでもそのページを使用できるようになります。FacebookページをVonageアプリケーションにリンクする：

1. [アプリケーションページ](https://dashboard.nexmo.com/applications)に移動します。

2. リストから、リンクするアプリケーションをクリックします。[Capabilities (機能)]ドロップダウンを使用し、`messages`を選択してフィルタリングすることで、この操作が簡単になります。

3. 次に、 **[Linked external accounts (リンクされた外部アカウント)]** タブを選択します。

4. アプリケーションをリンクするFacebookページの横にある **[Link (リンク)]** ボタンをクリックして、 **プロバイダー** が **Facebook Messenger** であることを確認します。

これで、Facebookページで、ユーザーから送信されたメッセージを受信する準備が整いました。

> **注：** 将来、別のアプリケーションをこのFacebookページにリンクする場合は、パート2で説明した手順を新しいアプリケーションに対して繰り返すだけで済みます。

FacebookページをVonageアカウントに再度リンクする
-------------------------------

VonageアカウントとFacebookページ間のリンクは90日後に失効します。再度リンクするには、次の手順を実行します。

1. 次のページにアクセスして、[ドロップダウンリスト](https://messenger.nexmo.com/)から再度リンクするページを選択します

2. **[Unsubscribe (購読解除)]** をクリックします。

3. ページが正常に購読解除されたら、 **[Subscribe (購読)]** をクリックしてページを再リンクします。

