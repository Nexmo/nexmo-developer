---
title: Building the interface
description: In this step you will build the only screen of the app.
---

# Building the interface

To be able to place the call, you need to add 2 elements to the screen:

* a `UILabel` to show the connection status
* a `UIButton` to start and end calls

Open `ViewController.swift` and add these two programmatically:

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

The `callButton` has been hidden, its `alpha` is set 0, and will be shown when a connection is established.

Also, a target has been added for when `callButton` is tapped and will be used to place and end calls.

Run the project again (`Cmd + R`) to launch it in the simulator. 

Notice the prompt asking for permission to use the microphone:

![Interface](/assets/images/client-sdk/ios-voice/interface.jpg)