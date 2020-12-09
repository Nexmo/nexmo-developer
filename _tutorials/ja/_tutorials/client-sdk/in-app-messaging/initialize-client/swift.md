---
title:  NXMClient
description:  このステップでは、Vonageサーバーに対して認証を行います。

---

`NXMClient`
===========

チャットを開始する前に、クライアントSDKはVonageサーバーに対して認証する必要があります。`ViewController.swift`には、次の追加が必要です。

ファイルの先頭で、`NexmoClient`をインポートします：

```swift
import UIKit
import NexmoClient
```

`statusLabel`の下に、`NXMClient`インスタンスを追加します：

```swift
class ViewController: UIViewController {
    ...
    let statusLabel = UILabel()

    let client = NXMClient.shared
    ...
}
```

`client`の下に、`user`プロパティを追加します：

```swift
class ViewController: UIViewController {
    ...
    
    var user: User? {
        didSet {
            login()
        }
    }
}
```

ボタンターゲット
--------

ログインボタンが機能するためには、タップしたときに関数を実行するターゲットを追加する必要があります。`ViewController.swift`ファイルに追加します：

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

次に、2つの関数を`viewDidLoad`関数の末尾にあるそれぞれのボタンにリンクします：

```swift
override func viewDidLoad() {
    ...

    loginAliceButton.addTarget(self, action: #selector(setUserAsAlice), for: .touchUpInside)
    loginBobButton.addTarget(self, action: #selector(setUserAsBob), for: .touchUpInside)
}
```

ログイン関数を追加する
-----------

`ViewController.swift`の最後に、ユーザープロパティに必要な`login`関数を追加します。この関数は、クライアントのデリゲートを設定し、ユーザープロパティが新しい値に設定されたときにログインします：

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

クライアントデリゲート
-----------

デリゲートが機能するためには、`NXMClientDelegate`に準拠する`ViewController`を持つ必要があります。ファイルの末尾に、次の項目を追加します：

```swift
extension ViewController: NXMClientDelegate {
    func client(_ client: NXMClient, didChange status: NXMConnectionStatus, reason: NXMConnectionStatusReason) { 
        switch status {
        case .connected:
            setStatusLabel("Connected")
        case .disconnected:
            setStatusLabel("Disconnected")
        case .connecting:
            setStatusLabel("Connecting")
        @unknown default:
            setStatusLabel("")
        }
    }
    
    func client(_ client: NXMClient, didReceiveError error: Error) {
        setStatusLabel(error.localizedDescription)
    }
    
    func setStatusLabel(_ newStatus: String?) {
        DispatchQueue.main.async { [weak self] in
            self?.statusLabel.text = newStatus
        }
    }
}
```

発生するとエラーが表示され、`statusLabel`が関連する接続ステータスで更新されます。

ビルドして実行
-------

`Cmd + R`を押してビルドし、もう一度実行します。ログインボタンのいずれかをタップすると、それぞれのユーザーでクライアントにログインします：

![インターフェースが接続されました](/images/client-sdk/ios-messaging/client.png)

