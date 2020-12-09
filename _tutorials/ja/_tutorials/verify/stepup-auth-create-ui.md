---
title:  UIを作成する
description:  アプリのユーザーインターフェースを作成します

---

UIを作成する
=======

アプリケーションは[`pug`テンプレートエンジン](https://pugjs.org/)を使用して、ページをHTMLとしてレンダリングします。

アプリケーションディレクトリ内の`views`という名前のフォルダに、次のテンプレートを作成します：

`layout.pug`

    doctype html
    html
        head
            block head 
                meta(charset='utf-8')
                title Step-up Authentication Example
                link(rel='stylesheet', type='text/css', href='/css/style.css')
                link(href='https://fonts.googleapis.com/css?family=Open+Sans:300', rel='stylesheet', type='text/css')
        body
            block content
                .container

`index.pug`

    extends layout.pug
    
    block content
        h1 #{brand} Account Management!
        if number
            p You have verified your identity using the phone number #{number} and are now permitted to make changes to your account.
            a(href="cancel")
                button.ghost-button(type="button") Cancel
        else
            p Please verify your account to make changes to your settings.
            a(href="authenticate")
                button.ghost-button(type="button") Verify me

`authenticate.pug`

    extends layout.pug
    
    block content
        h1 Account Verification: Step 1
        fieldset
            form(action='/verify', method='post')
                input.ghost-input(name='number', type='text', placeholder='Enter your mobile number', required='')
                input.ghost-button(type='submit', value='Get Verification Code')

`entercode.pug`

    extends layout.pug
    
    block content
        h1 Account Verification: Step 2
        fieldset
            form(action='/check-code', method='post')
                input.ghost-input(name='code', type='text', placeholder='Enter your verification code', required='')
                input.ghost-button(type='submit', value='Verify me!')

最後に、次のスタイルシートを含む`public/css`ディレクトリに`style.css`というファイルを作成します：

```css
body {
    width: 800px;
    margin: 0 auto;
    font-family: 'Open Sans', sans-serif;
  }
  .container {
    width: 600px;
    margin: 0 auto;
  }
  fieldset {
    display: block;
    -webkit-margin-start: 0px;
    -webkit-margin-end: 0px;
    -webkit-padding-before: 0em;
    -webkit-padding-start: 0em;
    -webkit-padding-end: 0em;
    -webkit-padding-after: 0em;
    border: 0px;
    border-image-source: initial;
    border-image-slice: initial;
    border-image-width: initial;
    border-image-outset: initial;
    border-image-repeat: initial;
    min-width: -webkit-min-content;
    padding: 30px;
  }
  .ghost-input, p {
    display: block;
    font-weight:300;
    width: 100%;
    font-size: 25px;
    border:0px;
    outline: none;
    width: 100%;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
    color: #4b545f;
    background: #fff;
    font-family: Open Sans,Verdana;
    padding: 10px 15px;
    margin: 30px 0px;
    -webkit-transition: all 0.1s ease-in-out;
    -moz-transition: all 0.1s ease-in-out;
    -ms-transition: all 0.1s ease-in-out;
    -o-transition: all 0.1s ease-in-out;
    transition: all 0.1s ease-in-out;
  }
  .ghost-input:focus {
    border-bottom:1px solid #ddd;
  }
  .ghost-button {
      font-size: 15px;
      color: white;
    background-color: blue;
    border:2px solid #ddd;
    padding:10px 30px;
    width: 100%;
    min-width: 350px;
    -webkit-transition: all 0.1s ease-in-out;
    -moz-transition: all 0.1s ease-in-out;
    -ms-transition: all 0.1s ease-in-out;
    -o-transition: all 0.1s ease-in-out;
    transition: all 0.1s ease-in-out;
  }
  .ghost-button:hover {
    border:2px solid #515151;
  }
  p {
    color: #E64A19;
  }
```

