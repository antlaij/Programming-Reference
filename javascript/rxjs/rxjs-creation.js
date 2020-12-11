
const { interval, of, from } = require('rxjs');
const { map, take, concatAll } = require('rxjs/operators');

const alphabets = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'];
const numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
const alphabetsUpper = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];

const alphabets$ = interval(200).pipe(map(x => alphabets[x]),take(13));
/*
Marble Diagram:
|-a-b-c-d-e-f-g-h-i-j-k-l-m-n-o-p-q-r-s-t-u-v-w-x-y-z|
*/

const numbers$ = interval(300).pipe(map(x => numbers[x]),take(10));
/*
Marble Diagram:
|--0--1--2--3--4--5--6--7--8--9|
*/

const alphabetsUpper$ = interval(500).pipe(map(x => alphabetsUpper[x]),take(13));
/*
Marble Diagram:
|----A----B----C----D----E----F----G----H----I----J----K----L----M----N----O----P----Q----R----S----T----U----V----W----X----Y----Z|
*/


// of(1,2,3,4).subscribe(x => console.log(x));

// from(alphabets).subscribe(x => console.log(x));
from(alphabets$).subscribe(x => console.log(x));
