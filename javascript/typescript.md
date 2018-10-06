```ts
let destructuring = ({
  proA,
  proB,
  proC: {
    Child_C1,
    Child_C2: {grandChildren}
  },
  proD: { child_D1 }
}: {
  proA: string;
  proB: string;
  proC: { childC1: number; childC2: {grandchildren: number}};
  proD: {ChildD1: number};
}) => {
  console.log( '(proA, proB, ChildC1, grandchildren, ChildD1) => ',
  proA,
  proB,
  ChildC1,
  grandchildren,
  ChildD1);
};

var data = {
  proA: 'property A',
  proB: 'property B',
  proC: { ChildC1 123, ChildC2: { grandchildren: 456}},
  proD: { childD1: 789 }
};
destructuring(data);
```
