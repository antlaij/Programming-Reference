# Typescript

## Table of Contents
  1. [String literal types](#String-literal-types)
      1. [Use array of string to hold the values for a string literal types. ](#Use-array-of-string-to-hold-the-values-for-a-string-literal-types.-)
  1. [Destructuring with types](#Destructuring-with-types)
  1. [Bitwise](#Bitwise)
      1. [Access Rights check](#Access-Rights-check)
  1. [Function](#Function)
      1. [Create Function syntax](#Create-Function-syntax)
  1. [enum](#enum)
      1. [Check if object exist in ENUM porperty's name](#Check-if-object-exist-in-ENUM-porperty's-name)
      1. [Check if object in ENUM property's values](#Check-if-object-in-ENUM-property's-values)
  1. [Model which accept another model](#Model-which-accept-another-model)
  1. [Conditional Typescript type with generic](#Conditional-Typescript-type-with-generic)
  1. [Discriminated union and Intersection types](#Discriminated-union-and-Intersection-types)

***

## String literal types
### Use array of string to hold the values for a string literal types. 
- This made the logic easy to get all values from the type
```ts
const ThemeMOdes = ['dark', 'light', 'os-default'] as const;
type ThemeMode = typeof ThemeMOdes[number];
```

## Destructuring with types
```ts
let destructuring = ({
  proA,
  proB,
  proC: {
    ChildC1,
    ChildC2: {grandchildren}
  },
  proD: { childD1 }
}: {
  proA: string;
  proB: string;
  proC: { ChildC1: number; ChildC2: {grandchildren: number}};
  proD: { childD1: number};
}) => {
  console.log( '(proA, proB, ChildC1, grandchildren, ChildD1) => ',
  proA,
  proB,
  ChildC1,
  grandchildren,
  childD1);
};

var data = {
  proA: 'property A',
  proB: 'property B',
  proC: { ChildC1: 123, ChildC2: { grandchildren: 456}},
  proD: { childD1: 789 }
};

/* Output:
(proA, proB, ChildC1, grandchildren, ChildD1) =>  property A property B 123 456 789
*/
```

## Bitwise
### Access Rights check
```ts
enum AccessRights {
  None = 0,
  ReadOnly = 1,
  Delete = ReadOnly << 1,
  Update = Delete << 1,
  Add = Update << 1,
  Full = (Add << 1) -1
}

let isRightsGranted = (currentMode: AccessRights, targetMode: AccessRights): boolean => {
  return (
    (currentMode & targetMode) === targetMode
    || (currentMode & AccessRights.Full) === AccessRights.Full
  );
}

let myRights = AccessRights.Add | AccessRights.ReadOnly | AccessRights.Delete;

console.log('Has Granted Add        : ', isRightsGranted(myRights, AccessRights.Add));
console.log('Has Granted Delete     : ', isRightsGranted(myRights, AccessRights.Delete));
console.log('Has Granted Update     : ', isRightsGranted(myRights, AccessRights.Update));
console.log('Has Granted ReadOnly   : ', isRightsGranted(myRights, AccessRights.ReadOnly));

/* Output:
Has Granted Add        :  true
Has Granted Delete     :  true
Has Granted Update     :  false
Has Granted ReadOnly   :  true
*/

```

## Function
### Create Function syntax
```ts
let findDuplicate = (key: string): number => {
  return 0;
}
```

## enum
### Check if object exist in ENUM porperty's name
```ts
export enum myEnum {
  one = '1',
  two = '2',
  three = '3',
  four = '4',
}

if('three' in myEnum) {
}
```

### Check if object in ENUM property's values
```ts
export enum myEnum {
  one = '1',
  two = '2',
  three = '3',
  four = '4',
}

if(Object.values(myEnum).includes('3'))) {
}

```


## Model which accept another model
```ts
export class ApiPagingResponse<TList> {
  Items: Array<TList>;
  StartIndex: number;
  PageSize: number;
  TotalNumberOfRecords: number;
}
```


## Conditional Typescript type with generic
```ts
type ApiResponse<T> = 
| { status: 'success'; data: T; timestamp: Date}
| { status: 'error'; message: string; timestamp: Date};

let res1: ApiResponse<number> = {
    status: 'success',
    data: 100,
    timestamp: new Date()
}

let res2: ApiResponse<number> = {
    status: 'error',
    message: '100',
    timestamp: new Date()
}
```


## Discriminated union and Intersection types
```ts
type FileFilterOption = {
  DirectoryType: 'Folder' | 'File' | 'Extension',
  FilterType: 'Include' | 'Exclude',
} & (
  | {
    searchBy: 'txt',
    Filter: string,
  }
  | {
    searchBy: 'RegExp',
    Filter: RegExp,
  }
)
```
