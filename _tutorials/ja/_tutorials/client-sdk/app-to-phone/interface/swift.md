---
title:  インターフェースの構築
description:  このステップでは、アプリの画面のみを構築します。

---

インターフェースの構築
===========

通話を発信できるようにするには、画面に2つの要素を追加する必要があります：

* 接続ステータスを示すための`UILabel`
* 通話を開始および終了する`UIButton`

プログラムで`ViewController.swift`を開いて、これら2つを追加します：

```swift
class ViewController: UIViewController {

    var connectionStatusLabel = UILabel()
    var callButton = UIButton(type: .roundedRect)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        connectionStatusLabel.text = "Unknown"
        connectionStatusLabel.textAlignment = .center
        connectionStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(connectionStatusLabel)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[label]-20-|", 
          options: [], metrics: nil, views: ["label" : connectionStatusLabel]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-40-[label(20)]", 
          options: [], metrics: nil, views: ["label" : connectionStatusLabel]))
        
        callButton.setTitle("Call", for: .normal)
        callButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(callButton)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[button]-20-|", 
          options: [], metrics: nil, views: ["button": callButton]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[label]-40-[button(40)]", 
          options: [], metrics: nil, views: ["label" : connectionStatusLabel, "button": callButton]))
        callButton.alpha = 0
        callButton.addTarget(self, action: #selector(callButtonPressed(_:)), for: .touchUpInside)
    }

    @IBAction func callButtonPressed(_ sender: Any) {
         
    }

}
```

`callButton`は非表示になり、その`alpha`が0に設定され、接続が確立されたときに表示されます。

また、`callButton`がタップされたときのターゲットが追加され、通話の発信と終了に使用されます。

ビルドして実行
-------

プロジェクトをもう一度実行して（`Cmd + R`）、シミュレータで起動します。

![インターフェース](/images/client-sdk/ios-voice/interface.jpg)

