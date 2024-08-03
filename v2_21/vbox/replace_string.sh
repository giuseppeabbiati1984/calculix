#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 old_string new_string filename"
  exit 1
fi

old_string=$1
new_string=$2
filename=$3

# Escape the new_string to handle special characters
escaped_new_string=$(printf '%s\n' "$new_string" | sed -e 's/[\/&]/\\&/g')

# Replace the string using | as the delimiter
sed -i "s|$old_string|$escaped_new_string|g" "$filename"
