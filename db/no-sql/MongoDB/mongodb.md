# Query Data

## Check date between
```json
{  updatedAt : { $gt:ISODate('2019-09-18T21:07:42.313+00:00'), $lt:ISODate('2019-09-20T21:08:42.313+00:00')  }  }
```

## Check date greater than
```json
{ updatedAt: { $gt: ISODate('2020-12-01T11:02:18.585+00:00')}}
```

## Is Property exist
```json
{ 'submissionId' : { '$exists' : true }}
```

## Field contains
```json

// MongoDB Filter:
{email: /Tst2/i}
{email: /.*share.*/}
{email : {$regex : "son"}
{ email : { '$regex' : 'test', '$options' : 'i' } }
```

## Add Field
### Convert _id to Datetime
```js
{
  dateAdded: {
    $toDate: "$_id"
  }
}
```

## Group
### Find duplicate record
```js
[
  {
    $group: {
      _id: "$_id",
      name: {
        $first: "$name"
      },
      count: {
        $sum: 1
      }
    }
  },
  {
    $match:
      /**
       * query: The query in MQL.
       */
      {
        count: {
          $gt: 1
        }
      }
  }
]
```
