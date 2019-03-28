[TypeDoc](https://typedoc.org/) docker image, able to generate documentation, in markdown, from annotated typescript files. Generated files have the host user group ID and the user ID.

The docker image is named `gisaia/typedocgen`

---

- [Build](#build)
- [Publication](#publication)
- [Usage](#usage)
  * [Example](#example)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>

# Build

```
docker build -t gisaia/typedocgen:x.x.x gisaia/typedocgen:latest .
```

# Publication

```
docker push gisaia/typedocgen:x.x.x
docker push gisaia/typedocgen:latest
```

# Usage

- Place your terminal in the folder where your tagged typescript files reside : your project folder.
- Every non-native typescript module should be declared in a `package.json` file that is to be placed in the project folder.
- The image is to be used with the `docker run` command. Various `docker run` parameters can be used:

| Parameter | Type | Description |
-|-|-
`--mount dst=/docs,src=...,type=bind,ro` | File bind-mount | Bind-mounts the typescript files from the host machine, whose path is indicated by the `src=...` parameter.
`generatedoc` | Documentation generation command| Generates the md files with the group ID and the user ID of the host machine.
| | Command line arguments | You can generate documentation from typscript files that are in a specific folder in your mounted project, just by appending it at the end of the `docker run` command (after the name of the image). Example: `specific/folder` |

> Note : The markdown files are generated in `typedoc_docs` folder within your project folder.

## Example

```bash

# - Run generatedoc command`
docker run \
  --mount dst=/docs,src="$PWD/project",type=bind \
  --rm \
  gisaia/swagger-codegen-2.2.3 \
    generatedoc \
    relative/path/to/folder
```
