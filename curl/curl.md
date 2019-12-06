
# Get Call with curl
curl -H "Content-Type: application/json" -o /c/temp/getResponse.json --ntlm -u : http://www.mydomain.com/api/get

# Post Call with curl
curl -H "Content-Type: application/json" -d "{'names':[1234, 2346],'text':'testing string'}" -o /c/temp/postResponse.json --ntlm -u : http://www.mydomain.com/api/post

