---
title:  NXMClient
description:  このステップでは、Vonageサーバーに対して認証を行います。

---

`NXMClient`
===========

チャットを開始する前に、クライアントSDKはVonageサーバーに対して認証する必要があります。`ViewController.swift`には、次の追加が必要です。

ファイルの先頭で、`NexmoClient`をインポートします。

```swift
import UIKit
import NexmoClient
```

`statusLabel`の下に、`NXMClient`インスタンス、`NotificationCenter`インスタンス、`User`プロパティを追加します。

```swift
class ViewController: UIViewController {
    ...
    let statusLabel = UILabel()

    let client = NXMClient.shared
    let nc = NotificationCenter.default
    
    var user: User? {
        didSet {
            login()
        }
    }
}
```

ボタンターゲット
--------

ログインボタンが機能するためには、タップしたときに関数を実行するターゲットを追加する必要があります。`ViewController.swift`ファイルに、これら2つの関数を追加します。

```swift
class ViewController: UIViewController {
    ...

    override func viewDidLoad() {
        ...
    }

    ...

    @objc func setUserAsAlice() {
        self.user = User.Alice
    }

    @objc func setUserAsBob() {
        self.user = User.Bob
    }
}
```

次に、2つの関数を`viewDidLoad`関数の末尾にあるそれぞれのボタンにリンクします。

```swift
override func viewDidLoad() {
    ...

    loginAliceButton.addTarget(self, action: #selector(setUserAsAlice), for: .touchUpInside)
    loginBobButton.addTarget(self, action: #selector(setUserAsBob), for: .touchUpInside)
}
```

ログイン関数を追加する
-----------

`ViewController.swift`の最後に、ユーザープロパティに必要な`login`関数を追加します。この関数はクライアントのデリゲートを設定し、ユーザープロパティが新しい値に設定されたときにログインします。

```swift
class ViewController: UIViewController {
    ...

    override func viewDidLoad() {
        ...
    }

    func login() {
        guard let user = self.user else { return }
        client.setDelegate(self)
        client.login(withAuthToken: user.jwt)
    }
}
```

クライアントのデリゲート
------------

デリゲートが機能するためには、`NXMClientDelegate`に準拠する`ViewController`を持つ必要があります。

```swift
extension ViewController: NXMClientDelegate {
    func client(_ client: NXMClient, didChange status: NXMConnectionStatus, reason: NXMConnectionStatusReason) {
        DispatchQueue.main.async {
            switch status {
            case .connected:
                self.statusLabel.text = "Connected"
            case .disconnected:
                self.statusLabel.text = "Disconnected"
            case .connecting:
                self.statusLabel.text = "Connecting"
            @unknown default:
                self.statusLabel.text = ""
            }
        }
    }

    func client(_ client: NXMClient, didReceiveError error: Error) {
        DispatchQueue.main.async {
            self.statusLabel.text = error.localizedDescription
        }
    }
}
```

発生するとエラーが表示され、`statusLabel`が関連する接続ステータスで更新されます。

ビルドして実行
-------

`Cmd + R`を押してビルドし、もう一度実行します。ログインボタンのいずれかをタップすると、それぞれのユーザーでクライアントにログインします：

![インターフェースが接続されました](/images/client-sdk/ios-in-app-voice/client.png)

