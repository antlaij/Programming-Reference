# Angular 2+ Reactive Form Reference

## Table of Contents
  * [Testing API with Mock data](#Testing-API-with-Mock-data)

***

---
### Testing API with Mock data
```ts
describe('MyApiService'), () => {
  let myApiService: MyApiService;
  let httpTestingController: HttpTestingController;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClicentTestingModule],
      providers: [MyApiService]
    });
    myApiService = TestBed.get();
    httpTestingController = TestBed.get(HttpTestingController);
  });

afterEach(() => {
    httpTestingController.verify();
  });

  let mockApiResponse = [{label: '', value: ''}];

  it('test it', () => {
    myApiService.getData().subscribe((res: any) => {
      // Testing the response
      expect(res).toEqual([{label: '', value: ''}]);
    });

    const request = httpTestingController.expectOne('URL_for_the_api');
    // Call the mocking api call from here and it will trigger the subscribe
    request.flush(mockApiResponse);
  });
});
```
