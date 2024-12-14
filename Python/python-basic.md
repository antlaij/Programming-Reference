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



