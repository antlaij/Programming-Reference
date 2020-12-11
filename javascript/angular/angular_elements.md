# Angular Element Reference

## Table of Contents
1. [Generate new angular application](#Generate_new_angular_application)
1. [Add Angular Elements support](#Add_Angular_Elements_support)
1. [Create New Angular Elements application](#Create_New_Angular_Elements_application)
   1. [Generate New Component for project web-components](#Generate_New_Component_for_project_web-components)
1. [Add injector](#Add_injector)
   1. [Pass context with ngTemplateOutlet](#Pass-context-with-ngTemplateOutlet)
   1. [Use HTML tag in variable from component and show in html template](#Use-HTML-tag-in-variable-from-component-and-show-in-html-template)
1. [Styling](#Styling)
   1. [ngClass with Condition](#ngClass-with-Condition)
   1. [ngOnChanges from life cycle hook](#ngOnChanges-from-life-cycle-hook)
1. [Rxjs](#Rxjs)
   1. [throw Error within rxjs pipe](#throw-Error-within-rxjs-pipe)
   1. [Create Unknown number of observable for one subscription](#Create-Unknown-number-of-observable-for-one-subscription)


# Generate new angular application
```cmd
ng new web-components

or

ng g @nrwl/angular:application web-components
```

# Add Angular Elements support
```cmd
ng add @angular/elements
```

---
> ### Create New Angular Elements application
> ### Generate New Component for project web-components
```cmd
ng generate component components/backToTop --project=web-components --style=scss --skipTests=true
```


#### Add injector
#### Open app.module.ts
#### Remove Component from bootstrap then add Component to entryComponents
```ts
@NgModule({
  declarations: [MyWebComponent],
  imports: [BrowserModule],
  providers: [],
  bootstrap: [],
  entryComponents: [MyWebComponent]
})
export class AppModule {
  constructor(private injector: Injector) {
  }

  ngDoBootstrap() {
    const elements: Array<any> = [
      [MyWebComponent, 'back-to-top']
    ];

    for (const [component, name] of elements) {
      const ele = createCustomElement(component, { injector: this.injector });
      customElements.define(name, ele);
    }
  }
}
```


#### Remove Zone.js
#### Open main.ts
#### ngZone: 'noop'
#### Without loading zone.js. Please do not use async pipe in the template, because async is part of the zone.js
```ts
platformBrowserDynamic()
  .bootstrapModule(AppModule, { ngZone: 'noop' })
  .catch(err => console.error(err));
```


###  Before Building the Angular Element, add the following tools
ng add ngx-build-plus --project web-components
ng g ngx-build-plus:wc-polyfill --project web-components
ng g ngx-build-plus:externals --project web-components

or 

### Polyfills for Angular Elements
### Ref: https://www.youtube.com/watch?v=_QU0mpyF7bQ&t=752s
install @webcomponents/webcomponentsjs
###  es5-adapter

### Use Angular Elements in Angular application
#### In the Angular application which using the web component, Add CUSTOM_ELEMENTS_SCHEMA to app module
```ts
schemas: [ CUSTOM_ELEMENTS_SCHEMA ],
```


