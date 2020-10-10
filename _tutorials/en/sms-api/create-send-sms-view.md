---
title: Create a Send SMS View
description: Add an MVC View to
---

# Add a Send SMS View

Create a new folder under `Views` called `Sms`. Within `Sms`, add a file called `index.cshtml` that contains the following code:

```html
@model SmsModel

@using (Html.BeginForm("sms", "sms", FormMethod.Post))
{
    <div class="form-vertical">
        <h4>
            Sms<h4>
                @Html.ValidationSummary(true, "", new { @class = "text-danger" })
                <div class="form-group">
                    @Html.LabelFor(model => model.To)
                    <div>
                        @Html.EditorFor(model => model.To, new { htmlAttributes = new { @class = "form-control" } })
                        @Html.ValidationMessageFor(model => model.To, "", new { @class = "text-danger" })
                    </div>
                </div>

                <div class="form-group">
                    @Html.LabelFor(model => model.From)
                    <div>
                        @Html.EditorFor(model => model.From, new { htmlAttributes = new { @class = "form-control" } })
                        @Html.ValidationMessageFor(model => model.From, "", new { @class = "text-danger" })
                    </div>
                </div>

                <div class="form-group">
                    @Html.LabelFor(model => model.Text)
                    <div>
                        @Html.EditorFor(model => model.Text, new { htmlAttributes = new { @class = "form-control" } })
                        @Html.ValidationMessageFor(model => model.Text, "", new { @class = "text-danger" })
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-offset-2 col-md-10">
                        <button type="submit">Send</button>
                    </div>
                </div>
    </div>
}
<h2>@ViewBag.MessageId<h2>
<h3>@ViewBag.Error</h3>
```
