# Module: child_process
## Read Stand output async from command line
```js
let readStdoutToArray = async (currentWorkingDirectory) => {
  const util = require('util');
  const exec = util.promisify(require('child_process').exec);
  console.log('readStdout - (currentWorkingDirectory)', currentWorkingDirectory ) ;
  const { stdout, stderr } = await exec('git status --short', {
    cwd: currentWorkingDirectory
  });
  console.log('readStdout - (stdout)', stdout ) ;
    let outputArray = stdout.split('\n');
    return outputArray
    .map(line => line.trim());
}
```
