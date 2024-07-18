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

