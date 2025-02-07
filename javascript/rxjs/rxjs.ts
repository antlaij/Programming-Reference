
import { map, mergeMap, of, retry, switchMap, throwError, Observable } from "rxjs";
import http from 'http';

// Combine 2 api call into 1 and keep calling the second api until the system reaching the limit
(() => {
  const maxRetry = 10;
  const retryDelay = 3;
  
  /**
   * Submit a request call then keep calling the response api to update the status
   */
  const requestAndWaitForResponse$ = (dataset: any): Observable<any> => {
  
    const payload = { id: 1234, name: 'Peter Walker' };
    let dataId = payload.id;
    let retryCounter = 1;
  
    return http.put('/api/request', payload)
    .pipe(
      switchMap((data) => {
        console. log('requestAndWaitForResponse$ - (dataId)', dataId);
        return http.get(`/api/getdata?id=${dataId}`)
        .pipe(
          mergeMap((res: any) => {
            if( res.status !== "Success" ) {
              console.log(`mergeMap - (retryCounter)`, retryCounter);
              console.log(`mergeMap - (res)`, res);
              if(retryCounter > maxRetry){
                return of(res);
              }
              retryCounter++;
              return throwError(() => `Error!`);
            }
            return of(res);
          }),
          retry({count: maxRetry, delay: retryDelay}),
          map((data) => {
            console.log(`map after retry - (data)`, data);
            data.dataId = dataId;
            return data;
          }),
        );
      })
    )
  }
})



