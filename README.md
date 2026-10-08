# Serverless Terraform Modules

Terraform modules repository for infrastructure definitions in Serverless projects of Netex organization. Each module is versioned independently with [release-please](https://github.com/googleapis/release-please), driven by conventional commits.

In this repository you must work with the conventional commit(https://www.conventionalcommits.org/en/v1.0.0/) for the versioning to work properly.

## Versionado

Cada modulo lleva su propia linea de versiones. Las tags son `<modulo>@X.Y.Z`
(p.ej. `aws-lambda@1.2.2`) y, ademas, se mantienen dos tags flotantes por
modulo que son las que consumen los repos TerraSAM:

| Tag | Apunta a |
|---|---|
| `<modulo>@1` | la ultima `1.x.y` publicada |
| `<modulo>@latest` | la ultima publicada, sea cual sea el major |

Un repo consumidor fija la flotante de major, no la exacta:

```hcl
source = "git::https://github.com/netexknowledge/platform-serverless-terraform-modules.git//aws-lambda?ref=aws-lambda@1"
```

### Como se publica

1. Se mergea una PR a `main` con commits convencionales (`feat:`, `fix:`, ...).
   El scope es obligatorio y debe ser el nombre del modulo: `fix(aws-lambda): ...`.
2. `release-please` mantiene abierta una **PR de release** con el bump de version
   y el CHANGELOG de cada modulo afectado. Se va actualizando sola conforme
   entran mas cambios.
3. Al mergear esa PR, release-please crea las tags exactas y las Releases.
4. El workflow `version.yml` mueve entonces las tags flotantes `@1` y `@latest`.

No hay que ejecutar nada a mano ni tocar numeros de version: el `version` de
cada `package.json` y el `.release-please-manifest.json` los gestiona
release-please.

### Que tipo de commit sube que version

| Commit | Efecto |
|---|---|
| `fix(<modulo>): ...` | patch (1.0.0 -> 1.0.1) |
| `feat(<modulo>): ...` | minor (1.0.0 -> 1.1.0) |
| `feat(<modulo>)!: ...` o `BREAKING CHANGE:` | major (1.0.0 -> 2.0.0) |
| `perf(<modulo>): ...` | patch |
| `revert(<modulo>): ...` | patch |
| `chore`, `docs`, `style`, `refactor`, `test`, `build`, `ci`, `deploy` | no suben version ni salen en el CHANGELOG |

Un major **no mueve** la flotante del major anterior: si se publica
`aws-lambda@2.0.0`, `aws-lambda@1` sigue donde estaba y los consumidores no se
enteran hasta que cambien la referencia a proposito.

## Verificacion de PRs

`pr-verify.yml` valida con commitlint que los commits y el titulo de la PR
cumplan conventional commits, usando las reglas de `commitlint.config.js`
(preset `config-conventional` mas `scope-empty`, que obliga a poner scope).

La etiqueta `no_pr_verify` en una PR salta esa verificacion.

## Como anadir un modulo nuevo

1. Crear el directorio con el codigo Terraform.
2. Generar su `package.json`: `./generador_packages.sh aws-nuevo-modulo`.
3. Anadirlo a `release-please-config.json`, en `packages`.
4. Anadirlo a `.release-please-manifest.json` con `"0.0.0"`.
