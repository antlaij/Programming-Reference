# JAVA Servlet

## Table of Contents
  * [ArrayList](#ArrayList)
    * [Create ArrayList with default value](#Create-ArrayList-with-default-value)
    * [Use Stream on ArrayList of object](#Use-Stream-on-ArrayList-of-object)
    * [Get first item from a list](#Get-first-item-from-a-list)
    * [Use Stream on ArrayList of object](#Use-Stream-on-ArrayList-of-object)
    * [Map to other value](#Map-to-other-value)

***


## ArrayList
### Create ArrayList with default value
```java
  ArrayList<String> stringArraylist = new ArrayList(Arrays.asList("3A", "3B"));
```

### Use Stream on ArrayList of object
### Get first item from a list
```java
  ArrayList<MyModel> myModelList = myObject.getMyList();
  MyModel match = myModelList.stream()
  // Select the data by filter
  .filter(model -> model.getProperty().equals("123456"))
  // Change the data before return
	.map(x -> x.replace("Selected_Status_",""))
  // Return just the first record
  .findFirst()
  .get();
```

### Use Stream on ArrayList of object
### Map to other value
```java
  ArrayList<MyModel> myModelList = myObject.getMyList();
  List<MyModel> match = myModelList.stream()
	.map(model -> model.getProperty().replace("Selected_Status_",""))
  // Return all records
  .collect(Collectors.toList());
```

