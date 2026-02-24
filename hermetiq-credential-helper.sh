#!/usr/bin/env bash

if ! command -v curl &> /dev/null; then
  echo -e "\nERROR: Must install 'curl' before using this script!"
  exit 1
fi

if ! command -v jq &> /dev/null; then
  echo -e "\nERROR: Must install 'jq' before using this script!"
  exit 1
fi

M2M_CLIENT_ID="m2m-client-live-62d61cfe-0fa7-4a0f-a005-c3216e854629"
M2M_CLIENT_SECRET="ubJZiXV5hZgA4qS9i2t6b_ClvUb5giagaAq2SUjVxSkZYRP2"
M2M_TOKEN_URL="https://login.cloud.hermetiq.io/v1/oauth2/token"
M2M_RESPONSE=$(curl -s -X POST "${M2M_TOKEN_URL}" -H "Content-Type: application/json" \
  -d "{\"client_id\": \"$M2M_CLIENT_ID\",\"client_secret\": \"$M2M_CLIENT_SECRET\",\"grant_type\": \"client_credentials\"}")

ACCESS_TOKEN=$(echo "$M2M_RESPONSE" | jq -r '.access_token')
if [[ "$ACCESS_TOKEN" != "null" && "$ACCESS_TOKEN" != "" ]]; then
  jq --null-input --arg accessToken "${ACCESS_TOKEN}" '{"headers": {"x-hermetiq-m2m-access-token": [$accessToken]}}'
else
  echo "\nERROR: Failed to get M2M access token: $M2M_RESPONSE\n"
  exit 1
fi
