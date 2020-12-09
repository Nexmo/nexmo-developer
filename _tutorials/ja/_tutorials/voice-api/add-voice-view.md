---
title:  音声ビューを追加する
description:  電話をかけるための音声ビューを追加する

---

音声ビューを追加する
==========

`Views`ディレクトリに、`Voice`というサブディレクトリを作成します。`Voice`ディレクトリで、次の内容を含む`index.cshtml`ファイルを作成します：

`Index.cshtml`の内容を次のように置き換えます：

```html
@using (Html.BeginForm("MakePhoneCall", "voice", FormMethod.Post))
{
    <div class="form-vertical">
        <h4>Call<h4>
                @Html.ValidationSummary(true, "", new { @class = "text-danger" })
                <div class="form-group">
                    @Html.Label("To")
                    <div>
                        @Html.Editor("toNumber", new { htmlAttributes = new { @class = "form-control" } })
                    </div>
                </div>

                <div class="form-group">
                    @Html.Label("From")
                    <div>
                        @Html.Editor("fromNumber", new { htmlAttributes = new { @class = "form-control" } })
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-offset-2 col-md-10">
                        <button type="submit">Send</button>
                    </div>
                </div>
    </div>
}
@if(@ViewBag.Uuid != null){
    <h2>Call UUID: @ViewBag.Uuid</h2>
}
```

