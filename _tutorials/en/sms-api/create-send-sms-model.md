---
title: Create Send SMS Model
description: Build the Model Data that will be used to move the data for the SMS between your frontend and Backend
---

# Create Send SMS Model

We are going to to be following the typical MVC pattern, so we'll start with the 'M' which stands for Model. In Visual Studio add a new file to the `Models` folder called `SmsModel.cs`. Insert a `using` statement for `System.ComponentModel.DataAnnotations` at the top of this file and add the following code to it:

```csharp
[Required(ErrorMessage = "To Number Required", AllowEmptyStrings = false)]
[Phone]
[Display(Name = "To Number")]
public string To { get; set; }

[Required(ErrorMessage = "From Number Required", AllowEmptyStrings = false)]
[Phone]
[Display(Name = "From Number")]
public string From { get; set; }

[Required(ErrorMessage = "Message Text Required", AllowEmptyStrings = false)]
[Display(Name = "Message Text")]
public string Text { get; set; }
}
```