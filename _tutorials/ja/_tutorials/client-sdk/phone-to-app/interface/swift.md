---
title:  インタフェースの構築
description:  このステップでは、アプリの画面のみを構築します。

---

インタフェースの構築
==========

アプリの接続状態を表示できるようにするには、画面に`UILabel`要素を追加する必要があります。プログラムで`ViewController.swift`を開いて追加します。

```swift
class ViewController: UIViewController {

    let connectionStatusLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        connectionStatusLabel.text = "Unknown"
        connectionStatusLabel.textAlignment = .center
        connectionStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(connectionStatusLabel)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[label]-20-|",
                                                           options: [], metrics: nil, views: ["label" : connectionStatusLabel]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-80-[label(20)]",
                                                           options: [], metrics: nil, views: ["label" : connectionStatusLabel]))
    }
}
```

ビルドして実行
-------

プロジェクトをもう一度実行して（`Cmd + R`）、シミュレータで起動します。

![インタフェース](/meta/client-sdk/ios-phone-to-app/interface.png)

