# Angular 2+ Library

## Table of Contents
1. [Setup Angular Library with testing application](#Setup-Angular-Library-with-testing-application)
   1. [Create Empty Workspace](#Create-Empty-Workspace)
   1. [Generate library](#Generate-library)
   1. [Generate Test Application](#Generate-Test-Application)
   1. [Building, Serving, and Testing](#Building,-Serving,-and-Testing)
   1. [Packaging Our Library](#Packaging-Our-Library)
   1. [Install Library from tgz file](#Install-Library-from-tgz-file)
1. [Add routing for a library](#Add-routing-for-a-library)


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
import { LibModule } from '@mylibraryreference/nameOfThePackage';

const appRoutes: Routes = [
    { path: '', redirectTo: '/landing', pathMatch: 'full' },
    {
        path: '',
        children: [
            {
                path: 'landing',
                loadChildren: '../app.module#LandingModule'
            },
            // This works in dev
            {
                path: 'eqs',
                loadChildren: () => LibModule
            },
            // This for AOT build
            {
                path: 'mylibraryroute',
                loadChildren: '@mylibraryreference/nameOfThePackage#libraryModule'
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
