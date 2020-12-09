---
title:  NCCOを作成する
description:  このステップでは、GitHub Gistを使用してNCCOを変更します。

---

NCCOを作成する
=========

Nexmo Call Control Object（NCCO）は、音声用API呼び出しのフロー制御に使用するJSON配列です。NCCOの詳細については、[こちら](/voice/voice-api/ncco-reference)をご覧ください。

NCCOはパブリックであり、インターネットでアクセスできる必要があります。そのためには、設定をホストする便利な方法を提供する[GitHub Gist](https://gist.github.com/)を使用します。

1. [GitHub](https://github.com)にログインしていることを確認し、https://gist.github.com/に移動します。

2. `ncco.json`を「拡張子を含むファイル名」に入力します。

3. 次のJSONオブジェクトをコピーして、gistに貼り付けます：

```json
[
    {
        "action": "talk",
        "text": "Connecting you to Bob"
    },
    {
        "action": "connect",
        "endpoint": [
            {
                "type": "app",
                "user": "Bob"
            }
        ]
    }
]
```

1. `Create secret gist`ボタンをクリックします：

```screenshot
image: public/screenshots/tutorials/client-sdk/app-to-app/create-ncco/gist1.png
```

1. `Raw`ボタンをクリックします：

```screenshot
image: public/screenshots/tutorials/client-sdk/app-to-app/create-ncco/gist2.png
```

1. ブラウザに表示されているURLを書き留めください、次のステップでそれを使用します。

