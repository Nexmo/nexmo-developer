---
title:  チャットインターフェースの構築
description:  このステップでは、アプリの2番目の画面を作成します。
------------------------------------------------------------------

チャットインターフェースの構築
===============

チャットできるようにするには、チャットインターフェース用の新しいビューコントローラーを作成する必要があります。Xcodeメニューから`File`＞`New`＞`File...`を選択します。 *Cocoa Touch Class (Cocoaタッチクラス)* を選択し、`UIViewController`のサブクラスと`Objective-C`の言語で`ChatViewController`という名前を付けます。

![Xcode追加ファイル](/images/client-sdk/ios-messaging/chatviewcontrollerobjc.png)

これにより、インポートされた`NexmoClient`と`User`の上部に`ChatViewController.m`という新しいファイルが作成されます。

```objective_c
#import "ChatViewController.h"
#import "User.h"
#import <NexmoClient/NexmoClient.h>
```

チャットインターフェースには次のものが必要です：

* チャットメッセージを表示する`UITextView`
* メッセージを入力する`UITextField`

プログラムで`ChatViewController.m`を開いて追加します。

```objective_c
@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    self.conversationTextView = [[UITextView alloc] initWithFrame:CGRectZero];
    self.conversationTextView.text = @"";
    self.conversationTextView.backgroundColor = UIColor.lightGrayColor;
    [self.conversationTextView setUserInteractionEnabled:NO];
    self.conversationTextView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.conversationTextView];
    
    self.inputField = [[UITextField alloc] initWithFrame:CGRectZero];
    self.inputField.delegate = self;
    self.inputField.returnKeyType = UIReturnKeySend;
    self.inputField.layer.borderWidth = 1.0;
    self.inputField.layer.borderColor = UIColor.lightGrayColor.CGColor;
    self.inputField.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:self.inputField];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.conversationTextView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.conversationTextView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.conversationTextView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.conversationTextView.bottomAnchor constraintEqualToAnchor:self.inputField.topAnchor constant:-20.0],
        
        [self.inputField.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20.0],
        [self.inputField.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20.0],
        [self.inputField.heightAnchor constraintEqualToConstant:40.0],
        [self.inputField.bottomAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.bottomAnchor constant:-20.0]
    ]];
}

- (void)viewWillAppear:(BOOL)animated {
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification *)notification {
    
    NSDictionary *keyboardInfo = notification.userInfo;
    
    if (keyboardInfo) {
        CGSize kbSize = [keyboardInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
        self.view.layoutMargins = UIEdgeInsetsMake(0, 0, kbSize.height - 20.0, 0);
    }
}

@end
```

`viewWillAppear`関数では、`keyboardWasShown`を呼び出すのにオブザーバが`keyboardDidShowNotification`に追加されます。`keyboardWasShown`関数は、入力フィールドを移動するビューのレイアウトマージンを調整します。これにより、入力時にキーボードによる`inputField`のブロックが停止します。

`UITextField`デリゲート
------------------

`UITextFieldDelegate`に準拠して、ユーザーが入力を完了して入力フィールドを元の位置に移動したかを知る必要があります。

```objective_c
@interface ChatViewController () <NXMClientDelegate>

...

@end
```

`ChatViewController`クラスの最後に、`textFieldDidEndEditing`デリゲート関数を追加します。

```objective_c
@implementation ChatViewController

...

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.view.layoutMargins = UIEdgeInsetsZero;
}

@end
```

プレゼンテーション `ChatViewController`
------------------------------

チャットインターフェースが構築されたので、前に構築したログイン画面からビューコントローラーを提示する必要があります。ログインしたユーザーに関する情報を2つのビューコントロール間で受け渡す必要があります。これは、`ChatViewController.h`内で、ファイルの先頭にある`User`クラスをインポートします。

```objective_c
#import <UIKit/UIKit.h>
#import "User.h"
```

インターフェースにイニシャライザーを追加します。

```objective_c
@interface ChatViewController : UIViewController

-(instancetype)initWithUser:(User *)user;

@end
```

次に`ChatViewController.m`で、ユーザーとクライアントプロパティをインターフェースに追加します。

```objective_c
@interface ChatViewController () <UITextFieldDelegate>
...
@property User *user;
@property NXMClient *client;
@end
```

イニシャライザーを実装します。

```objective_c
@implementation ChatViewController

- (instancetype)initWithUser:(User *)user {
    if (self = [super init])
    {
        _user = user;
        _client = NXMClient.shared;
    }
    return self;
}

...
@end
```

これは、パラメータとして`User.type`を持つクラスのカスタムイニシャライザーを定義し、ローカルの`user`プロパティに格納されます。これでユーザー情報が得られたので、ナビゲーションバーを使用してユーザーがチャットする相手を表示し、`viewDidLoad`に次の内容を追加します。

```objective_c
self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleDone target:self action:@selector(logout)];
self.title = [NSString stringWithFormat:@"Conversation with %@", self.user.chatPartnerName];
```

これにより、ナビゲーションバーにログアウトボタンが作成され、`ChatViewController.m`の末尾に`logout`関数が追加されます。

```objective_c
@implementation ChatViewController
    ...
- (void)logout {
    [self.client logout];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
```

これで、チャットインターフェースをユーザー情報とともに提示する準備ができました。これを行うには、`ViewController.m`ファイル内の`didChangeConnectionStatus`関数を編集する必要があります。

```objective_c
- (void)client:(NXMClient *)client didChangeConnectionStatus:(NXMConnectionStatus)status reason:(NXMConnectionStatusReason)reason {
    switch (status) {
        case NXMConnectionStatusConnected: {
            [self setStatusLabelText:@"Connected"];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[ChatViewController alloc] initWithUser:self.user]];
            navigationController.modalPresentationStyle = UIModalPresentationOverFullScreen;
            [self presentViewController:navigationController animated:YES completion:nil];
            break;
        }
        case NXMConnectionStatusConnecting:
            [self setStatusLabelText:@"Connecting"];
            break;
        case NXMConnectionStatusDisconnected:
            [self setStatusLabelText:@"Disconnected"];
            break;
    }
}
```

次に、ファイルの先頭に`ChatViewController`をインポートします。

```objective_c
...
#import "ChatViewController.h"
```

ユーザーが正常に接続すると、必要なユーザーデータが`ChatViewController`に表示されます。

ビルドして実行

---

プロジェクトをもう一度実行して（`Cmd + R`）、シミュレータで起動します。いずれかのユーザーでログインすると、チャットインターフェースが表示されます

![チャットインターフェース](/images/client-sdk/ios-messaging/chat.png)

