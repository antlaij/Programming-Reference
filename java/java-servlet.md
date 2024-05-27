# JAVA Servlet

## Table of Contents
  1. [Get information from request](#Get-information-from-request)
    1. [get data with same name](#get-data-with-same-name)
      1. [Use: request.getParameterValues(key)](#Use:-request.getParameterValues(key))
      1. [Change the list of string to comma seperated string](#Change-the-list-of-string-to-comma-seperated-string)
        1. [["a", "b", "c", "d"] ==> "a,b,c,d"](#["a",-"b",-"c",-"d"]-==>-"a,b,c,d")
  1. [Get information from request](#Get-information-from-request)
    1. [get data with same name](#get-data-with-same-name)
      1. [Use: request.getParameterValues(key)](#Use:-request.getParameterValues(key))
      1. [Change the list of string to comma seperated string](#Change-the-list-of-string-to-comma-seperated-string)
        1. [["a", "b", "c", "d"] ==> "a,b,c,d"](#["a",-"b",-"c",-"d"]-==>-"a,b,c,d")

***


## Get information from request
### get data with same name
#### Use: request.getParameterValues(key)
```html
  <input type="checkbox" id="chkboxId1" name="chkStatus" value="a" >
  <input type="checkbox" id="chkboxId2" name="chkStatus" value="b" >
  <input type="checkbox" id="chkboxId3" name="chkStatus" value="c" >
  <input type="checkbox" id="chkboxId4" name="chkStatus" value="d" >
```
```java
  String[] values = request.getParameterValues("key");
  List<String> valueList = Arrays.asList(values);
```
#### Change the list of string to comma seperated string
##### ["a", "b", "c", "d"] ==> "a,b,c,d"
```java
  String.join(",", valueList);
```

## Get information from request
### get data with same name
#### Use: request.getParameterValues(key)
```java

		Map<String, Object> mapInfo = new HashMap<>();
    List<LinkedHashMap<String, Object>> dataArrayList = new ArrayList<>();
    LinkedHashMap<String, Object> entryHm = new LinkedHashMap<String, Object>();
    entryHm.put("NAME", "Peter");
    entryHm.put("PHONE", "123-456-7890");
    entryHm.put("ADDRESS", "123 Street");
    entryHm.put("EMAIL", "123@abc.com");
    entryHm.put("AGE", 30);
    dataArrayList.add(entryHm);
		mapInfo.put("myList", dataArrayList);
```
#### Change the list of string to comma seperated string
##### ["a", "b", "c", "d"] ==> "a,b,c,d"
```java
  String.join(",", valueList);
```
