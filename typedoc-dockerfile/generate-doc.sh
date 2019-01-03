#!/bin/bash

## MOVE TO THE PREDEFINED MOUNTED FOLDER NAME : docs
cd /docs

## CLEAN typedoc_docs FOLDER
rm -rf typedoc_docs
mkdir typedoc_docs

## INSTALL DEPENDENCIES OF THE MOUNTED FOLDER + INSTALL TYPEDOC AND MARKDOWN PLUGIN
npm install
npm add typedoc@0.13.0 typedoc-plugin-markdown@1.1.20

## GENERATE THE DOCUMENTATTION
node_modules/.bin/typedoc --mode modules --theme markdown --module es2015 --excludePrivate --out ./typedoc_docs/ --exclude **/*.spec.ts "$1"

## UNINSTALL TYPEDOC AND MARKDOWN PLUGIN, TO REMOVE IT FROM package.json OF THE MOUNTED FOLDER
npm remove typedoc typedoc-plugin-markdown


## SET THE OWNER OF typedoc_docs TO THE HOST USER
user_id=$(stat -c '%u:%g' /docs)
chown -R ${user_id} /docs/typedoc_docs
chown -R ${user_id} /docs/node_modules