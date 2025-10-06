# Aggregation

## List all document if one of the value is not equal to a string in an array of object
```js
[
  {
    $match:
    {
      fieldFromRoot: {
        $eleMatch: {
          "objArray.keyName": {
            $ne: "search value"
          }
        }
      }
    }
  }
]
```

## Sort the record and group by multiple fields
```js
[
  {
    $group:
      {
        _id: {
          owner: "$owner",
          type: "$type"
        },
        count: {
          $count: {}
        }
      }
  },
  {
    $sort:
      {
        count: -1
      }
  }
]
```

## Change data type
### Convert Date String to real DateTime type
```js
[
  {
    $addFields:
      /**
       * newField: Using existing field name.
       * expression: The new field expression.
       */
      {
        dateStart: {
          $dateFromString: {
            dateString: "$dateStart"
          }
        },
        dateEnd: {
          $dateFromString: {
            dateString: "$dateEnd"
          }
        }
      }
  },
]
```

## Save changes back to the collection
### Remove one field from document and save
```js
[
  {
    $project:
      {
        dateStartDt: 0
      }
  },
  {
    $merge:
      {
        into: "events",
        whenMatched: "merge",
        whenNotMatched: "discard"
      }
  }
]
```
