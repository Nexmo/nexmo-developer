---
title:  添加语音视图
description:  添加用于拨打电话的语音视图

---

添加语音视图
======

在 `Views` 目录中，创建一个名为 `Voice` 的子目录。在 `Voice` 目录中，创建一个包含以下内容的 `index.cshtml` 文件：

将 `Index.cshtml` 的内容替换为：

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

