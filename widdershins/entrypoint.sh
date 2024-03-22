#!/usr/bin/env sh

widdershins -e /input/env.json /input/api.json -o /output/reference.md
user_id=$(stat -c '%u:%g' /output)
chown -R ${user_id} /output/reference.md
