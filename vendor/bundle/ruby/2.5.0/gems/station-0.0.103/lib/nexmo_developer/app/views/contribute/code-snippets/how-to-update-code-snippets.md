---
title: How to update code snippets
description: This topic describes a method for updating code snippets in GitHub
---

# How to update code snippets

## Introduction

Updating code snippets and testing thoroughly can catch people out. You might end up with errors while trying to build NDP, or while running it locally. Here’s the procedure the tech writing team uses, which is not the only one, but it provides a good starting point for developing your own methods.

> Remember: code snippet repos are in submodules as far as NDP is concerned. If you are not familiar with submodules it’s probably worth doing a little background reading on them first.

This technique assumes you have NDP cloned locally, and you have checked out and updated all code snippet repo modules. At some point you should have run the following:

```shell
git submodule init && git submodule update
git config --global submodule.recurse true
```

This intializes your submodules, updates them, and sets the Git global configuration.

To a certain extent the procedure you use will depend on the type of change you are making to code snippets. With experience you will see various shortcuts. For example, changes to code snippets that do not change line numbers, generally do not require code snippet configuration to be changed, which simplifies the process.

## Code snippet structure

Code snippets have several parts to them:

1. The actual code in the submodule repos (for example, https://github.com/Nexmo/nexmo-curl-code-snippets/blob/master/messages/messenger/send-text.sh)
2. The documentation pages that contain the tabbed code snippets in different programming languages (for example, https://developer.nexmo.com/messages/code-snippets/messenger/send-text)
3. The code snippet configuration (for example, `_examples/messages/messenger/send-text/curl.yml`)

Code snippets are described in more detail [here](/contribute/structure/guides/code-snippets).

## Updating code snippets

The tech writing team usually recommends coding and testing the code snippet code separately from NDP. This usually means you check out the relevant code snippet repo in a separate directory structure. This allows you to have local data such as private key, local config and so on for an app you can use for testing this repo. You can then run your test scripts locally to make sure everything works. See [Curl code snippet repo](https://github.com/Nexmo/nexmo-curl-code-snippets) for a good example of this set up.

1. Go to the code snippet repo directory and make your code changes in a branch. Test code changes locally.

2. If everything is OK, push up the branch to create a PR. Request a review. While waiting for a review you can work on the NDP side of things. Remember, as your changes have not been merged yet they will not be visible in  NDP, so if, for example, you’ve deleted a code snippet, NDP won’t be affected.

Here’s what some people do at this point - they merge their code snippet changes to master in the code snippet repo. If you deleted a code snippet or modified an existing one you just broke NDP - at least - those code snippet pages in NDP. The line number will be out, or worst case the code snippet has now gone completely. However, if you only added a code snippet you’re still good (although as yet the docs won't display it).

## Automatic NDP PR creation

If you added a new code snippet and merged it into master of the code snippet repo, an NDP PR will **automatically** be created for you at this point. This is because at the least, NDP will need to be updated to point to the latest master of the code snippet repo, not the previous commit.

You won't always use the automated PR though. If you're only updating a single snippet or not affecting the display of snippets in NDP, it's a nice shortcut. **Usually, you want to make sure that all the required changes are in place before creating a PR to point NDP at the latest version of the code snippet submodule repos.** In that case, you can delete the automatic update PRs with a note saying that you'll be pushing under a separate PR. 

If you're not ready for the Automated PR to be merged then flag it as 'Do not merge', or if you are not going to use it close with a suitable note.

## NDP side of the code snippet

Now, while waiting for a review of your code snippet code you can do the NDP part.

1. Go to the root directory of your NDP clone.
2. Checkout master branch, `git checkout master`.
3. Do a `git pull` to update.
4. Go to the sub-directory for the code snippets you’re working on. For example, `.repos/nexmo/nexmo-node-code-snippets` and `git checkout master` then `git pull`. This ensures the local code snippet repo is up to date.

At this point everything local is master and up to date. You are now ready to make your changes to NDP.

1. Create a new branch in NDP e.g. `tony-update-snips`.
2. Checkout the new branch.
3. Now you want to check out the branch with your code snippet repo changes (which are still in review). Go to `.repos/nexmo/nexmo-node-code-snippets`.
4. Checkout the branch with your code snippet changes.
5. Go back up to NDP directory and make the required changes to NDP, for example, add or update configuration for the code snippets (especially if line numbers have changed), add new stub pages and so on.
6. Now run NDP locally and check your changes display correctly
7. Do a `git status` to make sure you have only affected the desired files.
8. You can now push up your branch to create a PR (and please do fill out the PR description).
9. A review app will be built for you. Go into Heroku and check the review app displays as required. You can use your PR number to identify the correct review app.

At this point you have tested your changes (both code snippet and NDP changes) but you’re not quite finished. Hopefully, by now your code snippet repo PR has been reviewed. If everything is good at this stage you can now merge these code snippet changes into the code snippet repo.

But you still need to make one more change, and that is to align your NDP PR with the master of the code snippet repo:

1. Back in NDP you need to change down into `.repos/nexmo/nexmo-node-code-snippets` and do a `git checkout master` and git pull to pull down the latest code snippet repo changes that just got merged.
2. Running NDP locally, check that the affected code snippets display correctly. This is very important!
3. Change back up into root of NDP and do `git status` - you will see your branch has changes that will need to be pushed up, due to the fact you are referencing the master of the code snippet repo.
4. Commit with a message of something like ‘point at latest master’ and push.
5. Let the new review app build.
6. Check review app via Heroku.
7. If everything looks good in the review app you can now get your PR reviewed and merged!
8. You can now close any auto-generated NDP PR, as in this case you didn’t use it.

## Summary

There are many moving parts to code snippets with the added issue that the code is stored in submodules. The full process described above is not always required. For example, if you make a code change that does not affect the line numbering in your code snippet, then there are no changes required on the NDP side. If however, you delete a code snippet, or add a new code snippet, or the number of lines changes, then you'll need to reflect those code changes on NDP, otherwise the code snippet will not display correctly.
