
const { interval, of, from, zip } = require('rxjs');
const { map, take, groupBy, mergeMap, toArray } = require('rxjs/operators');

const counterObject = [
  { name: 'name 1', prop01Name: 'a', prop02Name: 'a' },
  { name: 'name 1', prop01Name: 'e', prop02Name: 'b' },
  { name: 'name 1', prop01Name: 'e', prop02Name: 'c' },
  { name: 'name 1', prop01Name: 'b', prop02Name: 'c' },
  { name: 'name 2', prop01Name: 'b', prop02Name: 'a' },
  { name: 'name 2', prop01Name: 'f', prop02Name: 'a' },
  { name: 'name 3', prop01Name: 'c', prop02Name: 'b' },
  { name: 'name 3', prop01Name: 'c', prop02Name: 'b' },
  { name: 'name 3', prop01Name: 'g', prop02Name: 'c' },
  { name: 'name 3', prop01Name: 'g', prop02Name: 'c' },
  { name: 'name 3', prop01Name: 'g', prop02Name: 'e' },
  { name: 'name 4', prop01Name: 'd', prop02Name: 'a' }
]

const counterObject$ = interval(100).pipe(map(x => counterObject[x]),take(12));


from(counterObject$)
.pipe(
  groupBy(item => item.name),
  mergeMap(group => zip(of(group.key), group.pipe(toArray()))),
  toArray(),
)
.subscribe(x => console.log(x));
