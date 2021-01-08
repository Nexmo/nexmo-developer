---
title:  番号管理
description:  Nexmo Developer Dashboard で Number inventory をレンタル、設定、管理します
navigation_weight: 1

---


番号管理
====

電話番号をレンタル、設定、管理する最も簡単な方法は、[Developer Dashboard](https://dashboard.nexmo.com) を使用することです。

Dashboard を使用して、次のことができます。

* [仮想番号のレンタル](#rent-a-virtual-number)
* [仮想番号の設定](#configure-a-virtual-number)

仮想番号のレンタル
---------

Nexmo 仮想番号をレンタルするには：

1. [Developer Dashboard](https://dashboard.nexmo.com) にサインインします。
2. 左側のナビゲーションメニューで、 **[番号]** > **[番号を購入]** の順にクリックします。
3. 必要な属性を選択し、 **[検索]** をクリックします。
4. 必要な番号の横にある **[購入]** ボタンをクリックして、購入を確定します。
5. あなたの仮想番号が **[自分の番号]** に表示されます。
6. アカウントにクレジットがない場合、仮想番号は再販売のためにリリースされます。これを回避するには、[支払いの自動リロード](/numbers/guides/payments#auto-reload-your-account-balance)を有効にします。

> 各仮想番号を月ごとにレンタルします。更新日は、元のサブスクリプション日を基準にしています。レンタル料金は、毎月同じ日に Nexmo アカウントから自動的に差し引かれます。ただし、仮想番号を月の末日にレンタルした場合、更新日は翌月の末日となります。たとえば、2 月 28 日に番号をレンタルした場合、その次の更新日は 3 月 31 日、4 月 30 日のようになります。

仮想番号の設定
-------

Nexmo 仮想番号を設定するには：

1. [Developer Dashboard](https://dashboard.nexmo.com) にサインインします。
2. 左側のナビゲーションメニューで、 **[番号]** > **[自分の番号]** の順にクリックします。
3. 設定したい番号の横にある歯車アイコンをクリックします。
4. 必要に応じて設定を編集し、 **[OK]** をクリックします。([Webhook エンドポイント](/concepts/guides/webhooks)を変更する場合は、まず新しい Webhook エンドポイントが稼働していることを確認してください。)

