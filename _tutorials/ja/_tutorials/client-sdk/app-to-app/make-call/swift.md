---
title:  通話を発信する
description:  このステップでは、アプリからアプリへの通話を発信する方法を学びます。

---

通話を発信する
=======

通話を発信するには、`CallViewController` UIの`callButton`を使用します。まず、ボタンにターゲットを追加する必要があります。

```swift
class CallViewController: UIViewController {
    ...
    override func viewDidLoad() {
        ...
        callButton.addTarget(self, action: #selector(makeCall), for: .touchUpInside)
    }
}
```

`callButton`をタップすると、`makeCall`関数が呼び出されます。`CallViewController`クラスの最後に追加します。

```swift
class CallViewController: UIViewController {
    ...
    @objc private func makeCall() {
        setStatusLabelText("Calling (user.callPartnerName)")

        client.call(user.callPartnerName, callHandler: .server) { error, call in
            if error != nil {
                self.setStatusLabelText(error?.localizedDescription)
                return
            }
            call?.setDelegate(self)
            self.setHangUpButtonHidden(false)
            self.call = call
        }
    }
}
```

`makeCall`関数は、`NXMClient`インスタンスを使用して通話の発信を行います。クライアントSDKは、サーバーでの通話発信、`NCCO`を提供する応答URL、またはアプリ内での直接発信をサポートします。エラーがない場合、通話のデリゲートが設定され、通話の変更が監視できるようになり、`hangUpButton`が表示されます。

ビルドして実行
-------

`Cmd + R`を押してビルドし、もう一度実行します。これで通話アプリが機能しました！テストするには、2つの異なるシミュレータ/デバイスでアプリを実行し、Bobユーザーとしてログインしているデバイスから、Aliceユーザーとしてログインしたデバイスを呼び出すことができます：

![送信済みメッセージ](/images/client-sdk/ios-in-app-voice/active-call.png)

