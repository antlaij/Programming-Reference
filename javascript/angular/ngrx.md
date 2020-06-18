# NgRx

---

> ### Get Store data from effect

```ts
myData$ = this.action$.ofType( myAction.Type )
.pipe(
  map((action: store.action) => action.payload),
  withLatestFrom(this.store.select(getData))
  switchMap(([lastSelected, allData]) => {
    return of(new store.action)
  })
);
```

---

> ### Full Example

```ts
/**
 * In Action File "my.actions.ts"
 */
import { Action } from '@ngrx/store';

export enum ReduxActionTypes {
  LOAD_DATA = '[Process Namespace] LOAD_DATA',
  OTHER_ACTION = '[Process Namespace] OTHER_ACTION',
  LOAD_DATA_SUCCESSFUL = '[Process Namespace] LOAD_DATA_SUCCESSFUL',
  LOAD_DATA_FAIL = '[Process Namespace] LOAD_DATA_FAIL',
}


export class LoadData implements Action {
  readonly type = ReduxActionTypes.LOAD_DATA;
  constructor(public payload: { processId: number }) {}
}

export class OtherAction implements Action {
  readonly type = ReduxActionTypes.OTHER_ACTION;
  constructor(public payload: { processId: number }) {}
}

export class LoadDataSuccessful implements Action {
  readonly type = ReduxActionTypes.LOAD_DATA_SUCCESSFUL;
  constructor(public payload: any) {}
}

export class LoadDataFail implements Action {
  readonly type = ReduxActionTypes.LOAD_DATA_FAIL;
  constructor(public payload: any) {}
}


export type MyProcessActions = LoadData
  | OtherAction
  | LoadDataSuccessful
  | LoadDataFail;


/**
 * In Reducer file
 */

import * as fromActions from '../actions/my.actions';

export interface ProcessState {
  processData: any;
}

export interface ProcessesState {
  [key: number]: ProcessState
}

export const initialState: ProcessesState = {};

export function reducer(
  state = initialState,
  action: fromActions.MyProcessActions
): ProcessesState {
  switch (action.type) {

    case fromActions.ReduxActionTypes.LOAD_DATA: {
      return { ...state };
    }

    case fromActions.ReduxActionTypes.LOAD_DATA_SUCCESSFUL: {
      let [processId, payloadformData] = action.payload;
      if(!isProcessExist(state, processId)) {
        return { ...state };
      }
      const processData: any = {
        ...state[processId].processData,
        newProperties: 'testing'
      };
      return { ...state,
        [processId]: {
          ...state[processId],
          processData,
        }
      };
    }

    case fromActions.ReduxActionTypes.LOAD_DATA_FAIL: {
      console.error('Error: LOAD_DATA_FAIL', action.payload);
      return { ...state };
    }

    default:
      return { ...state };
  }
}

let isProcessExist: (state: ProcessesState, processId: number) => boolean = (state: ProcessesState, processId: number) => {
  return state.hasOwnProperty(processId);
};

export const getAllProcesses = (state: ProcessesState) => state;




/**
 * In Selector file
 */
import { createSelector } from '@ngrx/store';
import * as fromReducers from '../reducers';


export const getProcessState = createSelector(
  fromReducers.getProcessState,
  (state: ProcessState) => state
);

export const getProcessDataProcessById = createSelector(
  getProcessState,
  (state, props) => {
    let currentProcess: ProcessState = state.process[props.processId];
    if(currentProcess) {
      return currentProcess.processData;
    }
    return null;
  }
);


/**
 * In Effect file
 */
import * as ProcessSelector from '../selectors/my.selector';
  /**
   * listening to multiple Action
   * listening to "LOAD_DATA" and "OTHER_ACTION" Action
   */
  @Effect()
  loadDataFromDb$ = this.actions$.ofType(
    ReduxStore.ReduxActionTypes.LOAD_DATA,
    ReduxStore.ReduxActionTypes.OTHER_ACTION,
    )
    .pipe(
      switchMap((action: any) => this.store.select(ProcessSelector.getProcessDataProcessById, { processId: action.payload.processId })
      .pipe(
        take(1),
        map(data => ({ processId: action.payload.processId, data: data }))
      )),
      switchMap(data => this.dataService.insertLogEntry({ newData: data})
      .pipe(
        map(data => ({ processId: data.processId, data: data })),
        map(result => new ReduxStore.LoadDataSuccessful(result)),
        catchError(error => {
          // Unknown Error
          return of(new ReduxStore.LoadDataFail({processId: data.processId, error: error}));
        }),
      )),
      catchError(error => {
        return of(new ReduxStore.LoadDataFail(error));
      })
    );


/**
 * Dispatch Action from component
 */
  /**
   * dispatch action by create a new object
   */
  this.store.dispatch(new MyProcessActions.LoadData({data: {}}));
  /**
   * dispatch action by object of type and payload
   */
  this.store.dispatch({ TYPE: ReduxActionTypes.LOAD_DATA, payload: {myData: []}});
```

---

> ### When dispatch an action then got the following error in console
>
> ERROR TypeError: app_subscriber_shared_stores_subscription_process_store**WEBPACK_IMPORTED_MODULE_9**.UpdateSubscrpitions is not a constructor

Solution: just need to restart ng serve then the error will goes away
