---
title:  呼び出しを受信する
description:  このステップでは、呼び出しを受信します。

---

呼び出しを受信する
=========

`ViewController`クラスの先頭で、`client`宣言のすぐ下に、進行中の呼び出しへの参照を保持する`NXMCall`プロパティを追加します。

```swift
class ViewController: UIViewController {
    ...
    let client = NXMClient.shared
    var call: NXMCall?
    ...
}
```

アプリケーションが呼び出しを受信すると、呼び出しを受け入れるか拒否するオプションを提供したくなります。これを行うには、`displayIncomingCallAlert`関数を`ViewController`クラスに追加します。

```swift
class ViewController: UIViewController {
    ...
    func displayIncomingCallAlert(call: NXMCall) {
        var from = "Unknown"
        if let otherParty = call.otherCallMembers.firstObject as? NXMCallMember {
            from = otherParty.channel?.from.data ?? "Unknown"
        }
        
        let alert = UIAlertController(title: "Incoming call from", message: from, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Answer", style: .default, handler: { _ in
            self.call = call
            call.answer(nil)

        }))
        alert.addAction(UIAlertAction(title: "Reject", style: .default, handler: { _ in
            call.reject(nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
```

この`displayIncomingCallAlert`関数は、パラメータとして`NXMCall`をとります。これにより、タイプ`NXMCallMember`に該当する、呼び出しのメンバーにアクセスして着信コールの電話番号を取得できます。コールに応答するための`UIAlertAction`で、以前のプロパティにコールを割り当てることに注意してください。

`displayIncomingCallAlert`を使用するには、クライアントが`NXMCall`着信を受信したときに呼び出される関数を持つ`NXMClientDelegate`を使用する必要があります。

```swift
extension ViewController: NXMClientDelegate {
    ...
    func client(_ client: NXMClient, didReceive call: NXMCall) {
        DispatchQueue.main.async { [weak self] in
            self?.displayIncomingCallAlert(call: call)
        }
    }
}
```

ビルドして実行
-------

もう一度`Cmd + R`を押してビルドして実行します。以前からアプリケーションとリンクされた番号を呼び出すと、警告が表示されます。あなたはピックアップすることができ、呼び出しが接続されます！

![着信呼び出し警告](/meta/client-sdk/ios-phone-to-app/alert.png)

