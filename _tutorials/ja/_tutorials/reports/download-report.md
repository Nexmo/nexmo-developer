---
title:  レポートをダウンロードする

---

レポートをダウンロードする
=============

レポートが生成されたら、メディアAPIを使用して結果をダウンロードできます。

```bash
curl -u $API_KEY:$API_SECRET -o report.zip DOWNLOAD_URL
```

`DOWNLOAD_URL`を、[レポートステータス応答](/reports/tutorials/create-and-retrieve-a-report/reports/check-report-status)の`download_report`フィールドに示されているリンクに置き換えます。

上記のコマンドを実行すると、`report.zip`という名前のファイルとして現在のフォルダにレポートがダウンロードされます。この圧縮ファイルを解凍してレポートを表示します。

