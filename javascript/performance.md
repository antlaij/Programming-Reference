# Javascript performance
## Table of Contents
1. [Tail Call Optimization - TCO](#Tail-Call-Optimization---TCO)
    1. [Call OKTA api recursively to get all users with 200 limit per call](#Call-OKTA-api-recursively-to-get-all-users-with-200-limit-per-call)

***


## Tail Call Optimization - TCO
### Call OKTA api recursively to get all users with 200 limit per call
```js
let callOktaApiGetAllUsers = async (apiToken: string, url: string, accUsers: Array<any>): Promise<Array<any>> => {

  let response = await axios.get(url, {
    timeout: 10000,
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': `SSWS ${apiToken}`,
  }}
  );
  let linkStr = response.headers.link as string;
  let links = linkStr.split(',');

  // console.log('callOktaApiGetAllUsers - (links)', links.length);
  if(links.length >= 2){
    let fullNextLink = links[1];
    let nextLink = RegExp(/<(.*)>/).exec(fullNextLink)![1];
    console.log('callOktaApiGetAllUsers - (nextLink)', nextLink);

    return await callOktaApiGetAllUsers(apiToken, nextLink, [...accUsers, ...response.data ]);
  }
  
  return [...accUsers, ...response.data ];
}

```




