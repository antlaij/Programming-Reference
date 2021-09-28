
# list config

```bash
git config --list
```

***

# Branch

## List all branch

```bash
git branch --all
git branch -a
```

## List remote branch

```git
git branch --remotes
```

## List local branch

```git
git branch --local
git branch -l
```

## Delete local branch

```git
git branch -d my-rogers-al
```

## or

```git
git branch -D my-rogers-al
```

## Delete remote branch

```git
git push origin --delete [branchName]
```

## push the deleted branch to the server

```git
git push origin --delete MYR-1939-Go-Paperless-button-on-French-is-not-in-right-format-once-you-click-on-Learn-More-button

git branch -dr origin/MYR-1694-Go-Paperless-in-English-and-French-are-not-Sentence-Case
Deleted remote branch origin/MYR-1694-Go-Paperless-in-English-and-French-are-not
-Sentence-Case (was 10f3e02).
```

***

# List Branches on a given commit

```git
git branch --contains fe1991496e0975901dc628c7fee60fe2795deaa4
```

## set default push to current

```git
git config --global push.default current
```

---

## Discarding All Local Changes
### For All Chnaged files
```git
git restore .
```
### For one Chnaged files
```git
git restore index.html
```
### For New files only
```git
git clean -f
```

---

## Delete/undo last commit
### If you have committed junk but not pushed,

```git
git reset --soft HEAD~1

git show -s --format=%H
%B HEAD
git reset HEAD~
```

## Now if you already pushed and someone pulled which is usually my case, you can't use git reset.
### You can however do a git revert,
```git
git revert HEAD
```

## push changes to the master:updates

```git
git push -u origin master:updates
```

## Run from Server

```git
git merge updates
```

## sych files to the remote location

```git
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

## add, delete whole working tree

```git
git add -u :/
```

## Remove file from repository

```git
git rm --cached mylogfile.log
```


## Remove a directory from repository:

```git
git rm --cached -r mydirectory
```

## get remote url

```git
git config --get remote.origin.url
```

## set remote url

```git
git remote set-url origin Y:\Development\SourceControl\Git\SH_VS2013
```

## add new remote repo

```git
git remote add origin Y:\Development\SourceControl\Git\vs.net_2013
```

## firstly setup the remote repository:

```git
ssh git@example.com
cd Y:\Development\SourceControl\Git\web
y:
mkdir angular-karma.git
cd angular-karma.git
git init --bare
git update-server-info # If planning to serve via HTTP
```

## setup remote machine:

```git
md Y:\Development\SourceControl\Git\web\local.git
cd Y:\Development\SourceControl\Git\web\local.git
y:
git init --bare
```

## On local machine:

```git
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

## On other local machine:

```git
cd D:\PIM\Me\Software_Development\WEB
d:
git clone Y:\Development\SourceControl\Git\local.git
git clone Y:\Development\SourceControl\Git\local.git
```

## Clone from remote:

```git
git clone Y:\Development\SourceControl\Git\web\local.git
git clone Y:\Development\SourceControl\Git\web\local.git folderName
```


## Force Git to overwrite local files on pull

```git
git fetch --all
git reset --hard
git reset --hard HEAD
git reset --hard origin/my-rogers-al
```

# Git command

## list all config

```git
git config --list


Working with SSH key passphrases
https:##help.github.com/articles/working-with-ssh-key-passphrases/

git checkout internetcalculator
git checkout master
git checkout development
git checkout apolloApril1
git checkout origin/april8Production
```

if you got this message:
Updates were rejected because the tip of your current branch is behind

try to use this command

```git
git push -f origin internetcalculator

git log --author="Jonathan Speevak" --since="2013-01-30" --pretty -- test
git log --author="Anthony Lai" --since="2013-01-30" --pretty -- test
git log --since="2013-01-30" --pretty -- test

git log --author="Anthony Lai" --since="2016-05-30" --pretty=format:"%ce %an - %s"
git log --author="Anthony Lai" --since="2016-05-30" --pretty=format:"[%ci] %an ( %ce ) - %s"
git log --author="Anthony Lai" --since="2016-05-30" --pretty=format:"[ %cD ] %an - %s %N %n"
git log --author="Anthony Lai" --since="2016-09-01" --pretty=format:"[ %cD ] %an%n - %s %N %n"

git log --author="Anthony Lai" --since="2015-06-27" --pretty=format:"- [[%h](http://mydomain.com/ute-client-modules/ute-janrain-verification-service/commit/%H)] - **%s** (%aN)%n%n" > /c/temp/git.log
git log --since="2016-06-01" --pretty=format:"- [[%h](http://mydomain.com/ute-client-modules/ute-rogers-setpassword/commit/%H)] - **%s** (%aN)%n%n" > /c/temp/git.log
git log --since="2016-06-01" --pretty=format:"- [[%h](http://mydomain.com/ute-client-modules/ute-janrain-verification-service/commit/%H)] - **%s** (%aN)%n%n" > /c/temp/git.log
git log --since="2016-06-01" --pretty=format:"- [[%h](http://mydomain.com/ute-client-modules/ute-common-label/commit/%H)] - **%s** (%aN)%n%n" > /c/temp/git.log

git log --since="2016-06-01" --pretty=format:"%cD%n- [[%h](http://mydomain.com/ute-client-modules/ute-profile-edit-username-and-password/commit/%H)] - **%s** (%aN)%n%n" > /c/temp/git.log
git log --since="2016-08-01" --pretty=format:"%cD%n- [[%h](http://mydomain.com/ute-client-modules/xxxxx/commit/%H)] - **%s** (%aN)%n%n" > /c/temp/git.log
```

### Show graph in log
```git
git log --all --decorate --oneline --graph
```

## For MAC

```git
git log --since="2016-08-01" --pretty=format:"%cD%n- [[%h](http://mydomain.com/ute-client-modules/xxxxx/commit/%H)] - **%s** (%aN)%n%n" > ~/ls/temp/git.log
git log --since="2016-08-01" --pretty=format:"%cD%n- [[%h](http://mydomain.com/ute-client-modules/${PWD##*/}/commit/%H)] - **%s** (%aN)%n%n" > ~/ls/temp/git.log


git log --since="2017-03-19" --author="Jonathan Speevak"
```

## git log for change.md
### Color options
normal
black
red
green
yellow
blue
magenta
cyan
white
```git
git log --author="Anthony Lai" --since="2016-06-28 00:00:00" --pretty=format:"- [ %ci ] %s %N"
git log --since="2019-08-20 00:00:00" --pretty=format:"* %Cgreen[ %ci ]%Creset **core** - %s %N ([%h](https://github.com/%H)) by %C(yellow)( %an )" | grep -v  -e "Merge pull request" -e "Merge branch"
```

## Search commited code

```git
git log -S '/forgotPassword' --source --all
git log -S 'securityToken' --source --all

git log --all -S"if(!result || !result.statusCode"
git grep "if(!result || !result.statusCode" $(git rev-list --all)
```

## git compare branch

```git
git branch
git diff internetcalculator..master
git diff internetcalculator..april8Production
```

## git merge (development) to master

```git
git pull origin development
git push origin development
git checkout master
git pull origin master
git merge development
git push origin master

git merge --abort
```

## git merge pulloutbar to internetcalculator

```git
git checkout pulloutbar
git pull origin pulloutbar
git checkout internetcalculator
git pull origin internetcalculator
git merge pulloutbar
git push origin internetcalculator
```

## git rebase

```git
git checkout internetcalculator
git push origin internetcalculator
git checkout master
git pull origin master

git checkout internetcalculator
git pull origin internetcalculator

git rebase master
git push origin internetcalculator
```

## switch back to development

```git
git checkout development
git status

git pull origin development
git push origin development
```

## switch back to internetcalculator

```git
git checkout internetcalculator
git status

git pull origin internetcalculator
git push origin internetcalculator
```

## switch back to april8Production

```git
git checkout april8Production
git status

git push origin april8Production
git pull origin april8Production
```

## Create and switch to a new branch

```git
git checkout -b newBranchName
```

## switch to a new branch

```git
git checkout pulloutbar
```

## Removing a Tag

```git
git tag -d removetag
git push origin :refs/tags/removetag
```

## Create Tag for Module

```git
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

## Generat ssh key (from git bash):

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

## start the ssh-agent

```git
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

## Git global setup:

```git
git config --global user.name "Anthony Lai"
git config --global user.email "anthony.lai@mobilelive.ca"
```

## Create new Repository

```git
mkdir ute-reset-voicemail-password
cd ute-reset-voicemail-password
git init
touch README
git add README
git commit -m 'first commit'
git remote add origin git@mydomain.com:ute-client-modules/ute-reset-voicemail-password.git
git push -u origin master
```



## Existing Git Repo?

```git
cd existing_git_repo
git remote add origin git@mydomain.com:ute-client-modules/ute-reset-voicemail-password.git
git push -u origin master
```





## Work on your fork

```git
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



## for long filename

```git
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

## Git config file

```git
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

---

## Create a new branch and tracking develop branch

```bash
git checkout -b new-branch-name --track origin/develop
```

---
## Create a new remote branch on push --set-upstream
```bash
git push -u origin localBranch:remoteBranchToBeCreated
```

---
## Filename too long
### Error Message: error: unable to create file src/123.ts: Filename too long
```bash
git config --system core.longpaths true
git config core.longpaths true
```

#### Move old repo to new repo with history
```batch
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


#### Move old repo to new repo with history
#### Ref: https://www.atlassian.com/git/tutorials/git-move-repository
```batch
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


#### How to Migrate Git Repository with Branches and Commit History
#### Ref: https://blog.datanextsolutions.com/how-to-migrate-git-repository-with-branches-and-commit-history-dd129fd36dca
```batch
git clone --mirror <url-to-source-repo>
cd to-your-git-repo-folder.git   
git remote set-url --push origin <url-of-the-destination-git-repo>
git push --mirror
```





