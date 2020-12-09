---
title:  呼び出しを受信する
description:  このステップでは、呼び出しを受信します。

---

呼び出しを受信する
=========

`MainActivity`クラスの最上部、ビュー宣言のすぐ下に、進行中の呼び出しへの参照を保持する`call`プロパティを追加し、現在の着信呼び出しに関する情報を保持する`incomingCall`プロパティを追加します。

```java
private NexmoCall call;
private Boolean incomingCall = false;
```

`MainActivity`クラス内の`onCreate`メソッドの下部に、着信呼び出しについて通知する着信呼び出しリスナーを追加します。

```java
@Override
protected void onCreate(Bundle savedInstanceState) {
    // ...
    client.addIncomingCallListener(it -> {
        call = it;

        incomingCall = true;
        updateUI();
    });
}
```

アプリケーションが呼び出しを受信すると、呼び出しを受け入れるか拒否するオプションを提供したくなります。`updateUI`関数を`MainActivity`クラスに追加します。

```java
class MainActivity : AppCompatActivity() {

    // ...
    private void updateUI() {
        answerCallButton.setVisibility(View.GONE);
        rejectCallButton.setVisibility(View.GONE);
        endCallButton.setVisibility(View.GONE);

        if (incomingCall) {
            answerCallButton.setVisibility(View.VISIBLE);
            rejectCallButton.setVisibility(View.VISIBLE);
        } else if (call != null) {
            endCallButton.setVisibility(View.VISIBLE);
        }
    }
}
```

次に、クライアントSDKでUIをワイヤリングするために、リスナーを追加する必要があります。`MainActivity`クラス内の`onCreate`メソッドの一番下に、このコードを追加します：

```java
@Override
protected void onCreate(Bundle savedInstanceState) {
    // ...
    answerCallButton.setOnClickListener(view -> {
        in`comingCall = false;
        updateUI();
        call.answer(null);

    });

    rejectCallButton.setOnClickListener(view -> {
        incomingCall = false;
        call = null;
        updateUI();

        call.hangup(null);
    });

    endCallButton.setOnClickListener(view -> {
        call.hangup(null);

        call = null;
        updateUI();
    });
}
```

ビルドして実行
-------

もう一度`Cmd + R`を押してビルドして実行します。以前からアプリケーションとリンクされた番号を呼び出すと、`Answer`ボタンと`Reject`ボタンが表示されます。

