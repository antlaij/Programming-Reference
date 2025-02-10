# Python basic
## Table of Contents
  1. [Declare Variable](#Declare-Variable)
  1. [String](#String)
      1. [Format string](#Format-string)
  1. [Datetime](#Datetime)
      1. [Format Datetime](#Format-Datetime)
  1. [Number](#Number)
      1. [float](#float)
          1. [Format Float](#Format-Float)

***

## Installation
### PIP or PIP3

#### Check installed packages
```sh
pip3 list
```

#### Upgrade existing package
```sh
pip3 install <package name> --upgrade
```

#### Upgrade existing package
```sh
python3 -m pip install --upgrade pip
python3 -m pip3 install --upgrade pip3
```


## System Info.
```python
# Global details
globals()

# Local details
locals()
```

### Check system details
```python
import sys

sys.modules

# check where python is installed
sys.prefix

# check where python is executing
sys.exec_prefix

# Where does Python look for imports
sys.path
```


## Module
```python
import math

# Module name
math.__bane__

# Dictionary
math.__dict__

dir(math)
```

## Package
### Add Library folder to sys.path
```py

# [=====  Add Library folder to sys.path  =====]
# Number of levels to go to library root
PARENT_LEVEL_UP = 2
# Get the multi-level up path
LIB_ROOT_PATH = os.path.dirname(os.path.dirname(__file__))
for _ in range(PARENT_LEVEL_UP):
    LIB_ROOT_PATH = os.path.dirname(LIB_ROOT_PATH)
# print(LIB_ROOT_PATH)

# Apped to sys.path
sys.path.append(LIB_ROOT_PATH)
# print(sys.path)
# [=====  Library path added  =====]

from lib.doc.pdf import Pdf

```


## Declare Variable
```python
x = 5
```


## String
### Format string
```python
myString: str = 'hello'
print(f'{myString:>20}')
print(f'{myString:30}: {myString}')
print(f'{myString:<30}: {myString}')
print(f'{myString:^30}: {myString}')
print(f'{myString:_>20}')
print(f'{myString:?>20}')
print(f'{myString:#>20}')
```

Output:
```txt
>>> print(f'{myString:>20}')
               hello

>>> print(f'{myString:30}: {myString}')
hello                         : hello

>>> print(f'{myString:<30}: {myString}')
hello                         : hello

>>> print(f'{myString:^30}: {myString}')
            hello             : hello

>>> print(f'{myString:_>20}')
_______________hello

>>> print(f'{myString:?>20}')
???????????????hello

>>> print(f'{myString:#>20}')
###############hello

```

## Datetime
### Format Datetime
```python
from datetime import datetime

now: datetime = datetime.now()

print(f'{now:%d.%m.%y (%H:%M:%S)}')
10.11.24 (10:49:28)

print(f'{now:%c}')
Sun Nov 10 10:49:28 2024

print(f'{now:%I%P}')
10am

```

## Number
### float
#### Format Float
```python
myNum: float = 123456.78901234

print(f'myNum: {myNum:.2f}')
print(f'myNum: {myNum:.0f}')
print(f'myNum: {myNum:_.3f}')
print(f'myNum: {myNum:,.3f}')
```
Output
```txt

myNum: 123.46
>>> print(f'myNum: {myNum:.0f}')
myNum: 123
>>> myNum: float = 123456.78901234
>>> print(f'myNum: {myNum:.2f}')
myNum: 123456.79
>>> print(f'myNum: {myNum:.0f}')
myNum: 123457
>>> print(f'myNum: {myNum:_.3f}')
myNum: 123_456.789
>>> print(f'myNum: {myNum:,.3f}')
myNum: 123,456.789

```


## Type hints
[typing — Support for type hints](https://docs.python.org/3/library/typing.html)
[Type hints cheat sheet](https://mypy.readthedocs.io/en/stable/cheat_sheet_py3.html)
### Basic Types

Text Type:         str
Numeric Types:     int, float, complex
Sequence Types:    list, tuple, range
Mapping Type:      dict
Set Types:         set, frozenset
Boolean Type:      bool
Binary Types:      bytes, bytearray, memoryview
None Type:         NoneType

### Union types
```py
def my_func(first: Union[int, str, float]) -> str:
    return ''
```

### typing.Optional types
```py
def my_func(optional_param: Optional[str]) -> None:
    pass
```


## Function
### Argument & Parameter Types
#### pass argument by labels
```py
def my_fn(x, y):
    print(x, y)
    pass

my_fn(y=2, x=1)
```

#### pass argument by position and labels
position argument has to go first
```py
def my_fn(x, y, z):
    print(x, y, z)
    pass

my_fn(1, Z=3, y=2)
```

#### optional argument
```py
def my_fn(x, y, z=3):
    print(x, y, z)
    pass

my_fn(1, y=2)
```
```txt
1 2 3
```

#### *args and **kwargs
```py
def my_fn(x, y, *args):
    print(x, y, args)
    pass

my_fn(1, 2, 3, 4, 5, 6, 7)
```
Output
```txt
1 2 (3, 4, 5, 6, 7)
```
```py
def my_fn(*args, **kwargs):
    print(args, kwargs)
    print(kwargs['x'])
    pass

my_fn(1, 2, 3, 4, 5, 6, 7, x = 'abc', y = 'def')
```
Output
```txt
(1, 2, 3, 4, 5, 6, 7) {'x': 'abc', 'y': 'def'}
abc
```
```py
def my_fn(w, x, y, z):
    print(w, x, y, z)
    pass

my_fn(*[1, 2], **{'y': 'abc', 'z': 'def'})
```
Output
```txt
1 2 abc def
```


## List
### list comprehension
```py
def double(x):
    return x * 2

doubled = [double(x) for x in range(5)]
print(doubled)

# Output: [0, 2, 4, 6, 8]
```



