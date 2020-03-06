## Make external api with rxjs
```ts

  import { NextFunction, Request, Response } from "express";
  import * as bodyParser from "body-parser";
  import * as request from 'request';
  import { Observable, forkJoin } from 'rxjs';
  import { pluck, map, switchMap } from 'rxjs/operators';

  let express = require('express');
  let router = express.Router();

  router.use(bodyParser.json()); // support json encoded bodies
  router.use(bodyParser.urlencoded({ extended: true })); // support encoded bodies
  router.use((req: Request, res: Response, next: NextFunction) => {
      res.header("Access-Control-Allow-Origin", "*");
      res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
      next();
    });

  /**
   * url: http://localhost:port/sub/
   */
  router.get('/', (req: Request, res: Response) => {
    res.send('/sub/ Root!');
  });

  /**
   * url: http://localhost:port/sub/call/testing
   */
  router.get('/call/:setting', (req: Request, res: Response) => {
    forkJoin(
      getDataFromExternalApi(req.params.setting),
      getDataFromExternalApi(req.params.setting),
    )
    .subscribe(data => {
      res.send(data);
    });
  });


  let getDataFromExternalApi = (setting: string): Observable<any> => {
    let apiLink = `http://myapi.com/${setting}`;
    return new Observable(function subscribe(subscriber) {
      request(
        apiLink,
        { pretty: 'true' },
        (error: any, response: any, body: any) => {
          if (!error && response.statusCode === 200) {
            let dataInJsonObject = JSON.parse(body);
            subscriber.next(dataInJsonObject);
          }
          else {
            subscriber.next(error);
          }
          subscriber.complete();
        }
      );
    })
    .pipe(
      switchMap(responseData => getChildData(responseData)),
    );
  }


  let getChildData = (param: string): Observable<any> => {
    return new Observable(function subscribe(subscriber) {
      request(
        'http://mynewapi.com',
        { pretty: 'true' },
        (error: any, response: any, body: any) => {
          if (!error && response.statusCode === 200) {
            let dataInJsonObject = JSON.parse(body);
            subscriber.next({data: dataInJsonObject});
          }
          else {
            subscriber.next(error);
          }
          subscriber.complete();
        }
      );
    });
  }

  module.exports = router;

```
