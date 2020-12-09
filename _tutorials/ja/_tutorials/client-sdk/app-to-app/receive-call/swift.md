---
title:  通話を受信する
description:  このステップでは、アプリ内通話を受信する方法を学びます

---

通話を受信する
=======

呼び出しインターフェースが構築されたので、通話を受信するために必要なコードを追加できるようになりました。`NXMClientDelegate`には、着信があると呼び出される関数があります。`ViewController.swift`ファイルの`NXMClientDelegate`拡張子で、実装を追加します。

```swift
extension ViewController: NXMClientDelegate {
    ...

    func client(_ client: NXMClient, didReceive call: NXMCall) {
        nc.post(name: .call, object: call)
    }
}

extension Notification.Name {
    static var call: Notification.Name {
        return .init(rawValue: "NXMClient.incommingCall")
    }
}
```

`CallViewController`クラスはフォアグラウンドにあり、呼び出しを処理するクラスなので、呼び出しは`NSNotification`ポストを使用して渡されます。`CallViewController`がこの通知を受信するには、それを観察する必要があります。`CallViewController`に追加します。

```swift
class CallViewController: UIViewController {
    ...
    
    override func viewDidLoad() {
        ...

        nc.addObserver(self, selector: #selector(didReceiveCall), name: .call, object: nil)

        hangUpButton.addTarget(self, action: #selector(endCall), for: .touchUpInside)
    }

    ...

    @objc private func didReceiveCall(_ notification: Notification) {
        guard let call = notification.object as? NXMCall else { return }
        DispatchQueue.main.async { [weak self] in
            self?.displayIncomingCallAlert(call: call)
        }
    }
    
    private func displayIncomingCallAlert(call: NXMCall) {
        var from = "Unknown"
        if let otherParty = call.otherCallMembers.firstObject as? NXMCallMember {
            from = otherParty.user.name
        }

        let alert = UIAlertController(title: "Incoming call from", message: from, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Answer", style: .default, handler: { _ in
            call.answer { error in
                if error != nil {
                    self.setStatusLabelText(error?.localizedDescription)
                    return
                }
                call.setDelegate(self)
                self.setHangUpButtonHidden(false)
                self.setStatusLabelText("On a call with (from)")
                self.call = call
            }
        }))

        alert.addAction(UIAlertAction(title: "Reject", style: .destructive, handler: { _ in
            call.reject(nil)
        }))

        self.present(alert, animated: true, completion: nil)
    }

    @objc private func endCall() {
        call?.hangup()
        self.setHangUpButtonHidden(true)
        self.setStatusLabelText("Ready to receive call...")
    }
}
```

通知が受信されると、`didReceiveCall`が呼び出され、今度は`displayIncomingCallAlert`を呼び出し、通話を受け入れるか拒否するかをユーザーに提示します。ユーザーが承諾すると、通話中のユーザーが誰かわかるようにUIが更新され、`hangUpButton`が表示されます。`hangUpButton`をタップすると、`endCall`が呼び出され、通話を切断してUIを更新します。

通話デリゲート
-------

`NXMClient`と同様に、`NXMCall`にも、呼び出しの変更を処理するデリゲートがあります。`CallViewController.swift`ファイルの末尾に、`NXMCallDelegate`への適合を追加します。

```swift
extension CallViewController: NXMCallDelegate {
    func call(_ call: NXMCall, didUpdate callMember: NXMCallMember, with status: NXMCallMemberStatus) {
        switch status {
        case .answered:
            guard callMember.user.name != self.user.name else { return }
            setStatusLabelText("On a call with (callMember.user.name)")
        case .completed:
            setStatusLabelText("Call ended")
            setHangUpButtonHidden(true)
            self.call = nil
        default:
            break
        }
    }

    func call(_ call: NXMCall, didReceive error: Error) {
        setStatusLabelText(error.localizedDescription)
    }

    func call(_ call: NXMCall, didUpdate callMember: NXMCallMember, isMuted muted: Bool) {}
}
```

次のステップでは、通話を発信するために必要なコードを追加します。

