---
title:  基本アプリケーションの作成
description:  GitHubから基本的なWebアプリケーションをダウンロードします

---

基本的なアプリケーションを作成する
=================

このステップでは、このチュートリアルの開始点として使用するコードをインストールします。

アプリケーションは、Kittens and Coと呼ばれる架空のソーシャルネットワークサイトです。現在、ユーザー名とパスワードで登録できますが、2要素認証（2FA）をサポートするように改良し、セキュリティを強化します。

まず、次のコマンドを実行してRubyと`bundler`がインストールされていることを確認します：

```sh
ruby --version
bundler --version
```

次に、GitHubリポジトリからチュートリアルアプリケーションを複製し、ローカルで実行します：

```sh
git clone https://github.com/nexmo-community/nexmo-rails-devise-2fa-demo.git
cd nexmo-rails-devise-2fa-demo
bundle install
rake db:migrate RAILS_ENV=development
rails server
```

この時点でアプリを起動し、ユーザー名とパスワードでアカウントを登録して、ログインおよびログアウトすることができます。アプリケーションは[Devise](https://github.com/heartcombo/devise)を使用して登録とログインを実装しますが、このチュートリアルのほとんどは、他の認証方法を使用するアプリケーションと同様に適用されます。さらに、アプリケーションはスタイリング用に`bootstrap-sass`、および`devise-bootstrap-templates` gemを使用します。

次のステップでは、2要素認証を登録およびログインプロセスに追加します。

このチュートリアルを完了するために必要なコードはすべて`basic-login`ブランチにあります。完成したコードは`two-factor`ブランチにあります。

続行する前に、`basic-login`ブランチにいることを確認してください。次を実行すると、現在のブランチを`git`に表示できます：

```sh
git rev-parse --abbrev-ref HEAD
```

必要に応じて次を実行して、ブランチを切り替えます：

```sh
git checkout basic-login
```

