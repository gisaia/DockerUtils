#!/bin/bash

## GENERATE THE DOCUMENTATTION
./node_modules/.bin/jsonschema2md ${*}

## SET THE OWNER OF schema TO THE HOST USER
user_id=$(stat -c '%u:%g' /schema)
chown -R ${user_id} /schema
