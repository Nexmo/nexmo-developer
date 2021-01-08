---
title:  ショートコードで 2FAを有効にする
description:  ショートコードを使用して、サービスに登録した電話番号をユーザーが所有していることを確認します
navigation_weight: 2

---


2 要素認証の有効化
==========

[2 要素認証](/concepts/guides/glossary#2fa)(2FA) を使用すると、顧客から提供されている番号が本人のものであるという確証が得られます。米国内の顧客に SMS を送信する場合は、この確認のために[ショートコード](/concepts/guides/glossary#short-code)を使用できます。顧客は、ショートコードに直接応答するか、Web アプリケーションを介して自分の番号を確認します。Nexmo の[2 要素認証 API](/api/sms/us-short-codes/2fa) は、この機能を提供します。

> これらの手順は、共有ショートコードを使用していることを前提としています。Nexmo では、組織固有の専用ショートコードも提供しています。ショートコードの詳細については、[こちらをご覧ください](https://help.nexmo.com/hc/en-us/articles/115013144287-Short-codes-Features-Overview)。

2FA の米国共有ショートコードを設定するには：

1. [Developer Dashboard](https://dashboard.nexmo.com) にサインインします。
2. 左側のナビゲーションメニューで、 **[番号]** > **[番号を購入]** の順にクリックします。
3. **[共有ショートコードを追加]** リンクをクリックします。
4. **[2要素認証用のショートコードを追加する]** ボタンをクリックします。
5. メッセージと会社名を設定します。
6. **[更新]** をクリックします。Nexmo が申請を処理します。承認には最大 5 営業日かかります。

ショートコードの必須要件
------------

Nexmo の事前承認済み米国ショートコードを使用する場合は、サイトのオプトインページで次の情報を **表示する必要があります** 。

* 頻度：貴社のサービスのユーザーが貴社からのメッセージを受信する頻度
* オプトアウトする方法：ショートコードに `STOP` SMSを送信します。
* ヘルプを得る方法：ショートコードに `HELP` SMSを送信します。
* メッセージを受信するためにユーザーにかかるコスト (メッセージとデータレート)
* サービスの利用規約
* お客様のプライバシーポリシー

例：
````
You will receive no more than 2 msgs/day. To opt-out at any time, send STOP to 98765.
To receive more information, send HELP to 98765. Message and data rates may apply.
The terms and conditions can be viewed at <http://url.to/your_t&c.html>. 
Our Privacy Policy can be reviewed at <http://url.to/your_privacypolicy.html>.
````
