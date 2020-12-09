---
title:  ログインインタフェースの構築
description:  このステップでは、アプリの最初の画面を作成します。

---

ログインインタフェースの構築
==============

ログインできるようにするには、画面に3つの要素を追加する必要があります：

* Aliceにログインするための`UIButton`
* Bobにログインするための`UIButton`
* 接続ステータスを示すための`UILabel`

プログラムで`ViewController.swift`を開いて追加します：

```swift
class ViewController: UIViewController {

    let loginAliceButton = UIButton(type: .system)
    let loginBobButton = UIButton(type: .system)
    let statusLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loginAliceButton.setTitle("Log in as Alice", for: .normal)
        loginAliceButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginAliceButton)
        
        loginBobButton.setTitle("Log in as Bob", for: .normal)
        loginBobButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginBobButton)
        
        statusLabel.text = ""
        statusLabel.textAlignment = .center
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(statusLabel)
        
        NSLayoutConstraint.activate([
            loginAliceButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginAliceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginAliceButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginAliceButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            loginBobButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginBobButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginBobButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginBobButton.topAnchor.constraint(equalTo: loginAliceButton.bottomAnchor, constant: 20),
            
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            statusLabel.topAnchor.constraint(equalTo: loginBobButton.bottomAnchor, constant: 20)
        ])
    }
}
```

ビルドして実行
-------

プロジェクトをもう一度実行して（`Cmd + R`）、シミュレータで起動します。

![インタフェース](/images/client-sdk/ios-messaging/login.png)

