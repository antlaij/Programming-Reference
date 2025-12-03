# Query Data

## DateTime Operation
### Show EST time with timezone in the document
```js
{
  estTime: {
    $dateToString: {
      date: "$OriginalDate",
      timezone: "$timezone",
      format: "%Y-%m-%d %H:%M:%S"
    }
  }
}
```

### Check date between
```json
{  updatedAt : { $gt:ISODate('2019-09-18T21:07:42.313+00:00'), $lt:ISODate('2019-09-20T21:08:42.313+00:00')  }  }
```

### Check date greater than
```json
{ updatedAt: { $gt: ISODate('2020-12-01T11:02:18.585+00:00')}}
```

## String Operation
### Split string into 2 string
#### Take the first string and rest of the string in 2 fields
"This is a test" to "This" and "is a test"
```js
[
  {
    $addFields: {
      status: {
        $substrBytes: [
          "$title",
          0,
          {
            $indexOfBytes: ["$title", " "]
          }
        ]
      },
      title: {
        $substrBytes: [
          "$title",
          {
            $add: [
              {
                $indexOfBytes: ["$title", " "]
              },
              1
            ]
          },
          {
            $subtract: [
              {
                $strLenBytes: "$title"
              }
            ]
          }
        ]
      }
    }
  }
]
```

### Replace a list of string - Regex
```js
[
  {
    $project:
    {
      restaurant: {
        $reduce: {
          input: [
            {
              find: "text 001",
              replacement: "TEXT"
            },
            {
              find: "text 002",
              replacement: "TEXT"
            }
          ],
          initialValue: "$restaurant",
          in: {
            $replaceAll: {
              input: "$$value",
              find: "$$this.find",
              replacement: "$$this.replacement"
            },
            $cond: [
              { $regexFind: { input: "$$value", regex: "$$this.find" } },
              "$$this.replacement",
              "$$value"
            ]
          }
        }
      },
      Amount: 1
    }
  }
]
```

### Replace a list of string - partial match
```js
[
  {
    $project:
    {
      restaurant: {
        $reduce: {
          input: [
            {
              find: "text 001",
              replacement: "TEXT"
            },
            {
              find: "text 002",
              replacement: "TEXT"
            }
          ],
          initialValue: "$restaurant",
          in: {
            $replaceAll: {
              input: "$$value",
              find: "$$this.find",
              replacement: "$$this.replacement"
            },
            $cond: [
              { $eq: ["$$value", "$$this.find"] },
              "$$this.replacement",
              "$$value"
            ]
          }
        }
      },
      Amount: 1
    }
  }
]
```

### Replace a list of string - exact match
```js
[
  {
    $project:
    {
      restaurant: {
        $reduce: {
          input: [
            {
              find: "text 001",
              replacement: "TEXT"
            },
            {
              find: "text 002",
              replacement: "TEXT"
            }
          ],
          initialValue: "$restaurant",
          in: {
            $cond: [
              { $eq: ["$$value", "$$this.find"] },
              "$$this.replacement",
              "$$value"
            ]
          }
        }
      },
      Amount: 1
    }
  }
]
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

## $group
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
      {
        count: {
          $gt: 1
        }
      }
  }
]
```

```js
[
  {
    $group: {
      _id: "$title",
      count: {
        $sum: 1
      }
    }
  },
  {
    $match: {
      count: {
        $gt: 1
      }
    }
  },
  {
    $sort: {
      count: -1
    }
  }
]
```

### Group by multiple fields and push child into an array
```js
[
  {
    $group: {
      _id: {
        field1: "$field1",
        field2: "$field2",
        field3: "$field3"
      },
      items: {
        $push: {
          item1: "$item1",
          item2: "$item2",
          item3: "$item3"
        }
      }
    }
  }
]
  ```

### Group by Year and Month and count items
```js
// Use $dateToString
[
  {
    $group: {
      _id: {
        $dateToString: {
          format: "%Y_%m",
          date: "$pubDate"
        }
      },
      count: {
        $sum: 1
      }
    }
  },
  {
    $project: {
      _id: 0,
      year_month: "$_id",
      count: 1
    }
  },
  {
    $sort: {
      year_month: -1
    }
  }
]

// Use $dateToString
[
  {
    $group: {
      _id: {
        year: {
          $year: "$pubDate"
        },
        month: {
          $month: "$pubDate"
        }
      },
      count: {
        $sum: 1
      },
      total: {
        $sum: "$Amount"
      }
    }
  },
  {
    $project: {
      _id: 0,
      time: {
        $concat: [
          {
            $toString: "$_id.year"
          },
          " ",
          {
            $cond: {
              if: {
                $lt: ["$_id.month", 10]
              },
              then: {
                $concat: [
                  "0",
                  {
                    $toString: "$_id.month"
                  }
                ]
              },
              else: {
                $toString: "$_id.month"
              }
            }
          }
        ]
      },
      count: 1,
      total: 1
    }
  },
  {
    $sort: {
      time: -1,
      count: -1
    }
  }
]
```

### Group by one field and getting other infomation as an array from the same document
#### exact match
```js
[
  {
    $match: {
      $and: [
        { name: /.jpg$/i },
        {
          name: {
            $nin: [
              "Folder.jpg",
              "back.jpg",
            ]
          }
        }
      ]
    }
  },
  {
    $group: {
      _id: "$name",
      filepaths: {
        $push: "$filepath"
      },
      count: {
        $sum: 1
      }
    }
  },
  {
    $match: {
      count: {
        $gt: 1
      }
    }
  },
  {
    $sort: {
      count: -1,
      _id: 1,
    }
  }
]
```

### Using Regular expression
```js
[
  {
    $match: {
      $and: [
        { name: /.jpg$|.png$/i },
        {
          name: {
            $not: {
              $regex:
                /icon.png|([0-9]{2}m?.jpg)|^([0-9]{3})|^tab-/i
            }
          }
        }
      ]
    }
  },
  {
    $group: {
      _id: "$name",
      filepaths: {
        $push: "$filepath"
      },
      count: {
        $sum: 1
      }
    }
  },
  {
    $match: {
      count: {
        $gt: 1
      }
    }
  },
  {
    $sort: {
      count: -1,
      _id: 1
    }
  }
]
```

## Array

### Get record with array size greater than 2
#### Use find
```json
db.collection.find({
  $expr: { $gt: [{ $size: "$albums.photos" }, 2] }
})
```
#### Use aggregation
```js
db.collection.aggregate([
  { $match: { $expr: { $gt: [ { $size: "$albums.photos" }, 2 ] } } }
])
```

### Get the first record from an array
```json
{
  "albums.photos": { $slice: 1 }
}
```

### Get only matching item from an array and add that to a new field
```js
[
  $addFields: {
    fieldToRemove: 0,
    newFieldFromArray: {
      $filter: {
        input: "$albums.photos",
        as: "matchedItems",
        cond: {
          $eq: { "$$matchedItems.id", 12345 }
        }
      }
    }
  }
]
```

### List all document if one of the value is not equal to a string in an array of object
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

### Get last item from a split string
```js
{
  $addFields:
    {
      extension: {
        $toLower: {
          $arrayElemAt: [
            {
              $split: ["$name", "."]
            },
            {
              $subtract: [
                {
                  $size: {
                    $split: ["$name", "."]
                  }
                },
                1
              ]
            }
          ]
        }
      }
    }
}
```

### Sort item in an array
```js
{
  _id: 0,
  result: {
    input: "$nestedArray",
    srotBy: {
      messageDate: 1,
      messageId: 1
    }
  }
}
```

### Remove null value from array
```js
{
  $project: {
    nestedArray: {
      $filter: {
        input: "$nestedArray", 
        cond: {
          $ne: ["$$this", null]
        }
      }
    }
  }
}
```

### Get all data with item in an array > 0
```js
{
  $expr: {
    $gt: [{ $size: "$albums" }, 0]
  }
}
```

## Opterator
### $unwind
Split an array field from the input documents into a new document for each element.
```json
[
  {
    key: 123,
    myArray: [
      { name: "Peter", age: 22 },
      { name: "John", age: 33 }
    ]
  }
]
```
```js
{
  $unwind: "myArray"
}
```
```json
[
  {
    key: 123,
    myArray: { name: "Peter", age: 22 }
  },
  {
    key: 123,
    myArray: { name: "John", age: 33 }
  }
]
```

## $cond
### Check field exist or not using $cond
```js
{
  $addFields:
    {
      groupName: {
        $cond: {
          if: {
            $ne: [
              {
                $type: "$groupNameRegEx"
              },
              "missing"
            ]
          },
          then: {
            $arrayElemAt: [
              "$groupNameRegEx.captures",
              0
            ]
          },
          else: "$name"
        }
      }
    }
}
```

