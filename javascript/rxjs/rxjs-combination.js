import { Observable } from 'rxjs';
import { map, filter } from 'rxjs/operators';

const alphabets = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'];
const numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
const alphabets$ = Observable.interval(100).map(x => alphabets[x]).take(13);
const numbers$ = Observable.interval(100).map(x => numbers[x]).take(10);

let concatAll$ = (observableName, inObservable$) => {
  return Observable.Of(Observable.Of(`[----- ${observableName} Start   -----]`), inObservable$, Observable.Of(`[----- ${observableName} End   -----]\n\n\n\n\n`)).concatAll();
}
