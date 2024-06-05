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

---

