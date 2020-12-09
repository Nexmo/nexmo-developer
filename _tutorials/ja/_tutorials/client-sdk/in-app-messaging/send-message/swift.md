---
title:  メッセージを送信する
description:  このステップでは、メッセージの送信機能を構築します。

---

メッセージを送信する
==========

会話とイベントについて学習した前のステップでは、メッセージを送信すると新しいイベントが作成され、会話経由で送信されます。

メッセージを送信するには、次の関数を`ChatViewController.swift`に追加します：

```swift
class ChatViewController: UIViewController {
    ...
    func send(message: String) {
        inputField.isEnabled = false
        conversation?.sendText(message, completionHandler: { [weak self] (error) in
            DispatchQueue.main.async { [weak self] in
                self?.inputField.isEnabled = true
            }
        })
    }
}
```

`inputField`からテキストを取得するには、`UITextFieldDelegate`によって提供される別の関数を追加する必要があります。`UITextFieldDelegate`拡張機能に次の関数を追加します：

```swift
extension ChatViewController: UITextFieldDelegate {
    ...
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            send(message: text)
        }
        textField.text = ""
        textField.resignFirstResponder()
        return true
    }
}
```

このデリゲート関数は、キーボードのリターンボタンが押されたときに呼び出されます。

ビルドして実行
-------

`Cmd + R` ビルドし、もう一度実行します。これでチャットアプリが機能しました！同時にチャットするには、2つの異なるシミュレータ/デバイスでアプリを実行できます：

![送信済みメッセージ](/images/client-sdk/ios-messaging/messages.png)

