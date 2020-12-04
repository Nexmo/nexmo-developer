---
title:  チャットインターフェースの構築
description:  このステップでは、アプリの2番目の画面を作成します。
------------------------------------------------------------------

チャットインターフェースの構築
===============

チャットできるようにするには、チャットインターフェース用の新しいビューコントローラーを作成する必要があります。Xcodeメニューから`File`＞`New`＞`File...`を選択します。 *Cocoa Touch Class (Cocoaタッチクラス)* を選択し、`UIViewController`のサブクラスと`Swift`の言語で`ChatViewController`という名前を付けます。

![Xcode追加ファイル](/images/client-sdk/ios-messaging/chatviewcontrollerswift.png)

これにより、インポートされた`NexmoClient`の上部に`ChatViewController`という新しいファイルが作成されます：

```swift
import UIKit
import NexmoClient
```

チャットインターフェースには次のものが必要です：

* チャットメッセージを表示する`UITextView`
* メッセージを入力する`UITextField`

プログラムで`ChatViewController.swift`を開いて追加します：

```swift
class ChatViewController: UIViewController {
    let inputField = UITextField()
    let conversationTextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        conversationTextView.text = ""
        conversationTextView.backgroundColor = .lightGray
        conversationTextView.isUserInteractionEnabled = false
        conversationTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(conversationTextView)
        
        inputField.delegate = self
        inputField.returnKeyType = .send
        inputField.layer.borderWidth = 1
        inputField.layer.borderColor = UIColor.lightGray.cgColor
        inputField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inputField)
        
        NSLayoutConstraint.activate([
            conversationTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            conversationTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            conversationTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            conversationTextView.bottomAnchor.constraint(equalTo: inputField.topAnchor, constant: -20),
            
            inputField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            inputField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            inputField.heightAnchor.constraint(equalToConstant: 40),
            inputField.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
        ])   
    }
````
override func viewWillAppear(_ animated: Bool) {
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown),
     name: UIResponder.keyboardDidShowNotification, object: nil)
}
````
    @objc func keyboardWasShown(notification: NSNotification) {
        if let kbSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.size {
            view.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height - 20, right: 0)
        }
    }
```

`viewWillAppear`関数では、`keyboardWasShown`を呼び出すのにオブザーバが`keyboardDidShowNotification`に追加されます。`keyboardWasShown`関数は、入力フィールドを移動するビューのレイアウトマージンを調整します。これにより、入力時にキーボードによる`inputField`のブロックが停止します。

`UITextField`デリゲート
------------------

`UITextFieldDelegate`に準拠して、ユーザーが入力を完了して入力フィールドを元の位置に移動したかを知る必要があります。ファイルの末尾に、次の項目を追加します：

```swift
extension ChatViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        view.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
```

プレゼンテーション `ChatViewController`
------------------------------

チャットインターフェースが構築されたので、前に構築したログイン画面からビューコントローラーを提示する必要があります。ログインしたユーザーに関する情報は、2つのビューコントローラー間で渡される必要があり、`ChatViewController.swift`で追加します：

```swift
class ChatViewController: UIViewController {
    ...
    let client = NXMClient.shared
    let user: User
````
init(user: User) {
    self.user = user
    super.init(nibName: nil, bundle: nil)
}
````
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
```

これは、パラメータとして`User.type`を持つクラスのカスタムイニシャライザーを定義し、ローカルの`user`プロパティに格納されます。これで、ナビゲーションバーを使用してユーザーがチャットする相手のユーザー情報が表示されるので、 `viewDidLoad`で追加します：

```swift
navigationItem.leftBarButtonItem = 
UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(self.logout))
title = "Conversation with (user.chatPartnerName)"

```

これにより、ナビゲーションバーにログアウトボタンが作成され、`ChatViewController.swift`の末尾に`logout`関数が追加されます：

```swift
class ChatViewController: UIViewController {
    ...
````
 @objc func logout() {
    client.logout()
    dismiss(animated: true, completion: nil)
}
```
````
これで、チャットインターフェースをユーザー情報とともに提示する準備ができました。これを行うには、`ViewController.swift`ファイル内の`NXMClientDelegate`拡張子を編集する必要があります：

```swift
extension ViewController: NXMClientDelegate {
    func client(_ client: NXMClient, didChange status: NXMConnectionStatus, reason: NXMConnectionStatusReason) {
        guard let user = self.user else { return }
````
    switch status {
    case .connected:
        setStatusLabel("Connected")
        let navigationController = UINavigationController(rootViewController: ChatViewController(user: user))
        navigationController.modalPresentationStyle = .overFullScreen
        present(navigationController, animated: true, completion: nil)
    ...
    }
}
...
}
```
````
ユーザーが正常に接続すると、必要なユーザーデータが`ChatViewController`に表示されます。

ビルドして実行

---

プロジェクトをもう一度実行して（`Cmd + R`）、シミュレータで起動します。いずれかのユーザーでログインすると、チャットインターフェースが表示されます

![チャットインターフェース](/images/client-sdk/ios-messaging/chat.png)

