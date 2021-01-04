# Angular ag Grid

---
> ### AgGrid - Boolean Cell editor

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
> ### AgGrid - Boolean Cell Renderer

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
> ### AgGrid - Router Link Cell Renderer

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
> ### Reset Server Side data

```ts
this.gridApi.purgeServerSideCache(route);
```

---
> ### Get Displayed Row Count

```ts
  get totalNumberOfRows(): number {
    return this.gridApi ? this.gridApi.getDisplayedRowCount() : 0;
  }
```

---
> ### Get Filtered Row Count

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


> ### Filter
---
#### Hide Filter Icon from floating bar
```ts
public DEFAULT_COL_DEF: ColDef = {
  flotingFilterComponentParams: { suppressFilterButton: true;
};
```


---
> ### Turning On Infinite Scrolling without ag-Grid Enterprise
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
  get totalNumberOfRows(): number {
    return this.gridApi ? this.gridApi.getDisplayedRowCount() : 0;
  }
```

---
> ### Center Align column with css
```ts
  this.columnDefs = [
    { headerName: 'name', cellStyle: {textAlign: 'center'} }
  ]
```

---
> ### Filter by cellRenderer value instead of column value
```ts
{ colId: 'testId', headerName: 'test column', field: 'dataColumn', cellRenderer: 'customRenderer', filterValueGetter: (params) => this.myService.method(params.data.dataColumn) }
```

