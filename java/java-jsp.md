# JAVA JSP
## Table of Contents
  1. [Debug jsp](#Debug-jsp)
      1. [Add current jsp filename to the page](#Add-current-jsp-filename-to-the-page)
          1. [Add the code before <html> tag](#Add-the-code-before-<html>-tag)
      1. [Print data to html](#Print-data-to-html)
          1. [Print value with line number](#Print-value-with-line-number)
          1. [Print value to html](#Print-value-to-html)
      1. [Print compiled line number to the log](#Print-compiled-line-number-to-the-log)
          1. [It is for debug jsp page](#It-is-for-debug-jsp-page)
      1. [Print variable](#Print-variable)

***

## Debug jsp

### Add current jsp filename to the page
#### Add the code before <html> tag
```html
<!-- <%=this.getClass().getSimpleName().replaceFirst("__","").replaceFirst("_jsp","")%> -->
```

### Print data to html
#### Print value with line number
```java
  out.println(String.format("<div style='margin: 0.5rem;padding: 0.5rem;background-color: #ffff00;color: black;font-size: x-large;'>Line number: %s</div>", new Throwable().getStackTrace()[0].getLineNumber()));
```
#### Print value to html
```html
  <div style="margin: 0.5rem;padding: 0.5rem;background-color: #ffff00;color: black;font-size: x-large;"><pre><%= "jspValue: " + uniEmailInfo %></pre></div>
```
```java
  out.println(String.format("<div style='margin: 0.5rem;padding: 0.5rem;background-color: #ffff00;color: black;font-size: x-large;'>jspValue: %s</div>", value));
```

### Print compiled line number to the log
#### It is for debug jsp page
```java
  System.out.println("al => filename.jsp checkpoint at line L:" + new Throwable().getStackTrace()[0].getLineNumber());
```

### Print variable
```java
  System.out.println(String.format("al => filename.jsp:  (value) ==>%s<==", value));

  HelperBean.println(String.format("al => classname.method - (wam) >>>%s<<<", wam));
```
