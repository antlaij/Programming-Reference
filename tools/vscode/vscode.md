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
        "activityBar.background": "#7d73ca",
        "activityBar.activeBackground": "#bd9fff",
        "activityBar.activeBorder": "#35416a",
        "activityBar.foreground": "#15202b",
        "activityBar.inactiveForeground": "#15202b99",
        "activityBarBadge.background": "#6d22f8",
        "activityBarBadge.foreground": "#ffffff",
        "titleBar.activeBackground": "#5f55aa",
        "titleBar.inactiveBackground": "#5f55aa99",
        "titleBar.activeForeground": "#e7e7e7",
        "titleBar.inactiveForeground": "#e7e7e7c7",
        "statusBar.background": "#5f55aa",
        "statusBarItem.hoverBackground": "#7f77bb",
        "statusBar.foreground": "#e7e7e7",
        "sash.hoverBorder": "#7f77bb",
        "statusBarItem.remoteBackground": "#5f55aa",
        "statusBarItem.remoteForeground": "#e7e7e7",
        "commandCenter.border": "#e7e7e799",
        "editor.lineHighlightBackground": "#00cccc20",
        "editor.selectionBackground": "#00ffff60",
        "editor.wordHighlightBackground": "#611028",
        "editor.findMatchHighlightBackground": "#ff7b00a1", // Match with the
        "editor.findRangeHighlightBackground": "#ff0000",
        "editor.selectionHighlightBackground": "#ffff0060",
        "editor.inactiveSelectionBackground": "#168b1690",
        "editor.lineHighlightBorder": "#00ffff15"
    },
    "peacock.color": "#5f55aa"
  }
}
```
### 
```json
{
	"folders": [
		{
			"path": "d:\\myDevFolder-Blue"
		}
	],
	"settings": {
		"editor.tabSize": 2,
    "workbench.colorCustomizations": {
      "activityBar.background": "#45678f",
      "activityBar.activeBackground": "#6db7ed",
      "activityBar.activeBorder": "#6a3b35",
      "activityBar.foreground": "#15202b",
      "activityBar.inactiveForeground": "#15202b99",
      "activityBarBadge.background": "#00c8ff",
      "activityBarBadge.foreground": "#000000",
      "titleBar.activeBackground": "#5570aa",
      "titleBar.inactiveBackground": "#5570aa99",
      "titleBar.activeForeground": "#e7e7e7",
      "titleBar.inactiveForeground": "#e7e7e799",
      "statusBar.background": "#45678f",
      "statusBarItem.hoverBackground": "#003860",
      "statusBar.foreground": "#e7e7e7",
      "sash.hoverBorder": "#779fbb",
      "statusBarItem.remoteBackground": "#5570aa",
      "statusBarItem.remoteForeground": "#e7e7e7"
    },
    "peacock.color": "#5570aa"  
  }
}
```
### 
```json
{
	"folders": [
		{
			"path": "d:\\myDevFolder-Green"
		}
	],
	"settings": {
		"editor.tabSize": 2,
    "workbench.colorCustomizations": {
      "activityBar.background": "#4d987c",
      "activityBar.activeBackground": "#8ee9a5",
      "activityBar.activeBorder": "#7f4054",
      "activityBar.foreground": "#15202b",
      "activityBar.inactiveForeground": "#15202b99",
      "activityBarBadge.background": "#b9ff99",
      "activityBarBadge.foreground": "#000000",
      "titleBar.activeBackground": "#1a8978",
      "titleBar.inactiveBackground": "#1a897899",
      "titleBar.activeForeground": "#e7e7e7",
      "titleBar.inactiveForeground": "#e7e7e799",
      "statusBar.background": "#55aa96",
      "statusBarItem.hoverBackground": "#8ee9a5",
      "statusBar.foreground": "#000000",
      "sash.hoverBorder": "#778dbb",
      "statusBarItem.remoteBackground": "#55aa96",
      "statusBarItem.remoteForeground": "#000000",
      "editor.lineHighlightBackground": "#00cccc20",
      "editor.selectionBackground": "#00ffff60",
      "editor.wordHighlightBackground": "#611028",
      "editor.findMatchHighlightBackground": "#ff7b00a1", // Match with the
      "editor.findRangeHighlightBackground": "#ff0000",
      "editor.selectionHighlightBackground": "#ffff0060",
      "editor.inactiveSelectionBackground": "#168b1690",
      "editor.lineHighlightBorder": "#00ffff15"
    },
    "peacock.color": "#5570aa"  
  }
}
```
### 
```json
{
	"folders": [
		{
			"path": "d:\\DEV-Yellow"
		}
	],
	"settings": {
		"editor.tabSize": 2,
    "workbench.colorCustomizations": {
      "activityBar.background": "#747400",
      "activityBar.activeBackground": "#747400",
      "activityBar.activeBorder": "#00bfbf",
      "activityBar.foreground": "#e7e7e7",
      "activityBar.inactiveForeground": "#e7e7e799",
      "activityBarBadge.background": "#00bfbf",
      "activityBarBadge.foreground": "#15202b",
      "titleBar.activeBackground": "#414100",
      "titleBar.inactiveBackground": "#41410099",
      "titleBar.activeForeground": "#e7e7e7",
      "titleBar.inactiveForeground": "#e7e7e799",
      "statusBar.background": "#414100",
      "statusBarItem.hoverBackground": "#747400",
      "statusBar.foreground": "#e7e7e7",
      "sash.hoverBorder": "#747400",
      "statusBarItem.remoteBackground": "#414100",
      "statusBarItem.remoteForeground": "#e7e7e7",
      "commandCenter.border": "#e7e7e799"
    },
    "peacock.color": "#5570aa"  
  }
}
```
### 
```json
{
	"folders": [
		{
			"path": "d:\\UAT-Orange"
		}
	],
	"settings": {
		"editor.tabSize": 2,
    "workbench.colorCustomizations": {
      "activityBar.background": "#743e00",
      "activityBar.activeBackground": "#a77405",
      "activityBar.activeBorder": "#00bfbf",
      "activityBar.foreground": "#e7e7e7",
      "activityBar.inactiveForeground": "#e7e7e799",
      "activityBarBadge.background": "#00bfbf",
      "activityBarBadge.foreground": "#15202b",
      "titleBar.activeBackground": "#743e00",
      "titleBar.inactiveBackground": "#743e00",
      "titleBar.activeForeground": "#e7e7e7",
      "titleBar.inactiveForeground": "#e7e7e799",
      "statusBar.background": "#743e00",
      "statusBarItem.hoverBackground": "#747400",
      "statusBar.foreground": "#e7e7e7",
      "sash.hoverBorder": "#747400",
      "statusBarItem.remoteBackground": "#414100",
      "statusBarItem.remoteForeground": "#e7e7e7"
    },
    "peacock.color": "#5570aa"  
  }
}
```