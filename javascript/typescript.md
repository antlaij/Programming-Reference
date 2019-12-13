# Destructuring with types

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
  return ((currentMode & targetMode) === targetMode || (currentMode & AccessRights.Full) === AccessRights.Full);
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

## Create Function syntax

```ts

let findDuplicate = (key: string): number => {
  return 0;
}

let findDuplicate = (key: string): number => {
  return 0;
}
```

## Check if object in an ENUM name

```ts

export enum myEnum {
  one = 'one',
  two = 'two',
  three = 'three',
  four = 'four',
}

if('three' in myEnum) {
}

```

## Check if object in an ENUM values

```ts

export enum myEnum {
  one = 'one',
  two = 'two',
  three = 'three',
  four = 'four',
}

if(Object.values(myEnum).includes('three'))) {
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
