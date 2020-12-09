---
title:  NCCOを作成する
description:  このステップでは、GitHub Gistを使用してNCCOを変更します。

---

NCCOを作成する
=========

Nexmo Call Control Object（NCCO）は、音声用API呼び出しのフロー制御に使用されるJSON配列です。NCCOの詳細については、[こちら](/voice/voice-api/ncco-reference)をご覧ください。

NCCOはパブリックであり、インターネットでアクセスできる必要があります。そのためには、設定をホストする便利な方法を提供する[GitHub Gist](https://gist.github.com/)を使用します：

1. https://gist.github.com/に移動します。

2. `ncco.json`を「拡張子を含むファイル名」に入力します。

3. 次のJSONオブジェクトをコピーして、gistに貼り付けます：

```json
[
    {
        "action": "talk",
        "text": "Thank you for calling Alice"
    },
    {
        "action": "connect",
        "endpoint": [
            {
                "type": "app",
                "user": "Alice"
            }
        ]
    }
]
```

1. `Create secret gist`ボタンをクリックします：

![シークレットgistを作成する](/meta/client-sdk/phone-to-app/create-ncco/gist1.png)

1. `Raw`ボタンをクリックします：

![gistを未加工ファイルとして表示](/meta/client-sdk/phone-to-app/create-ncco/gist2.png)

1. ブラウザに表示されているURLを書き留めください、次のステップでそれを使用します。

