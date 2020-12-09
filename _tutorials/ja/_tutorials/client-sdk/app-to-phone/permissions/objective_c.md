---
title:  プロジェクトの権限
description:  このステップでは、必要な許可をプロジェクトプロパティに追加します。

---

プロジェクトの許可
=========

電話をかけるときにマイクを使用するので、マイクを使用する許可を要求する必要があります。

`Info.plist`
------------

すべてのXcodeプロジェクトには、各アプリまたはバンドルに必要なすべてのメタデータを含む`Info.plist`ファイルが含まれています - ファイルは`AppToPhone`グループ内に見つかります。

`Info.plist`ファイルには新しいエントリが必要です。

1. リストの最後のエントリの上にマウスを置き、表示される小さな`+`ボタンをクリックします。

2. ドロップダウンリストから、`Privacy - Microphone Usage Description`を選択して`Microphone access required in order to make and receive audio calls.`をその値として追加します。

あなたの`Info.plist`は次のようになります：

![Info.plist](/images/client-sdk/ios-voice/Xcode-permissions.jpg)

アプリケーションの起動時に許可を要求する
--------------------

`AppDelegate.h`を開き、`UIKit`が含まれている場所の直後に`AVFoundation`ライブラリをインポートします。

```objective_c
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
```

次に、`AppDelegate.m`内の`application:didFinishLaunchingWithOptions:`内で`requestRecordPermission:`を呼び出します：

```objective_c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [AVAudioSession.sharedInstance requestRecordPermission:^(BOOL granted) {
        NSLog(@"Allow microphone use. Response: %d", granted);
    }];
    return YES;
}
```

ビルドして実行
-------

トップメニューから`Product` > `Run` を選択するか、`Cmd + R`を押して、シミュレータで起動することで、プロジェクトをビルドして実行することができます。

マイクを使用する許可を求めるプロンプトに注意してください。

![シミュレータマイクの許可を求める](/images/client-sdk/ios-voice/Simulator-microphone-permission-ask.jpg)

