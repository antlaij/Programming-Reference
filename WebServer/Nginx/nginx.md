
### Login to server:
```sh
ssh username@servername
cd <nginx-folder>
vi nginx.conf
```

#### Switch to Root
sudo su -
sudo vi nginx.conf
sudo synoservicecfg -restart nginx

### Reload nginx config
sudo nginx -s reload

### nginx configuration for angular apps
#### Add this to appModule.ts providers, No need to change any config file
```ts
    { provide: LocationStrategy, useClass: HashLocationStrategy },
```
```nginx

        location / {
            try_files $uri $uri/ /index.html break;
        }

        location ~ /subfolderName {
            try_files $uri $uri/ /subfolderName/index.html;
        }

        rewrite ^/subfolderName/(.*)$ /subfolderName/index.html#$1 last;
```
#### Not working
```
        location ~ /subfolderName/ {
            try_files $uri $uri/ /subfolderName/index.html?/$request_uri;
        }
```

