---
title:  创建基本应用程序
description:  从 GitHub 下载基本 Web 应用程序

---

创建基本应用程序
========

在此步骤中，您将安装用作本教程起点的代码。

该应用程序是名为 Kittens and Co 的虚拟社交网站。目前，使用它可以注册用户名和密码，但您将予以改进，以支持双因素身份验证 (2FA)，从而提高安全性。

首先，通过运行以下命令确保已安装了 Ruby 和 `bundler`：

```sh
ruby --version
bundler --version
```

然后，从其 GitHub 存储库中克隆该教程应用程序，并在本地运行：

```sh
git clone https://github.com/nexmo-community/nexmo-rails-devise-2fa-demo.git
cd nexmo-rails-devise-2fa-demo
bundle install
rake db:migrate RAILS_ENV=development
rails server
```

此时，您可以启动该应用，使用用户名和密码注册一个帐户，然后登录并注销。该应用程序使用 [Devise](https://github.com/heartcombo/devise) 实现注册和登录，但是本教程的大部分内容同样适用于使用其他身份验证方法的应用程序。此外，该应用程序还使用 `bootstrap-sass` 和 `devise-bootstrap-templates` gem 进行样式设置。

下一步是向注册和登录过程添加双因素身份验证。

完成本教程所需的所有代码都位于 `basic-login` 分支。完成的代码位于 `two-factor` 分支。

确保您位于 `basic-login` 分支，然后再继续执行其他操作。通过运行以下命令即可在 `git` 中显示当前分支：

```sh
git rev-parse --abbrev-ref HEAD
```

如有必要，通过执行以下命令来切换分支：

```sh
git checkout basic-login
```

