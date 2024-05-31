# Angular 2+ Reference

## Table of Contents
1. [Debug angular 2 plus](#Debug-angular-2-plus)
1. [Add disabled to a button or input field](#Add-disabled-to-a-button-or-input-field)
1. [Load Data before application start by APP_INITIALIZER](#Load-Data-before-application-start-by-APP_INITIALIZER)
1. [Routing](#Routing)
   1. [routerLink with queryParams](#routerLink-with-queryParams)
1. [Directives](#Directives)
   1. [Custom DIRECTIVES](#Custom-DIRECTIVES)
   1. [Custom STRUCTURAL DIRECTIVES](#Custom-STRUCTURAL-DIRECTIVES)
1. [Pipe](#Pipe)
   1. [Use default pipe in typescript code](#Use-default-pipe-in-typescript-code)
1. [Services](#Services)
   1. [Inject Service to a Const](#Inject-Service-to-a-Const)
1. [Template](#Template)
   1. [Put Condition in the switch case](#Put-Condition-in-the-switch-case)
   1. [Pass context with ngTemplateOutlet](#Pass-context-with-ngTemplateOutlet)
   1. [Use HTML tag in variable from component and show in html template](#Use-HTML-tag-in-variable-from-component-and-show-in-html-template)
1. [Styling](#Styling)
   1. [ngClass with Condition](#ngClass-with-Condition)
   1. [ngOnChanges from life cycle hook](#ngOnChanges-from-life-cycle-hook)
1. [Rxjs](#Rxjs)
   1. [throw Error within rxjs pipe](#throw-Error-within-rxjs-pipe)
   1. [Create Unknown number of observable for one subscription](#Create-Unknown-number-of-observable-for-one-subscription)


---
### Debug angular 2 plus

```js
var sc = ng.probe($0).componentInstance;
```

### Debug angular 2 plus with IVY
```js
var com = ng.getComponent($0);
```

---
### Add disabled attribute to a button or input field

```html
<button id="myButton" type="button" label="Click" [attr.disabled]="disabled?'disabled':null"></button>
```
### Template

---
### Put Condition in the switch case
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
### Pass context with ngTemplateOutlet

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
### Use HTML tag in variable from component and show in html template

```html
<div [innerHTML]="myHtmlStringWithTag"></div>
<span [innerHTML]="myHtmlStringWithTag"></span>
```

```ts
public myHtmlStringWithTag: string = '<span class="">this is a test</span>';
public myClass = 'testCss';
this.myHtmlStringWithTag: string = `<span class="${myClass}">this is a test</span>`;
```

---
### Use ngTemplateOutlet to select template based on condition

```html
<ng-container *ngTemplateOutlet="conditionGoseHere ? trueTemplate : falseTemplate; context: { $implicit: myVariable }">
</ng-container>

<ng-template #trueTemplate let-myVariable>True: {{myVariable}}</ng-template>

<ng-template #falseTemplate let-myVariable>False: {{myVariable}}</ng-template>
```

### Styling
---
### ngClass with Condition
```html
<div [ngClass]="{'success': response?.Success, 'error': !response?.success}"></div>
```

---
### ngOnChanges from life cycle hook

```ts
ngOnChanges(changes: SimpleChanges) {
  if (cahnges.myValue) {
  }
}
```

---
### Create Function pointer from component to service

```ts
mappedFunctionName: (arg_01: string, arg: number) => boolean;

// Setup mapping in constructor
constructor( private myService: MyService ) {
  this.mappedFunctionName = myService.targetFunctionName;
}
```

---
### Track By Async Element

```html
  <div *ngFor="let item of items | async; trackby: trackByUniqueKey " ></div>
```

```ts
class MyComponent {
  trackByUniqueKey = (idx, element) => element.uniqueKey;
}
```

---
### Detect window resize

```ts
@HostListener('window:resize', ['$event'])
onResize(event) {
  let screenWidth = document.getElementById("header").offsetWidth;
}
```

---
### Component State Handling

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

```ts
export class testingComponent implements OnInit, OnDestroy {
  public componentStateEnum: any;
  public componentState: ComponentStateEnum;

  ngOnInit() {
    this.componentStateEnum = ComponentStateEnum;
    this.componentState = ComponentStateEnum.standby;
 }

}
```

### Rxjs
---
> #### throw Error within rxjs pipe

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

---
### Model
#### Inject Service to a Model class
```ts
import { MyService, AnotherService } from "../services/local.service";

export class MyModelClass {

  private _changeEntities: { [key: string]: ChangeSetType };
  private myService: MyService;
  private anotherService: AnotherService;

  constructor() {
    this._changeEntities = {};
    const injector = Injector.create([
      { provide: MyService, deps: [] },
      { provide: AnotherService, deps: [] }
    ]);
    this.myService = injector.get(MyService);
    this.anotherService = injector.get(AnotherService);
  }
}
```

---
### Services
---
#### Inject Service to a Const
```ts
import { Injector } from '@angular/core';
import { MyService, AnotherService } from "../services/local.service";

const injector = Injector.create([
  { provide: MyService, deps: [] },
  { provide: AnotherService, deps: [] }
]);

let myService = injector.get(MyService);
let anotherService = injector.get(AnotherService);

```

### Directives
---
### Custom DIRECTIVES
#### Scrolling Check
```ts
import { Directive, Output, HostListener, EventEmitter, ElementRef, AfterViewInit } from '@angular/core';

@Directive({
  selector: '[scrollTracker]'
})
export class ScrollTrackerDirective implements AfterViewInit {

  /**
   * Emit data back to parent
   */
  @Output() onScrolledToBottom: EventEmitter<boolean> = new EventEmitter();

  /**
   * Listening to the user scroll event and passing the target element
   * @param targetElement
   */
  @HostListener('scroll', ['$event.target'])
  onScroll(targetElement: Element) {
    /**
     * Calculate the scrollable height on the target element
     */
    let scrollableHeight = targetElement.scrollHeight - targetElement.clientHeight;
    /**
     * When scrollable height equals scroll top that means user scrolled to the end
     * then emit true back to the user
     */
    if (targetElement.scrollTop >= scrollableHeight) {
      this.onScrolledToBottom.emit(true);
    }
  }

  constructor(private ele: ElementRef) {
    this.onScrolledToBottom.emit(false);
   }

   ngAfterViewInit(): void {
     /**
      * If scroll height and client height are the same that means there is no scroll bar needed
      * then return a flag to the parent
      */
    this.onScrolledToBottom.emit(this.ele.nativeElement.scrollHeight === this.ele.nativeElement.clientHeight);
  }
}
```

---
### Custom STRUCTURAL DIRECTIVES
#### Authorize directive 
[Link from Angular Docs](https://v2.angular.io/docs/ts/latest/guide/structural-directives.html)
```ts
import { Directive, Input, TemplateRef, ViewContainerRef } from '@angular/core';

/**
 * Add the template content to the DOM unless the condition is true.
 */
@Directive({ selector: '[authorize]'})
export class UnlessDirective {
  private hasView = false;

  constructor(
    private templateRef: TemplateRef<any>,
    private viewContainer: ViewContainerRef) { }

  @Input() set myUnless(condition: boolean) {
    if (!condition && !this.hasView) {
      this.showComponent();
    } else if (condition && this.hasView) {
      this.hideComponent();
    }
  }

  /**
  * If user is not authorized then hide all the component
  */
  private hideComponent(): void {
    this.viewContainer.clear();
    this.hasView = false;
  }

  private showComponent(): void {
    this.viewContainer.createEmbeddedView(this.templateRef);
    this.hasView = true;
  }

}
```
```html
<p *authorize="condition">
  (A) This paragraph is displayed because the condition is false.
</p>

<p *authorize="!condition">
  (B) Although the condition is true,
  this paragraph is displayed because myUnless is set to false.
</p>
```


---
### Load Data before application start by APP_INITIALIZER
#### app.module.ts
```ts
import { APP_INITIALIZER } from '@angular/core';

@NgModule({
  declarations: [],
  imports: [],
  providers: [
    provide: APP_INITIALIZER,
    useFactory: (appConfig: AppConigService) => {
      return () => {
        return appConfig.loadAppData();
      }
    }
  ],bootstrap: [ AppComponent ]
})
export class AppModule {
}
```
#### AppConig.service.ts
```ts
import  { Injectable } form '@angular/core';

private appConfigData = new Map<string, boolean> ();

@Injectable({ providedIn: 'root' })
export class AppConfigService {

  constructor(private httpClient: HttpClient) {
    // Set default values
    this.appConfigData
    .set('test', false)
    .set('test_II', true);
  }

  pulib loadAppData = (): Promise<any> => {
    return this.httpClient.get<any>('url')
    .tap(data => {
      this.appConfigData.set('test_III', false);
    }),
  }
}
```

### Component
---
> #### Return public API to the parent component when child after view init
```ts
@Component({selector: 'my-cmp', template: `...`})
class MyComponent implements AfterViewInit {

  @Output()
  public onReady = new EventEmitter<apiType>();

  public publicApi: apiType = {
    componentFunction: this.myFunction.bind(this);
  }

ngAfterViewInit() {
    // ...
    onReady.emit(this.publicApi);
  }
}

```

### Pipe
---
> #### Use default pipe in typescript code
>> ##### DatePipe
```ts
// Create new variable
private datePipe;

constructor(@Inject(LOCAL_ID)  private locale: string) {
  this.datePipe = new DatePipe(locale);
}

public test = (): string => {
  return this.datePipe.transform(new Date(), 'short'));
}
```

### Routing
---
> #### routerLink with queryParams
```html
<a [routerLink]="['/order']" [queryParams]="{ orderNumber: 123456}">
  Products
</a>
```

> #### Call a function on every route
```html
<router-outlet (activate)="onRouteChanged()"></router-outlet>
```
```ts
onRouteChanged = () => {
  window.scrollTo(0,0);
}
```

### Content Projection
---
> #### ng-content
```html
<my-component>
  <div>testing</div>
</my-conponent>
```
---
> #### Multi slot content projection
##### Parent component
```html
<my-component>
  <div class="class-selector">testing</div>
  <div class="class-selector-01">testing 01</div>
  <div >No selector content</div>
</my-conponent>
```
##### my-component component
```html
  <div>
    <ng-content selet=".class-selector"></ng-content>
    <div>other content in the child</div>
    <ng-content selet=".class-selector-01"></ng-content>
    <div>Eventhing not match will show below</div>
    <ng-content></ng-content>
  </div>
```




