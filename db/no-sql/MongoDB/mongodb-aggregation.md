# Aggregation

## Join collection - $lookup
### Join collection with only the latest data from the child
```js
{
  $lookup: {
    from: "collectionToJoin", 
    as: "aliasName",
    let: {
      foreignKey: "$keyFromExistingTable"
    },
    pipeline: [
      {
        $match: {
          $expr: {
            $eq: [ "$$foreignKey", "$keyFromJoinCollection"]
          }
        }
      },
      {
        $sort: {
          "fieldToSort": -1
        }
      },
      {
        $limit: 1
      }
    ]
  }
}
```

## Sorting
### Sort the record and group by multiple fields
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

## Document Update
### Save changes back to the collection
#### Remove one field from document and save
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

### Remove one field from document by javascript
```js
db.download_manager.updateMany(
  {},
  [
    {
      $unset: "POSTED_DATE"
    }
  ]
)
```
