
const { interval, of, from } = require('rxjs');

/**
 * rxjs of
 */
of(
  { channel: 'radio2', programName: 'curiouserandcuriouser', limit: 30 },
  { channel: 'radio2', programName: 'weekendlover', limit: 30 },
  { channel: 'radio1', programName: 'forensic_institute', limit: 30 },
  { channel: 'radio2', programName: 'freeaswind', limit: 30 },
  { channel: 'radio2', programName: 'Free_as_the_wind', limit: 30 },
  { channel: 'radio1', programName: 'healthpedia', limit: 30 },
  { channel: 'radio2', programName: 'reunion', limit: 30 },
  { channel: 'radio1', programName: 'hkfootpath', limit: 30 },
  { channel: 'radio2', programName: 'SeeSaw', limit: 30 },
  { channel: 'radio1', programName: 'walk_along', limit: 30 },
).subscribe((x) => {
  console.log('x', x.channel);
});
