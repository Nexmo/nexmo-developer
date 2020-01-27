---
title: Swift
language: swift
menu_weight: 1
---

```swift
let image = UIImage(named: "file.png")
guard let imageData = image?.pngData() else { return }

conversation.sendAttachment(with: NXMAttachmentType.image,
                            name: "File name",
                            data: imageData,
                            completionHandler: { (error) in
    if let error = error {
        NSLog("Error sending image: \(error.localizedDescription)")
        return
    }
    NSLog("Image sent")
})
```
