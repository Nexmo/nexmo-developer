---
title:  イベントのタイミングを変更する
description: 各検証イベントのタイミングを変更する方法。
navigation_weight:  2

---


イベントのタイミングの変更
=============

[デフォルトのタイミング](/verify/guides/verification-events#timing-of-each-event)を変更するには、最初のリクエストで `pin_expiry` および `next_event_wait` のいずれかまたは両方のカスタム値を指定します。

* `pin_expiry`: 
  * コードの有効期限が切れるまでの時間
  * 60～3600 秒の整数値である必要があります
  * デフォルトの有効期限は[ワークフロー](/verify/guides/workflows-and-events)によって異なりますが、ほとんどの場合 300 秒です

* `next_event_wait`: 
  * Nexmo が次の検証試行をトリガーするまでの時間
  * [ワークフロー](/verify/guides/workflows-and-events)ごとにデフォルトのタイミングが異なります

`pin_expiry` と `next_event_wait` の両方に値を指定する場合、`pin_expiry` の値は `next_event_wait` の正確な倍数である必要があります。

例
---

次の表は、デフォルトのワークフロー (SMS -> TTS -> TTS) で使用した場合のいくつかの例の値と効果を示しています。

| `pin_expiry` | `next_event_wait` |効果|
|--|--|--|
|360 秒|120 秒|3 回すべての試行で同じ確認コードを使用|
|240 秒|120 秒|1 回目と 2 回目の試行で同じコードが使用され、Verify API によって 3 回目の試行用に新しいコードが生成されます。|
|120 秒 (または 90 秒または 200 秒) |120 秒|Verify API は試行の度に新しいコードを生成します|

