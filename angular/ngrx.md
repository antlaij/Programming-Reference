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
  LOAD_DATA_SUCCESSFUL = '[Process Namespace] LOAD_DATA_SUCCESSFUL',
  LOAD_DATA_FAIL = '[Process Namespace] LOAD_DATA_FAIL',
}


export class LoadData implements Action {
  readonly type = ReduxActionTypes.LOAD_DATA;
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
   * listening to "LOAD_DATA" Action
   */
  @Effect()
  loadDataFromDb$ = this.actions$.ofType(
    ReduxStore.ReduxActionTypes.LOAD_DATA
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
```

