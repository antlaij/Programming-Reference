## Add path to bash in .bashrc or .bash_profile
```
export PATH=$PATH:/c/Users/abcde/bin
```

```bash
# Function to refresh data
# arg $1: update - will get data from git server
# usage: refresh_from_git update
refresh_from_git()
{
  if [ "$1" == "update" ]; then
    echo "[=== Refreshing Data from Git for branch my-git-branch and develop ... ===]"
    echo
    git remote update origin --prune
    echo
    echo [ switch to my-git-branch branch ]
    echo
    git checkout my-git-branch
    git pull --all
    echo
    echo [ switch to my-other-git-branch branch ]
    echo
    git checkout my-other-git-branch
    git pull --all
  else
    echo "[=== Use Existing Data! ===]"
  fi
}

# Function to auto commit files
# usage: add_commit_push
add_commit_push()
{
  echo 
  echo "[ ===  Auto committing changes  === ]"
  echo 
  git add --all
  git commit -am "Automated Push by script"
  git push
}
```

```bash
source git-source.sh

myFolder=/c/Users/123456
officeFolder=/c/Users/123456

echo
echo
echo "[ *****   Script output   ***** ]"
echo 
cd  $myFolder
echo "[ ===  You are at Folder: $myFolder  === ]"
echo "[ ===  Current Branch   : $(git rev-parse --abbrev-ref HEAD)  === ]"
echo 
add_commit_push
echo
echo
echo 
echo 
cd  $officeFolder
echo "[ ===  You are at Folder: $officeFolder  === ]"
echo "[ ===  Current Branch   : $(git rev-parse --abbrev-ref HEAD)  === ]"
echo 
add_commit_push
```

## Defind variables

### Text variable
```
myTextVariable='text input'
gitInitBare='git init --bare'
```

### Array variable
```batch
items=(
item1
item2
item3
item4
)
```

### loop through Array
```batch
for Item in ${items[*]} 
  do
    echo
    echo
    echo
    testingFunction $Item
    echo ----- Done!
  done
```


## Defind Functions

### Function with parameter
```batch
testingFunction() {
  echo arg 01 = [$1]
  echo arg 02 = [$2]
}
```

### Call Function with parameters
```batch
    testingFunction Testing01 Testing02
```

