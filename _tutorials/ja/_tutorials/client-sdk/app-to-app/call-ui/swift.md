---
title:  通話インターフェースの構築
description:  このステップでは、アプリの2番目の画面を作成します。

---

通話インターフェースの構築
=============

通話できるようにするには、通話インターフェース用の新しいビューコントローラーを作成する必要があります。Xcodeメニューから`File`＞`New`＞`File...`を選択します。 *[Cocoa Touch Class (Cocoaタッチクラス)]* を選択し、`UIViewController`のサブクラスと`Swift`の言語で`CallViewController`という名前を付けます。

![Xcode追加ファイル](/images/client-sdk/ios-in-app-voice/callviewcontroller.png)

これにより、インポートされた`NexmoClient`の上部に`CallViewController`という新しいファイルが作成されます。

```swift
import UIKit
import NexmoClient
```

通話インターフェースには次のものが必要です：

* 通話を開始するための`UIButton`
* 通話を終了するための`UIButton`
* ステータスの更新を表示するための`UILabel`

プログラムで`CallViewController.swift`を開いて追加します。

```swift
class CallViewController: UIViewController {
    
    let callButton = UIButton(type: .system)
    let hangUpButton = UIButton(type: .system)
    let statusLabel = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        callButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(callButton)
        
        hangUpButton.setTitle("Hang up", for: .normal)
        hangUpButton.translatesAutoresizingMaskIntoConstraints = false

        setHangUpButtonHidden(true)
        view.addSubview(hangUpButton)
        
        setStatusLabelText("Ready to receive call...")
        statusLabel.textAlignment = .center
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(statusLabel)
        
        NSLayoutConstraint.activate([
            callButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            callButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            callButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            callButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            hangUpButton.topAnchor.constraint(equalTo: callButton.bottomAnchor, constant: 20),
            hangUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hangUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            hangUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            statusLabel.topAnchor.constraint(equalTo: hangUpButton.bottomAnchor, constant: 20),
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setHangUpButtonHidden(_ isHidden: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.hangUpButton.isHidden = isHidden
            self.callButton.isHidden = !self.hangUpButton.isHidden
        }
    }
    
    private func setStatusLabelText(_ text: String?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.statusLabel.text = text
        }
    }
}
```

通話の繰り返し`DispatchQueue.main.async`を避けるために、2つのヘルパー関数`setHangUpButtonHidden`と`setStatusLabelText`があります。`UIKit`の要求に応じて、メインスレッド上でUI要素の状態を変更する必要があるためです。アクティブな通話中にだけ表示される必要があるため、この`setHangUpButtonHidden`関数が、`hangUpButton`の表示／非表示を切り替えます。

を提示する `CallViewController`
--------------------------

通話インターフェースが構築されたので、前に構築したログイン画面からビューコントローラーを提示する必要があります。ログインしたユーザーに関する情報は、2つのビューコントローラ間で渡される必要があります。`CallViewController.swift`で次の内容を追加します。

```swift
class CallViewController: UIViewController {
    ...
    let user: User
    let client = NXMClient.shared
    let nc = NotificationCenter.default
    
    var call: NXMCall?

    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
```

これは、パラメータとして`User.type`を持つクラスのカスタムイニシャライザーを定義し、ローカルの`user`プロパティに格納されます。これでユーザー情報が得られたので、`callButton`を使用してユーザーが通話する相手を表示し、`viewDidLoad`に次の内容を追加します。

```swift
navigationItem.leftBarButtonItem = 
UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(self.logout))
callButton.setTitle("Call (user.callPartnerName)", for: .normal)
if user.name == "Alice" {
    callButton.alpha = 0
}
```

これにより、Aliceの通話ボタンが非表示になります。このデモでは、BobだけがAliceに電話をかけることができるからです。本番アプリケーションでは、アプリケーションの回答URLによって返される`NCCO`は、これを避けるために正しいユーザー名を動的に返します。また、ナビゲーションバーにログアウトボタンが作成され、末尾に対応する`logout`関数が追加されます `CallViewController.swift`

```swift
class CallViewController: UIViewController {
    ...

     @objc func logout() {
        client.logout()
        dismiss(animated: true, completion: nil)
    }
```

これで、通話インターフェースをユーザー情報とともに提示する準備ができました。これを行うには、`ViewController.swift`ファイル内の`NXMClientDelegate`拡張子を編集する必要があります。

```swift
extension ViewController: NXMClientDelegate {
    func client(_ client: NXMClient, didChange status: NXMConnectionStatus, reason: NXMConnectionStatusReason) {
        guard let user = self.user else { return }

        switch status {
        case .connected:
            self.statusLabel.text = "Connected"
            let navigationController = UINavigationController(rootViewController: CallViewController(user: user))
            navigationController.modalPresentationStyle = .overFullScreen
            self.present(navigationController, animated: true, completion: nil)
        ...
        }
    }
    ...
}
```

ユーザーが正常に接続すると、必要なユーザーデータが`CallViewController`に表示されます。

ビルドして実行
-------

プロジェクトをもう一度実行して（`Cmd + R`）、シミュレータで起動します。いずれかのユーザーでログインすると、通話インターフェースが表示されます

![通話インターフェース](/images/client-sdk/ios-in-app-voice/call.png)

