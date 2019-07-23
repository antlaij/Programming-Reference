# Angular 2+ Reference

---
> ### Debug angular 2+

```js
var sc = ng.probe($0).componentInstance;
```

---
> ### Add disabled to a button or input field

```html
<button id="myButton" type="button" label="Click" [attr.disabled]="disabled?'disabled':null"></button>
```

---
> ### ngClass with Condition

```html
<div [ngClass]="{'success': response?.Success, 'error': !response?.success}"></div>
```

---
> ### ngOnChanges from life cycle hook

```ts
ngOnChanges(changes: SimpleChanges) {
  if (cahnges.myValue) {
  }
}
```

---
> ### Create Function Mapping from service for component

```ts
mappedFunctionName: (arg_01: string, arg: number) => boolean;

// Setup mapping in constructor
constructor( private myService: MyService ) {
  this.mappedFunctionName = myService.targetFunctionName;
}
```

---
> ### Put Condition in the switch case
>> Set ngSwitch to true
>> put expression in ngSwitchCase

```html
<ng-container [ngSwitch]="true">
  <ng-container *ngSwitchCase="expression_1">
    Content 1
  </ng-container>
  <ng-container *ngSwitchCase="expression_2">
    Content 2
  </ng-container>
  <ng-container *ngSwitchDefault>
    Default Content
  </ng-container>
</ng-container>
  ```

---
> ### Pass context with ngTemplateOutlet

```html
<ng-container *ngTemplateOutlet="templateOutleName; context: {item: variableName}"></ng-container>

<ng-template let-variableNameUseInTemplate="item" #templateOutleName>
</ng-template>



<ng-template
  [ngTemplateOutlet]="templateOutleName"
  [ngTemplateOutletContent]="{
    $implicit: 'String from $implicit',
    myNextProperty: 'Next Property'
  }"
>
</ng-template>

<ng-template #templateOutleName let-implicit let-variableNameUseInTemplate="myNextProperty">
  <div>{{implicit}}</div>
  <div>{{variableNameUseInTemplate}}</div>
</ng-template>
```

---
> ### Use ngTemplateOutlet to select template based on condition

```html
<ng-container *ngTemplateOutlet="conditionGoseHere ? trueTemplate : falseTemplate; context: { $implicit: myVariable }">
</ng-container>

<ng-template #trueTemplate let-myVariable>True: {{myVariable}}</ng-template>

<ng-template #falseTemplate let-myVariable>False: {{myVariable}}</ng-template>
```

---
> ### Track By Async Element

```html
  <div *ngFor="let item of items | async; trackby: trackByUniqueKey " ></div>
```

```ts
class MyComponent {
  trackByUniqueKey = (idx, element) => element.uniqueKey;
}
```

---
> ### Detect window resize

```ts
@HostListener('window:resize', ['$event'])
onResize(event) {
  let screenWidth = document.getElementById("header").offsetWidth;
}
```

---
> ### Component State Handle

```html
<ng-container [ngSwitch]="componentState">
  <ng-container *ngSwitchCase="componentStateEnum.standby">
    <ng-container *ngTemplateOutlet="componentInProgress"></ng-container>
  </ng-container>
  <ng-container *ngSwitchCase="componentStateEnum.inProgress">
    <ng-container *ngTemplateOutlet="componentInProgress"></ng-container>
  </ng-container>
  <ng-container *ngSwitchCase="componentStateEnum.completed">
    <ng-container *ngTemplateOutlet="componentCompleted"></ng-container>
  </ng-container>
  <ng-container *ngSwitchCase="componentStateEnum.error">
    <ng-container *ngTemplateOutlet="componentError"></ng-container>
  </ng-container>
</ng-container>


<ng-template #componentInProgress>
  <div>
    {{statusMessage}}
  </div>
</ng-template>

<ng-template #componentError>
  <div>No data found</div>
</ng-template>

<ng-template #componentCompleted>
</ng-template>
```

```ts
export enum componentStateEnum {
  standby,
  confirming,
  inProgress,
  error,
  completed
}
```

---
> ### Rxjs - throw Error within the pipe

```ts
myObservable$
.pipe(
  // If saving with error then throw an error
  mergeMap((data: any) => (data === 'is not right') ? throwError(data) : of(data))
)
.subscribe(
  this.whenSuccessful,
  this.whenFailed
);
```

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
> ### AgGrid - Boolean Cell editor

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

