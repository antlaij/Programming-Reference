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
> ### Setup Angular Library with testing application

#### Create Empty Workspace
```cmd
ng new ng-module-lib --create-application=false
```

#### Generate library
```cmd
cd ng-module-lib
ng generate library module-lib --prefix=lib
```
#### Generate Test Application
```cmd
ng generate application module-lib-tester
```

#### Building, Serving, and Testing
```cmd
ng build module-lib
ng build module-lib-tester --prod
```
#### Packaging Our Library 
```cmd
cd dist/module-lib
npm pack
```
#### Install Library from tgz file
```cmd
npm install ./dist/module-lib/module-lib-0.0.1.tgz
```

---
> ### Add routing for a library
```ts
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

const appRoutes: Routes = [
    { path: '', redirectTo: '/landing', pathMatch: 'full' },
    {
        path: '',
        children: [
            {
                path: 'landing',
                loadChildren: '../app.module#LandingModule'
            },
            {
                path: 'eqs',
                loadChildren: () => LibModule
            },
        ]
    },
];

@NgModule({
    imports: [
        RouterModule.forRoot()
    ],
    exports: [
        RouterModule
    ],
    providers: [
    ]
})
export class AppRoutingModule { }
```
#### Library routing sample
```ts
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Routes, RouterModule } from '@angular/router';

import { landingComponent } from './landing.component';
import { DefaultComponent } from './Default.component';
import { AboutComponent } from './about.component';

export const libraryRoutes: Routes = [
  {
    path: 'landing',
    component: landingComponent,
    children: [
      {
        path: '',
        redirectTo: 'default',
        pathMatch: 'full'
      },
      {
        path: 'default',
        component: DefaultComponent,
      },
      {
        path: 'about',
        component: AboutComponent,
      },
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(libraryRoutes)],
  exports: [RouterModule]
})
export class LibraryRoutingModule {}
```

#### Create Unknown number of observable for one subscription
```ts

    let listOfObservables: Observable<any>[] = [];
    listOfObservables.push(this.http.get<any>('url1'));
    listOfObservables.push(this.http.get<any>('url2'));
    listOfObservables.push(this.http.get<any>('url3'));
    listOfObservables.push(this.http.get<any>('url4'));
    listOfObservables.push(this.http.get<any>('url5'));

    let allObservable$ = Observable.forkJoin(...listOfObservables);
    allObservable$
    .pipe(
      takeUntil(this.ngUnsubscribe)
    )
    .subscribe(
      this.whenAllObservablesSuccessful,
      this.whenAllObservablesFail,
      this.whenAllObservablesCompleted
    );
```

#### Access multiple html elements within ngFor
```html
<div *ngFor="let item of items">
  <div #itemList>{{item}}</div>
</div>
```
```ts
@ViewChildren('itemList') itemList: QueryList<ElementRef>;

ngAfterViewChecked() {
  this.itemList.forEach(ele => {
    ele.nativeElement.scrollTop = ele.nativeElement.scrollHeight;
  });
  }
```

