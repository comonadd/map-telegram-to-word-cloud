#!/bin/bash

json_file=$1
name=$2
output=$3

echo "name=$name"
query=".frequent_contacts.list[] | select(.name == \""
query="$query$name"
query="$query\") | select(.category == \"people\") | .id"
echo "Query is $query"

user_id=$(jq "$query" $json_file)
echo "User id: $user_id"

jq -r ".chats.list[] | select(.id == $user_id) | .messages | map(select(.text | type == \"string\") | .text)[]" $json_file > $output
