---
title:  呼び出しを受信する
description:  このステップでは、呼び出しを受信します。

---

呼び出しを受信する
=========

`MainActivity`クラスの最上部、ビュー宣言のすぐ下に、進行中の呼び出しへの参照を保持する`call`プロパティを追加し、現在の着信呼び出しに関する情報を保持する`incomingCall`プロパティを追加します。

```kotlin
private var call: NexmoCall? = null
private var incomingCall = false
```

`MainActivity`クラス内の`onCreate`メソッドの下部に、着信呼び出しについて通知する着信呼び出しリスナーを追加します。

```java
override fun onCreate(savedInstanceState: Bundle?) {
    // ...
    client.addIncomingCallListener { it ->
        call = it
        incomingCall = true
        updateUI()
    }
}
```

アプリケーションが呼び出しを受信すると、呼び出しを受け入れるか拒否するオプションを提供したくなります。`updateUI`関数を`MainActivity`クラスに追加します。

```kotlin
class MainActivity : AppCompatActivity() {
    
    // ...
    private fun updateUI() {
        answerCallButton.visibility = View.GONE
        rejectCallButton.visibility = View.GONE
        endCallButton.visibility = View.GONE
        if (incomingCall) {
            answerCallButton.visibility = View.VISIBLE
            rejectCallButton.visibility = View.VISIBLE
        } else if (call != null) {
            endCallButton.visibility = View.VISIBLE
        }
    }
}
```

次に、クライアントSDKでUIをワイヤリングするために、リスナーを追加する必要があります。`MainActivity`クラス内の`onCreate`メソッドの一番下に、このコードを追加します：

```kotlin
override fun onCreate(savedInstanceState: Bundle?) {
        
    // ...
    answerCallButton.setOnClickListener {
        incomingCall = false
        updateUI()
        call?.answer(object : NexmoRequestListener<NexmoCall> {
            override fun onError(p0: NexmoApiError) {
            }

            override fun onSuccess(p0: NexmoCall?) {
            }
        })
    }

    rejectCallButton.setOnClickListener {
        incomingCall = false
        call = null
        updateUI()

        call?.hangup(object : NexmoRequestListener<NexmoCall> {
            override fun onError(p0: NexmoApiError) {
            }

            override fun onSuccess(p0: NexmoCall?) {
            }
        })
    }

    endCallButton.setOnClickListener {
        call?.hangup(object : NexmoRequestListener<NexmoCall> {
            override fun onError(p0: NexmoApiError) {
            }

            override fun onSuccess(p0: NexmoCall?) {
            }
        })
        call = null
        updateUI()
    }
}      
```

ビルドして実行
-------

もう一度`Cmd + R`を押してビルドして実行します。以前からアプリケーションとリンクされた番号を呼び出すと、`Answer`ボタンと`Reject`ボタンが表示されます。

