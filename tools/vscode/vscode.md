### Find and replace synctax

| Description | Find | Replace |
| :--- | :----: | :---: |
| Remove duplicate lines | ^(.*)(\n\1)+$ |$1|
| Replace from find | ^([a-zA-Z]+) |{headerName: '$1', field: '$1'}|
| Find all words and replace | ^([\w]+) |{headerName: '$1', field: '$1'}|