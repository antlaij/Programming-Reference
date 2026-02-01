# UV for python
[Standalone installer](https://docs.astral.sh/uv/getting-started/installation/#installation-methods)

# Installation for Windows 11
```sh
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
```

## Setting

To add C:\Users\user_name\.local\bin to your PATH, either restart your shell or run:

```bash
set Path=C:\Users\antla\.local\bin;%Path%   (cmd)
$env:Path = "C:\Users\antla\.local\bin;$env:Path"   (powershell)
```

# Create new project
For Application
```sh
uv init py-api-uv --app
```

For Library
```sh
uv init py-api-uv --lib
```

## Crate a virtual environment
```sh
uv venv --python 3.14
```

Allow scripts for your user only 
```sh
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```


## Install all packages
```sh
uv sync
```





