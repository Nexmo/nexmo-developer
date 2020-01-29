---
title: Swift
language: swift
menu_weight: 1
---


```swift
class ConversationViewController: UIViewController {

    var error: Error?
    var conversation: NXMConversation?

    override func viewDidLoad() {
        super.viewDidLoad()
        getConversation()
    }

    func getConversation() {
        NXMClient.shared.getConversationWithUuid(conversationId) { [weak self] (error, conversation) in
            self?.error = error
            self?.conversation = conversation
            conversation?.delegate = self
        }
    }

    func sendCustomEvent() {
        conversation?.sendCustom(withEvent: "my_custom_event", data: ["your": "data"], completionHandler: { (error) in
            if let error = error {
                NSLog("Error sending custom event: \(error.localizedDescription)")
                return
            }
            NSLog("Custom event sent.")
        })
    }

}

//MARK: Conversation Delegate

extension ConversationViewController: NXMConversationDelegate {
    func conversation(_ conversation: NXMConversation, didReceive error: Error) {
        NSLog("Conversation error: \(error.localizedDescription)")
    }

    func conversation(_ conversation: NXMConversation, didReceive event: NXMCustomEvent) {
        NSLog("Received custome type \(String(describing: event.customType)): \(String(describing: event.data))");
    }
}
```
