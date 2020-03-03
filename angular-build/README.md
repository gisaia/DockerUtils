**angular-build** docker image allows to build an angular app with a given `package.json`.

The docker image is named `gisaia/angular-build`

---

## Usage

The image is to be used with the `docker run` command.

Parameter | Type | Description
-|-|-
`--mount dst=/output,src=...,type=bind` | Directory bind-mount | Bind-mounts a directory from the host machine, where to output the generated dist directory. Its path is indicated by the `src=...` parameter. **Beware, the host directory has to be created in advance**.
`-v [...]:/package.json` | File mount | Mount your local package.json into the docker


## Example

```bash

# Build the app with the given package.json and output the result in the current directory into a `dist` folder
docker run \
    --rm \
    -v package.json:/package.json \
    --mount dst=/output,src="$PWD",type=bind \
    gisaia/angular-build:0.0.1
```
