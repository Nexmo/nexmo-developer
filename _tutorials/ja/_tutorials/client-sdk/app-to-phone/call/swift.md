---
title:  通話を発信する
description:  このステップでは、通話を発信します。

---

通話を発信する
=======

`ViewController`クラスの先頭で、`client`宣言のすぐ下に、進行中の呼び出しへの参照を保持する`NXMCall`プロパティを追加します

```swift
class ViewController: UIViewController, NXMClientDelegate {
    ...
    let client = NXMClient.shared
    var call: NXMCall?
    ...
}
```

`call`プロパティが参照するオブジェクトに基づいて、`callButtonPressed`メソッドが通話の発信または終了に使用できます。`placeCall`および`endCall`メソッドは、ケースごとにトリガーされます。

下記の`PHONE_NUMBER`を、通話をしたい実際の電話番号に置き換えてください。注：gist NCCOで指定されているものと同じである必要があります：

```swift
@IBAction func callButtonPressed(_ sender: Any) {
    if call == nil {
        placeCall()
    } else {
        endCall()
    }
}

func placeCall() {
    callButton.setTitle("End Call", for: .normal)
    client.call("PHONE_NUMBER", callHandler: .server) {  [weak self] (error, call) in
        if let error = error {
            self?.connectionStatusLabel.text = error.localizedDescription
            self?.callButton.setTitle("Call", for: .normal)
        }
        self?.call = call
    }
}

func endCall() {
    call?.hangup()
    call = nil
    callButton.setTitle("Call", for: .normal)
}
```

これで完了です！これで通話を構築し、実行し、発信することができます！素晴らしい！

