# Angular 18+ Reference

---

## Configuration
### Change default port number when serving the application
#### Add port number in angular.json

```json
{
  "projects": {
    "Project-Name":{
      "architect": {
        "serve": {
          "options": {
            "port": 4300
          }
        }
      }
    }
  }
}
```

### Define prefix in component. Error will show in IDE
#### Add prefix in project.json
```json
{
  "prefix": "myappprefix"
}
```

#### Or add prefix in .eslintrc.json
```json
{
  "overrides": [
    {
      "rules": {
        "@angular-eslint/component-selector": [
          "error",
          {
            "prefix": "myappprefix",
          }
        ]
      }
    }
  ]
}
```

---

## Template
### Declare Variables in Templates - V18.1
#### @let operator
```html
@let name = 'Peter';
<h1>Dashboard for {{name}}</h1>
Hello, {{name}}
```

