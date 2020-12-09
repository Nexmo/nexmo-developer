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

`connectionStatusLabel`の下に、`NXMClient`インスタンスを追加します。

```swift
class ViewController: UIViewController {
    ...
    let connectionStatusLabel = UILabel()
    let client = NXMClient.shared
    ...
}
```

JWTを追加します
---------

`viewDidLoad`の最後に、クライアントデリゲートを設定してログインします。`ALICE_JWT`を、前の手順で作成した`JWT`と必ず置き換えてください。トークンの有効期限は6時間に設定されているため、古い場合は新しいトークンを生成する必要があります。

```swift
override func viewDidLoad() {
    ...
    client.setDelegate(self)
    client.login(withAuthToken: "ALICE_JWT")
}
```

クライアントデリゲート
-----------

デリゲートが機能するためには、`NXMClientDelegate`に準拠する`ViewController`を持つ必要があります。ファイルの末尾に拡張子を追加します。

```swift
extension ViewController: NXMClientDelegate {
    
    func client(_ client: NXMClient, didChange status: NXMConnectionStatus, reason: NXMConnectionStatusReason) {
            DispatchQueue.main.async { [weak self] in
            switch status {
            case .connected:
                self?.connectionStatusLabel.text = "Connected"
            case .disconnected:
                self?.connectionStatusLabel.text = "Disconnected"
            case .connecting:
                self?.connectionStatusLabel.text = "Connecting"
            @unknown default:
                self?.connectionStatusLabel.text = "Unknown"
            }
        }
    }
    
    func client(_ client: NXMClient, didReceiveError error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.connectionStatusLabel.text = error.localizedDescription
        }
    }
    
}
```

発生するとエラーが表示され、`connectionStatusLabel`が関連する接続ステータスで更新されます。

ビルドして実行
-------

`Cmd + R`を押してビルドし、もう一度実行します：

![インターフェースが接続されました](/meta/client-sdk/ios-phone-to-app/interface-connected.png)

