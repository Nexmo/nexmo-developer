---
title: Add a Voice View
description: Add a Voice view for placing phone calls
---

Under the `Views` folder add a new directory called `Voice`, under that directory add a `cshtml` file `Index.cshtml`

Replace the Contents of `Index.cshtml` with:

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