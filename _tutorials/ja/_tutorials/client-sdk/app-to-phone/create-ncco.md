---
title:  NCCOを作成する
description:  このステップでは、GitHub Gistを使用してNCCOを変更します。

---

NCCOを作成する
=========

Nexmo Call Control Object（NCCO）は、音声用API呼び出しのフロー制御に使用されるJSON配列です。NCCOの詳細については、[こちら](/voice/voice-api/ncco-reference)をご覧ください。

NCCOはパブリックであり、インターネットでアクセスできる必要があります。そのためには、設定をホストする便利な方法を提供する[GitHub Gist](https://gist.github.com/)を使用します：

1. [GitHub](https://github.com)にログインしていることを確認し、https://gist.github.com/に移動します。

2. `ncco.json`を「拡張子を含むファイル名」に入力します。

3. 次のJSONオブジェクトをコピーして、gistに貼り付けます：

```json
[
    {
        "action": "talk",
        "text": "Please wait while we connect you."
    },
    {
        "action": "connect",
        "endpoint": [
            {
                "type": "phone",
                "number": "PHONE_NUMBER"
            }
        ]
    }
]
```

1. `PHONE_NUMBER`を自分の電話番号に置き換えてください。Vonageの番号は[E.164](/concepts/guides/glossary#e-164-format)形式です。「\+」と「-」は無効です。電話番号を入力する際は、必ず国コードを指定してください。たとえば、米国：14155550100、英国：447700900001などです。

2. `Create secret gist`ボタンをクリックします：

```screenshot
image: public/screenshots/tutorials/client-sdk/app-to-phone/create-ncco/gist1.png
```

1. `Raw`ボタンをクリックします：

```screenshot
image: public/screenshots/tutorials/client-sdk/app-to-phone/create-ncco/gist2.png
```

1. ブラウザに表示されているURLを書き留めてください、次のステップでそれを使用します。

