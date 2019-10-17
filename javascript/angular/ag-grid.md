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
> ### Reset Server Side data

```ts
this.gridApi.purgeServerSideCache(route);
```

---
> ### Get Row Count

```ts
  get totalNumberOfRows(): number {
    return this.gridApi ? this.gridApi.getDisplayedRowCount() : 0;
  }
```

