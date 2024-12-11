#!/bin/bash

## MOVE TO THE PREDEFINED MOUNTED FOLDER NAME : docs
cd /docs

## CLEAN typedoc_docs FOLDER
rm -rf typedoc_docs
mkdir typedoc_docs

## INSTALL DEPENDENCIES OF THE MOUNTED FOLDER + INSTALL TYPEDOC AND MARKDOWN PLUGIN
npm install
npm add typedoc@0.27.4 typedoc-plugin-markdown@4.3.2

## GENERATE THE DOCUMENTATTION
node_modules/.bin/typedoc --plugin typedoc-plugin-markdown --excludePrivate --out ./typedoc_docs/ $(echo "$@"| tr " " "\n")

## UNINSTALL TYPEDOC AND MARKDOWN PLUGIN, TO REMOVE IT FROM package.json OF THE MOUNTED FOLDER
npm remove typedoc typedoc-plugin-markdown


## SET THE OWNER OF typedoc_docs TO THE HOST USER
user_id=$(stat -c '%u:%g' /docs)
chown -R ${user_id} /docs/typedoc_docs
chown -R ${user_id} /docs/node_modules