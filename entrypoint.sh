#!/bin/bash -ex

LAMBDA_API="http://${AWS_LAMBDA_RUNTIME_API}/2018-06-01"

cat >/tmp/response.json <<EOF
{"statusCode": 200, "body": "Hello world!"}
EOF


while true; do
  temp=$(mktemp -d)
  curl -m 86400 -D "$temp/header.txt" -o "$temp/body.json" \
    $LAMBDA_API/runtime/invocation/next
  echo '----- header -----'
  cat "$temp/header.txt"
  echo '----- body -----'
  cat "$temp/body.json"

  request_id=$(grep Lambda-Runtime-Aws-Request-Id "$temp/header.txt" | cut -d ' ' -f 2 | tr -d '\r')
  curl -X POST $LAMBDA_API/runtime/invocation/$request_id/response \
    -H 'Content-Type: application/json' -d @/tmp/response.json

  rm -rf "$temp"
done
