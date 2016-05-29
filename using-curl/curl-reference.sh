#!/bin/bash

API_URL="https://cloudsso.cisco.com/oauth/clients"
USERID="mashery.gen"
PASSWD="Csc0R0cks!"
CLIENT_CREATE_REQUEST="data/client.create-request.json"
CLIENT_CREATE_REQUEST_TMP="tmp/client.create-request.json"
ELAPSED_TIME=".time"
TMP_FOLDER="./tmp"
CLIENT_NAME="Hello App (using Bash)"
CLIENT_DESCRIPTION=$CLIENT_NAME
currtime1=$(date +"%s")
rand2=$(od -vAn -N4 -tu4 < /dev/urandom)
currtime2=$(date +"%s")
key=$name$rand1$currtime1
secret=$name$rand2$currtime2
CLIENT_ID=$(echo -n $key | openssl sha1 -hmac "key")
CLIENT_ID=${CLIENT_ID:0:24}
SECRET=$(echo -n $secret | openssl sha1 -hmac "key")
SECRET=${SECRET:0:24}

sed "s/%CLIENT_ID%/$CLIENT_ID/;s/%SECRET%/$SECRET/;s/%CLIENT_NAME%/$CLIENT_NAME/;s/%CLIENT_DESCRIPTION%/$CLIENT_DESCRIPTION/" < $CLIENT_CREATE_REQUEST > $CLIENT_CREATE_REQUEST_TMP
echo "Calling PingFederate OAuth Client Create Call (PROD) = ..."
/usr/bin/time -p curl --silent --header "Content-type: application/json" --header "userid: $USERID" --header "password: $PASSWD" --data @$CLIENT_CREATE_REQUEST_TMP $API_URL 2> $ELAPSED_TIME | jq '.'
echo "All done. Here's the Client Request sent ..."
cat $CLIENT_CREATE_REQUEST_TMP | jq '.'
echo "Time spent in PingFederate OAuth Client Create Call (PROD):"
cat $ELAPSED_TIME

# curl --silent or -s Silent or quiet mode. Don't show progress meter or error messages. Makes Curl mute
# --insecure # or -k (SSL) This option explicitly allows curl to perform "insecure" SSL connections and transfers. 
#       All SSL connections are attempted to be made secure by using the CA certificate bundle installed by default. 
#       This makes all connections considered "insecure" fail unless -k, --insecure is used.
# --header or -H HTTP Extra header to use when getting a web page. You may specify any number of extra headers.
#       If you send the custom header with no-value then its header must be terminated with a semicolon, such as 
#       -H "X-Custom-Header;" to send "X-Custom-Header:" 
# -L, --location (HTTP/HTTPS) If the server reports that the requested page has moved to a different location 
#      (indicated with a Location: header and a 3XX response code), this option will make curl redo the request on 
#      the new place. If used together with -i, --include or -I, --head, headers from all requested pages will be 
#      shown. When authentication is used, curl only sends its credentials to the initial host. If a redirect 
#      takes curl to a different host, it won't be able to intercept the user+password. See also --location-trusted 
#      on how to change this. You can limit the amount of redirects to follow by using the --max-redirs option.
# -X POST # Don't think we need it
# --data or -d (HTTP) Sends the specified data in a POST request to the HTTP server, in the same way that a browser 
#       does when a user has filled in an HTML form and presses the submit button. This will cause curl to pass 
#       the data to the server using the content-type application/x-www-form-urlencoded. To post data purely binary, 
#       you should instead use the --data-binary option. To URL-encode the value of a form field you may use 
#       --data-urlencode "grant_type=client_credentials" # -d If you start the data with the letter @, the rest 
#       should be a file name to read the data from, or - if you want curl to read the data from stdin. The contents 
#       of the file must already be URL-encoded. Multiple files can also be specified. Posting data from a file 
#       named 'foobar' would thus be done with --data @foobar
# Use -G, --get When used, this option will make all data specified with -d, --data or --data-binary to be used in an 
#       HTTP GET request instead of the POST request that otherwise would be used. The data will be appended to the 
#       URL with a '?' separator. If used in combination with -I, the POST data will instead be appended to the URL 
#       with a HEAD request
# --c or --cookie-jar <file-name> (HTTP) Specify to which file you want curl to write all cookies after a completed 
#       operation. Curl writes all cookies previously read from a specified file as well as all cookies received from
#       remote server(s). If no cookies are known, no file will be written. The file will be written using the 
#       Netscape cookie file format. If you set the file name to a single dash, "-", the cookies will be written to 
#       stdout
# --include or -i (HTTP) Include the HTTP-header in the output. The HTTP-header includes things like server-name, 
#       date of the document, HTTP-version and more...
# --cookie or -b <name=data> (HTTP) Pass the data to the HTTP server as a cookie. It is supposedly the data 
#       previously received from the server in a "Set-Cookie:" line. The data should be in the format "NAME1=VALUE1; 
#       NAME2=VALUE2". If no '=' symbol is used in the line, it is treated as a filename to use to read previously 
#       stored cookie lines from, which should be used in this session if they match. Using this method also 
#       activates the "cookie parser" which will make curl record incoming cookies too, which may be handy if you're 
#       using this in combination with the -L, --location option. The file format of the file to read cookies from 
#       should be plain HTTP headers or the Netscape/Mozilla cookie file format. NOTE that the file specified with 
#       -b, --cookie is only used as input. No cookies will be stored in the file. To store cookies, use the -c, 
#       --cookie-jar option or you could even save the HTTP headers to a file using -D, --dump-header!
# -I, --head
#       (HTTP/FTP/FILE) Fetch the HTTP-header only! HTTP-servers feature the command HEAD which this uses to get 
#       nothing but the header of a document. When used on an FTP or FILE file, curl displays the file size and last 
#       modification time only
# -v, --verbose
#       Makes the fetching more verbose/talkative. Mostly useful for debugging. A line starting with '>' means 
#       "header data" sent by curl, '<' means "header data" received by curl that is hidden in normal cases, and a 
#       line starting with '*' means additional info provided by curl. Note that if you only want HTTP headers in 
#       the output, -i, --include might be the option you're looking for. If you think this option still doesn't 
#       give you enough details, consider using --trace or --trace-ascii instead. This option overrides previous 
#       uses of --trace-ascii or --trace. Use -s, --silent to make curl quiet
# --trace-ascii <file>
#       Enables a full trace dump of all incoming and outgoing data, including descriptive information, to the given
#       output file. Use "-" as filename to have the output sent to stdout.
#       This is very similar to --trace, but leaves out the hex part and only shows the ASCII part of the dump. 
#       It makes smaller output that might be easier to read for untrained humans.
#       This option overrides previous uses of -v, --verbose or --trace. If this option is used several times, 
#       the last one will be used.