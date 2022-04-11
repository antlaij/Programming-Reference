### Find and replace synctax

| Description | Find | Replace |
| :--- | :----: | :---: |
| Remove duplicate lines | ^(.*)(\n\1)+$ |$1|
| Replace from find | ^([a-zA-Z]+) |{headerName: '$1', field: '$1'}|
| Find all words and replace | ^([\w]+) |{headerName: '$1', field: '$1'}|


## Custom IDE color
### 
```json
{
	"folders": [
		{
			"path": "d:\\myDevFolder-Purple"
		}
	],
	"settings": {
		"editor.tabSize": 2,
    "workbench.colorCustomizations": {
      "activityBar.background": "#7f77bb",
      "activityBar.activeBackground": "#7f77bb",
      "activityBar.activeBorder": "#6a3b35",
      "activityBar.foreground": "#15202b",
      "activityBar.inactiveForeground": "#15202b99",
      "activityBarBadge.background": "#6a3b35",
      "activityBarBadge.foreground": "#e7e7e7",
      "titleBar.activeBackground": "#5f55aa",
      "titleBar.inactiveBackground": "#5f55aa99",
      "titleBar.activeForeground": "#e7e7e7",
      "titleBar.inactiveForeground": "#e7e7e799",
      "statusBar.background": "#5f55aa",
      "statusBarItem.hoverBackground": "#7f77bb",
      "statusBar.foreground": "#e7e7e7",
      "sash.hoverBorder": "#7f77bb",
      "statusBarItem.remoteBackground": "#5f55aa",
      "statusBarItem.remoteForeground": "#e7e7e7"
    },
    "peacock.color": "#5f55aa"
  }
}
```