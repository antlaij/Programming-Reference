# Anaconda

## conda

### Settings
#### Prevent Conda from activating the base environment by default
```sh
conda config --set auto_activate_base false
```

### list
### LIst all env
```sh
conda env list
```
### list all installed package
```sh
conda list
```

### create
#### Create new env with a python version
```sh
conda create -n opencv-py38 python=3.9
```

### Remove
#### remove env
```sh
conda remove -n opencv --all
```

#### Remove environment by location
```sh
conda env remove --prefix /path/to/your/environment
```

### Activate environment
```sh
conda activate opencv
```

