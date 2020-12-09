---
title:  NXMClient
description:  このステップでは、Vonageサーバーに対して認証を行います。

---

`NXMClient`
===========

通話を発信する前に、クライアントSDKはVonageサーバーに対して認証する必要があります。`ViewController.swift`には、次の追加が必要です。

ファイルの先頭で、`NexmoClient`をインポートします。

```swift
import UIKit
import NexmoClient
```

`callButton`の下に、`NXMClient`インスタンスを追加します。

```swift
class ViewController: UIViewController {
    ...
    var callButton = UIButton(type: .roundedRect)
    let client = NXMClient.shared
    ...
}
```

JWTを追加する
--------

`viewDidLoad`の最後に、クライアントデリゲートを設定してログインします。`ALICE_JWT`を、必ず前の手順で作成した`JWT`で置き換えてください。トークンの有効期限は6時間に設定されているため、古い場合は新しいトークンを生成する必要があります。

```swift
override func viewDidLoad() {
    ...
    client.setDelegate(self)
    client.login(withAuthToken: "ALICE_JWT")
}
```

クライアントデリゲート
-----------

デリゲートが機能するためには、`NXMClientDelegate`に適合する`ViewController`を持つ必要があります。ファイルの末尾に、この拡張子を追加します。

```swift
extension ViewController: NXMClientDelegate {
    
    func client(_ client: NXMClient, didReceiveError error: Error) {
        print("✆  ‼️ connection error: (error.localizedDescription)")
        DispatchQueue.main.async { [weak self] in
            self?.callButton.alpha = 0
            self?.connectionStatusLabel.text = error.localizedDescription
        }
    }
    
    func client(_ client: NXMClient, didChange status: NXMConnectionStatus,
                reason: NXMConnectionStatusReason) {
        DispatchQueue.main.async { [weak self] in
            self?.callButton.alpha = 0
            switch status {
            case .connected:
                self?.connectionStatusLabel.text = "Connected"
                self?.callButton.alpha = 1
            case .disconnected:
                self?.connectionStatusLabel.text = "Disconnected"
            case .connecting:
                self?.connectionStatusLabel.text = "Connecting"
            @unknown default:
                self?.connectionStatusLabel.text = "Unknown"
            }
        }
    }
    
}
```

発生するとエラーが表示され、`connectionStatusLabel`が関連する接続ステータスで更新されます。また、接続すると `callButton`が表示されます。

ビルドして実行
-------

`Cmd + R` ビルドしてもう一度実行：

![インターフェースが接続されました](/images/client-sdk/ios-voice/interface-connected.jpg)

