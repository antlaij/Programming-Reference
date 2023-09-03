# npm command line

## List the current npm configuration
```sh
npm config ls -l
```

---
## Check where is npm package installed for global
```sh
npm root -g
npm root
npm config get prefix
```

```sh
npm install imagemin-gifsicle
npm install imagemin-jpegtran
npm install imagemin-optipng
npm install imagemin-pngquant
```

---
## Install jshint to check js file with problem
```sh
npm install jshint -g
```

---
## check npm install location
```sh
npm init
npm install xml2json --save
npm install xml2js --save
```

---
## install version between

```sh
npm install typescript@">=3.1.1 <3.2"
```

---
## Git Version update
```sh
npm version patch -m "upgrade to version"
```

---
## List existing package
```sh
npm list
npm list --depth=0
```
### List version on one package
```sh
npm list webpack
```

---
## Check which package can update
```sh
npm outdated
```

---
## Check latest verion of a package
```sh
npm view express version
```

---
## Show current info. for a package
```sh
npm show vue
```

## view node version
```sh
node --version
```
