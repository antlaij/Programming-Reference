# Git command
## Table of Contents
1. [configuration](#configuration)
    1. [list config](#list-config)
    1. [set default push to current](#set-default-push-to-current)
    1. [get remote url](#get-remote-url)
1. [Git Status](#Git-Status)
    1. [show current branch status](#show-current-branch-status)
    1. [compare branch to remote](#compare-branch-to-remote)
1. [Branch](#Branch)
    1. [List all branch](#List-all-branch)
    1. [List remote branch](#List-remote-branch)
    1. [List local branch](#List-local-branch)
    1. [Delete local branch](#Delete-local-branch)
    1. [Delete remote branch](#Delete-remote-branch)
    1. [push the deleted branch to the server](#push-the-deleted-branch-to-the-server)
    1. [Remame current Branch](#Remame-current-Branch)
    1. [List Branches on a given commit](#List-Branches-on-a-given-commit)
    1. [Create and switch to a new branch](#Create-and-switch-to-a-new-branch)
    1. [switch to a new branch](#switch-to-a-new-branch)
    1. [Create a new branch and tracking develop branch](#Create-a-new-branch-and-tracking-develop-branch)
    1. [Create a new remote branch on push --set-upstream](#Create-a-new-remote-branch-on-push---set-upstream)
1. [Commit Changes](#Commit-Changes)
    1. [Discarding All Local Changes](#Discarding-All-Local-Changes)
        1. [For All Chnaged files](#For-All-Chnaged-files)
        1. [For one Chnaged files](#For-one-Chnaged-files)
        1. [For New files only](#For-New-files-only)
    1. [Delete/undo last commit](#Delete/undo-last-commit)
        1. [If you have committed junk but not pushed,](#If-you-have-committed-junk-but-not-pushed,)
    1. [Now if you already pushed and someone pulled which is usually my case, you can't use git reset.](#Now-if-you-already-pushed-and-someone-pulled-which-is-usually-my-case,-you-can't-use-git-reset.)
        1. [You can however do a git revert,](#You-can-however-do-a-git-revert,)
    1. [push changes to the master:updates](#push-changes-to-the-master:updates)
    1. [Run from Server](#Run-from-Server)
    1. [sych files to the remote location](#sych-files-to-the-remote-location)
    1. [add, delete whole working tree](#add,-delete-whole-working-tree)
    1. [Remove file from repository](#Remove-file-from-repository)
    1. [Remove a directory from repository:](#Remove-a-directory-from-repository:)
    1. [set remote url](#set-remote-url)
    1. [add new remote repo](#add-new-remote-repo)
    1. [firstly setup the remote repository:](#firstly-setup-the-remote-repository:)
    1. [setup remote machine:](#setup-remote-machine:)
    1. [On local machine:](#On-local-machine:)
    1. [On other local machine:](#On-other-local-machine:)
    1. [Clone from remote:](#Clone-from-remote:)
    1. [Force Git to overwrite local files on pull](#Force-Git-to-overwrite-local-files-on-pull)
1. [SSH](#SSH)
    1. [Generat ssh key (from git bash):](#Generat-ssh-key-(from-git-bash):)
    1. [start the ssh-agent](#start-the-ssh-agent)
1. [Git Log](#Git-Log)
    1. [Show log by date with color](#Show-log-by-date-with-color)
    1. [For MAC](#For-MAC)
    1. [Show graph in log](#Show-graph-in-log)
    1. [git log for change.md](#git-log-for-change.md)
        1. [Color options](#Color-options)
    1. [Search commited code](#Search-commited-code)
    1. [git compare branch](#git-compare-branch)
    1. [git merge (development) to master](#git-merge-(development)-to-master)
    1. [git merge pulloutbar to internetcalculator](#git-merge-pulloutbar-to-internetcalculator)
    1. [git rebase](#git-rebase)
    1. [switch back to development](#switch-back-to-development)
1. [Tagging](#Tagging)
    1. [Create Tag for Module](#Create-Tag-for-Module)
    1. [Removing a Tag](#Removing-a-Tag)
    1. [Git global setup:](#Git-global-setup:)
    1. [Create new Repository](#Create-new-Repository)
    1. [Existing Git Repo?](#Existing-Git-Repo?)
    1. [Work on your fork](#Work-on-your-fork)
    1. [for long filename](#for-long-filename)
    1. [Git config file](#Git-config-file)
1. [Migrate Git Repository](#Migrate-Git-Repository)
    1. [Move old repo to new repo with history](#Move-old-repo-to-new-repo-with-history)
    1. [Move old repo to new repo with history](#Move-old-repo-to-new-repo-with-history)
    1. [How to Migrate Git Repository with Branches and Commit History](#How-to-Migrate-Git-Repository-with-Branches-and-Commit-History)
    1. [Remove history](#Remove-history)
1. [Error:](#Error:)
    1. [Filename too long](#Filename-too-long)

***

## configuration
### list config
```bash
git config --list
```

### set default push to current
```bash
git config --global push.default current
```

### get remote url
```bash
git config --get remote.origin.url
```

## Git Status

### show current branch status
```bash
git status
```

### compare branch to remote
```bash
git remote show origin
```

***

## Branch

### List all branch

```bash
git branch --all
git branch -a
```

### List remote branch

```bash
git branch --remotes
```

### List local branch

```bash
git branch --local
git branch -l
```

### Delete local branch

```bash
git branch -d my-rogers-al
```

or

```bash
git branch -D my-rogers-al
```

### Delete remote branch

```bash
git push origin --delete [branchName]
```

### push the deleted branch to the server

```bash
git push origin --delete MYR-1939-Go-Paperless-button-on-French-is-not-in-right-format-once-you-click-on-Learn-More-button

git branch -dr origin/MYR-1694-Go-Paperless-in-English-and-French-are-not-Sentence-Case
Deleted remote branch origin/MYR-1694-Go-Paperless-in-English-and-French-are-not
-Sentence-Case (was 10f3e02).
```

### Remame current Branch
```bash
git branch -m <newName>
```

***

### List Branches on a given commit

```bash
git branch --contains fe1991496e0975901dc628c7fee60fe2795deaa4
```
### Create and switch to a new branch
```bash
git checkout -b newBranchName
```

### switch to a new branch

```bash
git checkout pulloutbar
```

### Create a new branch and tracking develop branch

```bash
git checkout -b new-branch-name --track origin/develop
```

---
### Create a new remote branch on push --set-upstream
```bash
git push -u origin localBranch:remoteBranchToBeCreated
```

---

## File Information
### List all files in repository
Script can save in a file<list_all_files.sh> and execute
```sh
echo "Tracked files:"
git ls-files

echo "Untracked files:"
git ls-files --others --exclude-standard

echo "Ignored files:"
git ls-files --others --ignored --exclude-standard
```

---

## Stage Changes
### Undo Staged Changes on a file
```bash
git reset -q HEAD -- targetFilename.txt
```

## Commit Changes

### Discarding All Local Changes
#### For All Chnaged files
```bash
git restore .
```
#### For one Chnaged files
```bash
git restore index.html
```
#### For New files only
```bash
git clean -f
```

---

### Delete/undo last commit
#### If you have committed junk but not pushed,

```bash
git reset --soft HEAD~1

git show -s --format=%H
%B HEAD
git reset HEAD~
```

#### Now if you already pushed and someone pulled which is usually my case, you can't use git reset.
You can however do a git revert,
```bash
git revert HEAD
```

### push changes to the master:updates

```bash
git push -u origin master:updates
```

### Run from Server

```bash
git merge updates
```

### sych files to the remote location
```bash
cd /e/Temp/VC/Batch
git status
git add --all
git commit -m "synchronize files"
git push -u remote master:updates
cd /g/VC/Batch
git merge updates
git status
cd /e/Temp/VC/Batch
git status
```

### add, delete whole working tree
```bash
git add -u :/
```

### Remove file from repository
```bash
git rm --cached mylogfile.log
```


### Remove a directory from repository:
```bash
git rm --cached -r mydirectory
```

### set remote url

```bash
git remote set-url origin Y:\Development\SourceControl\Git\SH_VS2013
```

### add new remote repo
```bash
git remote add origin Y:\Development\SourceControl\Git\vs.net_2013
```

### firstly setup the remote repository:

```bash
ssh git@example.com
cd Y:\Development\SourceControl\Git\web
y:
mkdir angular-karma.git
cd angular-karma.git
git init --bare
git update-server-info # If planning to serve via HTTP
```

### setup remote machine:

```bash
md Y:\Development\SourceControl\Git\web\local.git
cd Y:\Development\SourceControl\Git\web\local.git
y:
git init --bare
```

### On local machine:

```bash
cd D:\PIM\Me\Software_Development\command-line
d:
git init
git add *
git commit -m "initial commit"
git remote add origin Y:\Development\SourceControl\Git\web\local.git
git remote add origin git@example.com:my_project.git
md Y:\Development\SourceControl\Git\command-line.git
cd Y:\Development\SourceControl\Git\web\laianthony.com_ag2.git
git init --bare
git push -u origin master
```

### On other local machine:

```bash
cd D:\PIM\Me\Software_Development\WEB
d:
git clone Y:\Development\SourceControl\Git\local.git
git clone Y:\Development\SourceControl\Git\local.git
```

### Clone from remote:

```bash
git clone Y:\Development\SourceControl\Git\web\local.git
git clone Y:\Development\SourceControl\Git\web\local.git folderName
```


### Force Git to overwrite local files on pull

```bash
git fetch --all
git reset --hard
git reset --hard HEAD
git reset --hard origin/my-rogers-al
```

## SSH

### Generat ssh key (from git bash):

1.
<pre>
$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/c/Users/Anthony/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /c/Users/Anthony/.ssh/id_rsa.
Your public key has been saved in /c/Users/Anthony/.ssh/id_rsa.pub.
The key fingerprint is:
36:01:f8:5c:58:04:39:ac:2b:36:17:0d:2b:69:c7:00 Anthony@MLIVE-LP934
The key's randomart image is:
+--[ RSA 2048]----+
|E.   oo*o        |
|  . o =..        |
|   + B o.        |
|  + * +  .       |
| . o o  S        |
|  + o  . .       |
| . +             |
|                 |
|                 |
+-----------------+
</pre>

2. Copy-paste the key to the 'My SSH Keys' section under the 'SSH' tab in your user profile. Please copy the complete key starting with ssh- and ending with your username and host.

> 3. Add or set ssh url
>> - Add - git remote add origin git@mydomain.com:apollo/apollo.git
>> - set - git remote set-url origin git@mydomain.com:apollo/apollo.git

> 4. Goto your user directory (/c/Users/Anthony/)
> 5. create a file call ".bashrc"
> 6. save the following text to it


SSH_ENV=$HOME/.ssh/environment

### start the ssh-agent

```bash
function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > ${SSH_ENV}
    echo succeeded
    chmod 600 ${SSH_ENV}
    . ${SSH_ENV} > /dev/null
    /usr/bin/ssh-add
}

if [ -f "${SSH_ENV}" ]; then
     . ${SSH_ENV} > /dev/null
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi
```

7. Close GitBash then Reopen GitBash
[Working with SSH key passphrases](https://help.github.com/articles/working-with-ssh-key-passphrases/)

if you got this message:
Updates were rejected because the tip of your current branch is behind

try to use this command

## Git Log
### Show log by date with color
```bash
git push -f origin internetcalculator

git log --author="Jonathan Speevak" --since="2013-01-30" --pretty -- test
git log --author="<Developer Full Name>" --since="2013-01-30" --pretty -- test
git log --since="2013-01-30" --pretty -- test

git log --author="<Developer Full Name>" --since="2016-05-30" --pretty=format:"%ce %an - %s"
git log --author="<Developer Full Name>" --since="2016-05-30" --pretty=format:"[%ci] %an ( %ce ) - %s"
git log --author="<Developer Full Name>" --since="2016-05-30" --pretty=format:"[ %cD ] %an - %s %N %n"
git log --author="<Developer Full Name>" --since="2016-09-01" --pretty=format:"[ %cD ] %an%n - %s %N %n"

git log --author="<Developer Full Name>" --since="2015-06-27" --pretty=format:"- [[%h](http://mydomain.com/ute-client-modules/ute-janrain-verification-service/commit/%H)] - **%s** (%aN)%n%n" > /c/temp/git.log
git log --since="2016-06-01" --pretty=format:"- [[%h](http://mydomain.com/ute-client-modules/ute-rogers-setpassword/commit/%H)] - **%s** (%aN)%n%n" > /c/temp/git.log
git log --since="2016-06-01" --pretty=format:"- [[%h](http://mydomain.com/ute-client-modules/ute-janrain-verification-service/commit/%H)] - **%s** (%aN)%n%n" > /c/temp/git.log
git log --since="2016-06-01" --pretty=format:"- [[%h](http://mydomain.com/ute-client-modules/ute-common-label/commit/%H)] - **%s** (%aN)%n%n" > /c/temp/git.log

git log --since="2016-06-01" --pretty=format:"%cD%n- [[%h](http://mydomain.com/ute-client-modules/ute-profile-edit-username-and-password/commit/%H)] - **%s** (%aN)%n%n" > /c/temp/git.log
git log --since="2016-08-01" --pretty=format:"%cD%n- [[%h](http://mydomain.com/ute-client-modules/xxxxx/commit/%H)] - **%s** (%aN)%n%n" > /c/temp/git.log
```

### For MAC

```bash
git log --since="2016-08-01" --pretty=format:"%cD%n- [[%h](http://mydomain.com/ute-client-modules/xxxxx/commit/%H)] - **%s** (%aN)%n%n" > ~/ls/temp/git.log
git log --since="2016-08-01" --pretty=format:"%cD%n- [[%h](http://mydomain.com/ute-client-modules/${PWD##*/}/commit/%H)] - **%s** (%aN)%n%n" > ~/ls/temp/git.log

git log --since="2017-03-19" --author="Jonathan Speevak"
```

### Show graph in log
```bash
git log --all --decorate --oneline --graph
```

### git log for change.md
#### Color options
normal, black, red, green, yellow, blue, magenta, cyan, white
```bash
git log --author="<Developer Full Name>" --since="2016-06-28 00:00:00" --pretty=format:"- [ %ci ] %s %N"
git log --since="2019-08-20 00:00:00" --pretty=format:"* %Cgreen[ %ci ]%Creset **core** - %s %N ([%h](https://github.com/%H)) by %C(yellow)( %an )" | grep -v  -e "Merge pull request" -e "Merge branch"
```

### Search commited code
```bash
git log -S '/forgotPassword' --source --all
git log -S 'securityToken' --source --all

git log --all -S"if(!result || !result.statusCode"
git grep "if(!result || !result.statusCode" $(git rev-list --all)
```

### git compare branch

```bash
git branch
git diff internetcalculator..master
git diff internetcalculator..april8Production
```

### git merge (development) to master

```bash
git pull origin development
git push origin development
git checkout master
git pull origin master
git merge development
git push origin master

git merge --abort
```

### git merge pulloutbar to internetcalculator

```bash
git checkout pulloutbar
git pull origin pulloutbar
git checkout internetcalculator
git pull origin internetcalculator
git merge pulloutbar
git push origin internetcalculator
```

### git rebase

```bash
git checkout internetcalculator
git push origin internetcalculator
git checkout master
git pull origin master

git checkout internetcalculator
git pull origin internetcalculator

git rebase master
git push origin internetcalculator
```

### switch back to development

```bash
git checkout development
git status

git pull origin development
git push origin development
```
## Tagging

### Create Tag for Module

```bash
rimraf bower_components/
bower cache clean
bower install
gulp clean
gulp build
git tag
git tag -a 0.0.1 -m "Release 0.0.1"
git tag
git push  origin --tags
```

### Removing a Tag
```bash
git tag -d removetag
git push origin :refs/tags/removetag
```

### Git global setup:

```bash
git config --global init.defaultBranch main
git config --global user.name "<Developer Full Name>"
git config --global user.email "anthony.lai@mobilelive.ca"
```

### Create new Repository

```bash
mkdir ute-reset-voicemail-password
cd ute-reset-voicemail-password
git init
touch README
git add README
git commit -m 'first commit'
git remote add origin git@mydomain.com:ute-client-modules/ute-reset-voicemail-password.git
git push -u origin master
```



### Existing Git Repo?

```bash
cd existing_git_repo
git remote add origin git@mydomain.com:ute-client-modules/ute-reset-voicemail-password.git
git push -u origin master
```





### Work on your fork

```bash
git branch -r

git remote -v
origin  git@mydomain.com:ute-client-modules/search-typeahead.git (fetch)
origin  git@mydomain.com:ute-client-modules/search-typeahead.git (push)

git remote remove origin
git remote add origin git@mydomain.com:anthony.lai/ute-common-search-bar.git
git remote add origin git@mydomain.com:ute-client-modules/search-typeahead.git
git remote add upstream git@mydomain.com:ute-client-modules/search-typeahead.git


git remote add origin git@mydomain.com:anthony.lai/foundation-search-and-support.git
git remote add upstream git@mydomain.com:ute-rogers/foundation-search-and-support.git
```



### for long filename

```bash
git config --system core.longpaths true

// Repository setup

cd D:\CIM\Rogers
d:
git init
git remote add origin http://1.1.1.1.80:7999/Rogers.git
touch .gitignore
// For Windows use: echo.> .gitignore
git add -A -- .
git commit -m "initial commit"
git push -u origin master
```

### Git config file

```bash
[http]
[gui]
    recentrepo = c:/pim/me
[user]
    email = anthony.lai@laianthony.com
    name = Lai, Anthony
[color "branch"]
    current = green
    local = normal
    remote = yellow
    plain = normal
[color "status"]
    added = green
    changed = red bold
    untracked = magenta bold
```

## Migrate Git Repository

### Move old repo to new repo with history
```bash
git clone --mirror url_to_git_repo or
git clone <repo you want to mirror> cd <to the new cloned folder>
git remote -V
git remote set-url origin <new repo url>
git checkout master
git pull origin master --allow-unrelated-histories
REM [resolve merge conflict]
REM [commit the new code and push]
git push-u origin --all
```

### Move old repo to new repo with history
Ref: [git-move-repository]( https://www.atlassian.com/git/tutorials/git-move-repository)
```bash
REM-------   Clone Existing Repository
git clone <url to ORI repo> temp-dir
git branch -a 
git checkout develop 
git fetch ---tags 
git tag 
git branch -a 
git remote -V 
git remote rm origin
git remote -V
REM ------------- Remove unused branch
git branch 
git branch -d master
REM ------------- Point git to-new Repository
git remote add origin <url to NEW repo>
git push origin --all
git push--tags
REM ------------- Merge with existing branch 
git pull origin

git pull origin branchname --allow-unrelated-histories

```


### How to Migrate Git Repository with Branches and Commit History
Ref: [How to Migrate Git Repository with Branches and Commit History](https://blog.datanextsolutions.com/how-to-migrate-git-repository-with-branches-and-commit-history-dd129fd36dca)
```bash
git clone --mirror <url-to-source-repo>
cd to-your-git-repo-folder.git   
git remote set-url --push origin <url-of-the-destination-git-repo>
git push --mirror
```



### Remove history
Ref: [Deleting your git commit history without removing repo on Github/Bitbucket](https://www.willandskill.se/en/articles/deleting-your-git-commit-history-without-removing-repo-on-github-bitbucket)
```bash
cd myrepo
rm -rf .git

$ git init
$ git add .
$ git commit -m "Remove history"

$ git remote add origin github.com:me/my.git
$ git push -u --force origin main
```

## Error:
---
### Filename too long
Error Message: error: unable to create file src/123.ts: Filename too long
```bash
git config --system core.longpaths true
git config core.longpaths true
```




