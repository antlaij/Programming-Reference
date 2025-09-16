# Angular Ag Grid
## Table of Contents
  1. [AgGrid - Boolean Cell editor](#AgGrid---Boolean-Cell-editor)
  1. [Renderer](#Renderer)
      1. [Boolean Cell Renderer](#Boolean-Cell-Renderer)
      1. [Router Link Cell Renderer](#Router-Link-Cell-Renderer)
  1. [Reset Server Side data](#Reset-Server-Side-data)
      1. [Get Displayed Row Count](#Get-Displayed-Row-Count)
      1. [Get Filtered Row Count](#Get-Filtered-Row-Count)
  1. [Column](#Column)
      1. [Scroll to a column](#Scroll-to-a-column)
  1. [Filter](#Filter)
      1. [Hide Filter Icon from floating bar](#Hide-Filter-Icon-from-floating-bar)
      1. [Filter by cellRenderer value instead of column value](#Filter-by-cellRenderer-value-instead-of-column-value)
  1. [Data Summary](#Data-Summary)
      1. [Show Total row count, Filtered row count ... in ag grid. Add status bar to Ag Grid](#Show-Total-row-count,-Filtered-row-count-...-in-ag-grid.-Add-status-bar-to-Ag-Grid)
      1. [Turning On Infinite Scrolling without ag-Grid Enterprise](#Turning-On-Infinite-Scrolling-without-ag-Grid-Enterprise)
      1. [Center Align column with css](#Center-Align-column-with-css)
  1. [Cell](#Cell)
      1. [Cell Event](#Cell-Event)
          1. [onClick Event](#onClick-Event)
      1. [Cell Button](#Cell-Button)
          1. [Button call parent component](#Button-call-parent-component)
  1. [Master and Detail grid](#Master-and-Detail-grid)
      1. [Change detail grid height](#Change-detail-grid-height)

***

---
## AgGrid - Boolean Cell editor

```ts
import { Component, ViewChild, ViewContainerRef, AfterViewInit } from '@angular/core';
import { INoRowsOverlayAngularComp, ICellEditorAngularComp } from "ag-grid-angular";
import { ICellEditorParams } from 'ag-grid-community';

@Component({
  selector: 'app-gender-renderer',
  template: `<input #container type='checkbox' [checked]="params.value" (change)="onChange($event)" />`
})
export class AgGridBooleanCellEditor implements ICellEditorAngularComp, AfterViewInit {

  params: any;
  returnValue: boolean;

  private localData: any;

  @ViewChild('container', { read: ViewContainerRef }) container: any;

  // dont use afterGuiAttached for post gui events - hook into ngAfterViewInit instead for this
  ngAfterViewInit() {
    setTimeout(() => {
      this.container.element.nativeElement.focus();
      this.container.element.nativeElement.click();
    });
  }

  agInit(params): void {
    this.params = params;
    this.localData = params.node.data;
    this.returnValue = this.localData[params.key];
  }

  getValue(): any {
    return this.returnValue;
  }

  public onChange(event) {
    this.returnValue = !this.returnValue;
    this.params.api.stopEditing();
  }
}
```

---
## Renderer

### Boolean Cell Renderer
```ts
import { Component } from '@angular/core';
import { INoRowsOverlayAngularComp } from "ag-grid-angular";

@Component({
  selector: 'app-gender-renderer',
  template: `<input type='checkbox'  [checked]="params.value" (change)="onChange($event)" />`
})
export class EditableBooleanCellRenderer implements INoRowsOverlayAngularComp {

  params: any;

  agInit(params): void {
    this.params = params;
  }

  public onChange(event) {
    this.params.data[this.params.colDef.field] = event.currentTarget.checked;
  }
}
```

---
### Router Link Cell Renderer

```ts
import { Component } from '@angular/core';
import { INoRowsOverlayAngularComp } from "ag-grid-angular";

@Component({
  selector: 'router-link-cell-renderer',
  template: `<a *nfIf="" [routerLink]="urlPath">{{linkText}}</a>`,
})
export class EditableBooleanCellRenderer implements INoRowsOverlayAngularComp {

  params: any;
  linkText: string;
  urlPath: Array<string>;

  agInit(params): void {
    this.links = [];
    this.urlPath = [];
    this.params = params;

    if(params.data && params.data.myColumnData) {
      this.urlPath = ['/', params.data.myColumnData, ''];
    }
  }
}
```

---
## Reset Server Side data

```ts
this.gridApi.purgeServerSideCache(route);
```

---
### Get Displayed Row Count

```ts
  get totalNumberOfRows(): number {
    return this.gridApi ? this.gridApi.getDisplayedRowCount() : 0;
  }
```

---
### Get Filtered Row Count

```ts
public get filteredRowCount() {
  let filteredRowCount = 0;
  // iterate only nodes that pass the filter
  if(this.gridApi) {
    this.gridApi.forEachNodeAfterFilter(function(rowNode, index) {
        filteredRowCount++;
    });
  }
  return filteredRowCount;
}
```


---
## Column
### Scroll to a column
```ts
this.gridApi.ensureColumnVisible('columnName');
```


---
## Filter

### Hide Filter Icon from floating bar
```ts
public DEFAULT_COL_DEF: ColDef = {
  floatingFilterComponentParams: { suppressFilterButton: true }
};
```

---
### Filter by cellRenderer value instead of column value
```ts
{ colId: 'testId', headerName: 'test column', field: 'dataColumn', cellRenderer: 'customRenderer', filterValueGetter: (params) => this.myService.method(params.data.dataColumn) }
```


## Data Summary
---
### Show Total row count, Filtered row count ... in ag grid. Add status bar to Ag Grid
```html
<ag-grid-angular
  [statusBar]="statusBar"
  >
</ag-grid-angular>
```
```ts
const STATUS_BAR: {
  statusPanels: StatusPanelDef[];
} = {
  statusPanels: [
    { statusPanel: "agTotalAndFilteredRowCountComponent" },
    { statusPanel: "agTotalRowCountComponent" },
    { statusPanel: "agFilteredRowCountComponent" },
    { statusPanel: "agSelectedRowCountComponent" },
    { statusPanel: "agAggregationComponent" },
  ],
};
```


---
### Turning On Infinite Scrolling without ag-Grid Enterprise
[Link from Ag Grid pagination](https://www.ag-grid.com/javascript-grid-infinite-scrolling/#pagination)

```html
      <ag-grid-angular
        #agGrid
        style="width: 100%; height: 100%;"
        id="myGrid"
        class="ag-theme-alpine"
        [columnDefs]="columnDefs"
        [datasource]="datasource"
        [components]="components"
        [defaultColDef]="defaultColDef"
        rowSelection="multiple"
        rowModelType="infinite"
        maxBlocksInCache="2"
        infiniteInitialRowCount="500"
        maxConcurrentDatasourceRequests="2"
        [getRowNodeId]="getRowNodeId"
        [getRowStyle]="getRowStyle"
        [rowData]="rowData"
        (gridReady)="onGridReady($event)"
      ></ag-grid-angular>
```
```ts
public onGridReady = (params: AgGridEvent) => {
  this.gridApi.showLoadlingOverlay();

  combineLatest([this.refreshData$, changes_00, changes_01])
    .pipe(
      switchMap(([changes_00, changes_01]) => {
        this.dataService$(params.startRow, changes_00, changes_01)
        .pipe(
          catchError(error => {
            console.error(error);
            return of({'default data'});
          })
        )
      })
    )
    .subscribe([serverData]) => {
      this.gridApi.hideOverlay();
    }
  );

  this.setAgGridDataSource(0);
}

private setAgGridDataSource = (start: number = 0) => {
  let dataSource = {
    rowCount: null,
    getRows: (params) => {
      this.refreshData$.next(params);
    }
  };
  this.gridApi.setDatasource(dataSource);
}
```


---
### Center Align column with css
```ts
  this.columnDefs = [
    { headerName: 'name', cellStyle: {textAlign: 'center'} }
  ]
```


---
## Cell
### Cell Event
#### onClick Event
```ts
this.columnDefs = [
  {
    headerName: 'name',
    onCellClicked: this.whenCellClicked,
  }
]

whenCellClicked = (event: CellClickedEvent) => {
  console.log(`event`, event);
}
```

### Cell Button
#### Button call parent component

HTML template
```html
<ag-grid-angular
  #myGrid
  id="myGrid"
  [rowData]="items"
  [context]="context"
>
</ag-grid-angular>
```

Ag Grid Component
```ts
export class MyAgGridComponent implements OnInit, OnDestroy {

  public context - this;

  buttonColumnDef = {
    headerName: 'Button Action',
    cellRenderer: CustomButtonComponent,
  };

}
```

Custom Button Component
```ts

@Component({
  template: `<div><button (click)="callMethod($event)">Call</button></div>`,
})
export class CustomButtonComponent implements ICellRendererAngularComp {

  public params: any;
  private parentCallbackMethod: (data: string) => void;

  agInit = (params: ICellRendererParams): void => {
    this.params = params;
    this.parentCallbackMethod = params.context.parentCallbackMethod;
  }

  public callMethod = (evt: CellClickedEvent) => {
    this.parentCallbackMethod('testing');
  }
}

```


---
## Master and Detail grid
### Change detail grid height
```ts
this.gridOption = {
  detailRowHeight: 555
}
```

