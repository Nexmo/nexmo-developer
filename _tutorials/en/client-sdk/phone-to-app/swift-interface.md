---
title: Building the interface
description: In this step you will build the only screen of the app.
---

# Building the interface

To be able view the connection status of the app you will need to add a `UILabel` element to the screen.

Open `ViewController.swift` and add it programmatically:

```swift
class ViewController: UIViewController {

    var connectionStatusLabel = UILabel()
    
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

## Build and Run

Run the project again (`Cmd + R`) to launch it in the simulator. 

![Interface](/meta/client-sdk/ios-phone-to-app/interface.png)
