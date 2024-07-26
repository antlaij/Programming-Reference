# Angular 18+ Reference
## Table of Contents
  1. [Configuration](#Configuration)
      1. [Change default port number when serving the application](#Change-default-port-number-when-serving-the-application)
          1. [Add port number in angular.json](#Add-port-number-in-angular.json)
      1. [Define prefix in component. Error will show in IDE](#Define-prefix-in-component.-Error-will-show-in-IDE)
          1. [Add prefix in project.json](#Add-prefix-in-project.json)
          1. [Or add prefix in .eslintrc.json](#Or-add-prefix-in-.eslintrc.json)
  1. [Routing](#Routing)
      1. [Lazy loading](#Lazy-loading)
          1. [For Child route](#For-Child-route)
              1. [Use loadChildren](#Use-loadChildren)
              1. [Child routes](#Child-routes)
          1. [For Child component](#For-Child-component)
              1. [Use loadComponent. **This only works for Standalone component**](#Use-loadComponent.-**This-only-works-for-Standalone-component**)
      1. [Use @Input to Read Angular Route Parameters](#Use-@Input-to-Read-Angular-Route-Parameters)
          1. [To read the value from the route parameter](#To-read-the-value-from-the-route-parameter)
              1. [For standalone bootstrapping](#For-standalone-bootstrapping)
          1. [To enable this function](#To-enable-this-function)
              1. [For standalone bootstrapping - use: withComponentInputBinding](#For-standalone-bootstrapping---use:-withComponentInputBinding)
              1. [For classic bootstrapping - set bindToComponentInputs to true](#For-classic-bootstrapping---set-bindToComponentInputs-to-true)
  1. [Template](#Template)
      1. [Declare Variables in Templates - V18.1](#Declare-Variables-in-Templates---V18.1)
          1. [@let operator](#@let-operator)
      1. [Built-in control flow](#Built-in-control-flow)
          1. [@if block conditionals](#@if-block-conditionals)
          1. [@for block - repeaters](#@for-block---repeaters)
              1. [With empty block](#With-empty-block)
              1. [contextual variables](#contextual-variables)
          1. [@switch block - selection](#@switch-block---selection)
  1. [Signals](#Signals)
      1. [Signal base input function](#Signal-base-input-function)
          1. [Passing signal to a component](#Passing-signal-to-a-component)
          1. [Getting input signal from a parent component](#Getting-input-signal-from-a-parent-component)
          1. [Using input signal from a component](#Using-input-signal-from-a-component)
  1. [Service](#Service)
      1. [Injecting Services](#Injecting-Services)
          1. [Multiple ways to providing a Service](#Multiple-ways-to-providing-a-Service)
              1. [Most Common way to provide in root](#Most-Common-way-to-provide-in-root)
              1. [provide in root component](#provide-in-root-component)
              1. [provide in a component level by Elementinjector](#provide-in-a-component-level-by-Elementinjector)
          1. [Injection Token](#Injection-Token)
              1. [useClass - this is the default](#useClass---this-is-the-default)
                  1. [Usage with inject function](#Usage-with-inject-function)
                  1. [Usage in constructor by @Inject decorator](#Usage-in-constructor-by-@Inject-decorator)
              1. [Provide a non class value using custom provider by useValue](#Provide-a-non-class-value-using-custom-provider-by-useValue)
                  1. [Setup the provider](#Setup-the-provider)
                  1. [inject custom provider](#inject-custom-provider)

***
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

## Routing
### Lazy loading
#### For Child route
##### Use loadChildren
```ts
export const routes: Routes = [
  { path: 'dashboard', component: DashboardComponent },
  {
    path: 'products',
    loadChildren: () => import('./products/product.routes').then(r => r.PRODUCT_ROUTES)
  },
];
```
##### Child routes
```ts
export const PRODUCT_ROUTES: Routes = [
  { path: '', component: ProductListComponent },
  {
      path: ':id',
      canActivate: [ProductDetailGuard],
      component: ProductDetailComponent
  }
];
```
#### For Child component
##### Use loadComponent. **This only works for Standalone component**
```ts
export const routes: Routes = [
  { path: 'dashboard', component: DashboardComponent },
  { 
    path: 'about', 
    loadComponent: () => import('./about/about.component').then(c => c.AboutComponent)
  },
];
```

### Use @Input to Read Angular Route Parameters
#### To read the value from the route parameter
##### For standalone bootstrapping
```ts
@Input() id = '';
// OR
@Input('id') productId = '';

ngOnInit(): void {
  console.log(this.productId);
}
```
#### To enable this function
##### For standalone bootstrapping - use: withComponentInputBinding
```ts
export const appConfig: ApplicationConfig = {
  providers: [provideRouter([
    { path: 'dashboard', component: DashboardComponent },
    {
        path: ':id',
        canActivate: [ProductDetailGuard],
        component: ProductDetailComponent
    }
    { path: '', redirectTo: "dashboard", pathMatch: "full" },
  ], withComponentInputBinding())],
};
```
##### For classic bootstrapping - set bindToComponentInputs to true
```ts
@NgModule({
  imports: [RouterModule.forRoot([
    { path: 'dashboard', component: DashboardComponent },
    {
        path: ':id',
        canActivate: [ProductDetailGuard],
        component: ProductDetailComponent
    }
    { path: '', redirectTo: "dashboard", pathMatch: "full" },
  ], { relativeLinkResolution: 'legacy', bindToComponentInputs: true })],
  exports: [RouterModule]
})
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

---

### Built-in control flow
#### @if block conditionals
```ts
@if (a > b) {
  {{a}} is greater than {{b}}
} @else if (b > a) {
  {{a}} is less than {{b}}
} @else {
  {{a}} is equal to {{b}}
}
```
#### @for block - repeaters
##### With empty block
```ts
@for (item of items; track item.name) {
  <li> {{ item.name }}</li>
} @empty {
  <li> There are no items.</li>
}
```
##### contextual variables
[Reference Link:](https://v17.angular.io/guide/control_flow#index-and-other-contextual-variables)
|VARIABLE|MEANING|
|---------|:-------|
|$count |	Number of items in a collection iterated over |
|$index |	Index of the current row |
|$first |	Whether the current row is the first row |
|$last  |	Whether the current row is the last row |
|$even  |	Whether the current row index is even |
|$odd   |	Whether the current row index is odd |
```ts
@for (item of items; track item.id; let idx = $index, e = $even) {
  Item #{{ idx+1 }}: {{ item.name }}
}
```
#### @switch block - selection
```ts
@switch (condition) {
  @case (caseA) {
    Case A.
  }
  @case (caseB) {
    Case B.
  }
  @default {
    Default case.
  }
}
```

---

## Signals
### Signal base input function
#### Passing signal to a component
```html
<myComponent [name]="name()" [age]="age()"></myComponent>
```
#### Getting input signal from a parent component
```ts
export class myComponent {
  name = input.required<string>();
  age = input.required<number>();
}
```
#### Using input signal from a component
```html
<div>{{name()}}</div>
<div>{{age()}}</div>
```

---

## Service
### Injecting Services
#### Multiple ways to providing a Service
##### Most Common way to provide in root

This will creata a singleton on this service for the whole application with angular tree shaking

```ts
@Injectable({
  providedIn: 'root'
})
export class MyService {
}
```

##### provide in root component

This will creata a singleton on this service for the whole application without tree shaking

```ts
bootstrapApplication(AppComponent, {
  providers: [MyService],
}).catch((err) =>
  console.error(err)
);
```

##### provide in a component level by Elementinjector
**[ This will not work on services, because service will not reach out the Elementinjector ]**

This will creata a new instant on every copy of this component and this is also available in all children

```ts
@Component({
  standalone: true,
  imports: [],
  selector: 'my-component',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss'],
  providers: [MyService],
})
export class AppComponent implements OnInit {
```

#### Injection Token
##### useClass - this is the default

```ts
bootstrapApplication(AppComponent, {
  providers: [MyService],
}).catch((err) =>
  console.error(err)
);
```

This is the long form of the above code

```ts
import { InjectionToken } from '@angular/core';
import { MyService } from './app/serices/my.service';

export const MyServiceToken = new InjectionToken<MyService>('my-service-token');

bootstrapApplication(AppComponent, {
  providers: [ { provide: MyServiceToken, useClass: MyService } ],
}).catch((err) =>
  console.error(err)
);
```

###### Usage with inject function

```ts
@Component({
  standalone: true,
  imports: [],
  selector: 'my-component',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss'],
})
export class MyComponent implements OnInit {
  authService = inject(MyServiceToken);
}
```

###### Usage in constructor by @Inject decorator

```ts
export class MyComponent implements OnInit {
  authService = inject(MyServiceToken);
  constructor(@Inject(MyServiceToken) private myService: MyService) {}
}
```

##### Provide a non class value using custom provider by useValue
###### Setup the provider
```ts
import { InjectionToken, Provider } from '@angular/core';

export type TaskStatus = 'OPEN' | 'IN_PROGRESS' | 'DONE';

type TaskStatusOptions = {
  value: 'open' | 'in-progress' | 'done';
  taskStatus: TaskStatus;
  text: string;
}[];

export const TASK_STATUS_OPTIONS = new InjectionToken<TaskStatusOptions>('task-status-options');

export const TaskStatusOptions: TaskStatusOptions = [
  { value: 'open', taskStatus: 'OPEN', text: 'Open', },
  { value: 'in-progress', taskStatus: 'IN_PROGRESS', text: 'In-Progress', },
  { value: 'done', taskStatus: 'DONE', text: 'Completed', },
];

export const taskStatusOptionsProvider: Provider = { provide: TASK_STATUS_OPTIONS, useValue: TaskStatusOptions };
```

###### inject custom provider

```ts
import { Component, computed, inject, signal } from '@angular/core';

import { TASK_STATUS_OPTIONS, taskStatusOptionsProvider } from '../task.model';

@Component({
  providers: [taskStatusOptionsProvider]
})
export class TasksListComponent {
  taskStatusOptions = inject(TASK_STATUS_OPTIONS);
}
```


