# Serverless Terraform Modules

Terraform modules repository for infrastructure definitions in Serverless projects of Netex organization. This is a Nx monorepo with semver executors(@jscutlery/semver) and future terraform plugin for check format and issues with terraform.

In this repository you must work with the conventional commit(https://www.conventionalcommits.org/en/v1.0.0/) for the versioning to work properly.

**Table of contents**

1. [Getting started with Nx](#t1)
2. [Work with serverless-terraform-modules monorepo](#t2)

## Getting started with Nx <a name="t1"></a>

Nx(https://nx.dev/) is an extensible open srouce dev tool that helps teams develop at scale by providing three main things:

- Modern Tools and Frameworks: Out of the box configuration of frameworks and modern tools so that you can focus more on your application and less on configuration.
- Share Code: Share your code across multiple applications or temas while enforcing clean integration points.
- Leverage Dependency Graph: Undestarnd the dependency graph of your code base so that you can run actions on exactly on exactly the areas affected by a MR an no more

### - Requirements:

- To work with this Nx workspace it is necessary to have nodejs 16 installed, in addition to the npm 7 package manager.
- Use conventional commit.

### - How to work with [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/):

The Conventional Commits specification is a lightweight convention on top of commit messages. It provides an easy set of rules for creating an explicit commit history; which makes it easier to write automated tools on top of. This convention dovetails with SemVer, by describing the features, fixes, and breaking changes made in commit messages.

The commit message should be structured as follows:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

#### - Commits samples:

- Increments the third cardinal of the semver(PATCH):
  - `"fix(moduleName): fixed IAM roles"`
  - `"chore(moduleName): added new feature to eks"`
- Increments the second cardinal of the semver(MINOR):
  - `"feature(moduleName): a new role is added"`
- To increment the first cardinal of semver(MAJOR) you must add ! to the commit flag:
  - `"fix(moduleName)!: fix important issue with RDS"`
  - `"chore(moduleName)!: added new fargate config for spot instances"`
  - `"feature(moduleName)!: removed old mysql RDS database to auroraDB"`

### - MR verify:

A merge request verification pipeline is added to the repository to validate that all commits comply with the conventional commit. This pipeline is defined in `.gitlab/cicd/.mr-verfiy.yaml`. For this process the npm package `@commitlint/cli` is being used with the configuration set in the `commitlint.config.ts` file in the repository root.

:boom: It is important to note that the title of the MR will also become a commit, so it must also comply with this convention.

### - How to check with Nx for new versions:

We are using the Nx semver plugin to trace the versions of the workspace projects. And furthermore, with the executor version of helm-plugin developed, the info is added to the Helm Charts.

The repository has a versioning pipeline that, once changes are merged into the master branch, is running Nx processes to version projects and terraform modules. This is defined in `.gitlab/cicd/.version.yml`.

But if we are working on a new branch we can check that versioning changes locally with respect to the master branch as follows:

```
❯ npx nx affected --parallel=1 --skipCommit=true --base=master --target version --verbose --dryRun

 >  NX   Running target version for project netexcloud and 1 task it depends on:

    - netexcloud

   With additional flags:
     --skipCommit=true
     --dryRun=true

 ——————————————————————————

> nx run aws-mysql:version

[aws-mysql] 🟢 Nothing changed since last release.

> nx run aws-eks:version --skipCommit=true --dryRun

[aws-eks] 🆕 Calculated new version "1.0.26".

---
### <CHANGELOG.md changes>
---

[aws-eks] 📜 Generated CHANGELOG.md.

 ——————————————————————————

 >  NX   Successfully ran target version for project aws-eks

❯
```

As we can see it is important to pass the `--base` parameter with reference to the branch to compare, which normally the local branch should be `master`.
:boom:In addition, it is important to always launch this version runner locally with the `--dryRun` parameter so that it does not apply any changes to the files and displays the desired values.

And as we can see in the output it will show us the affected projects with changes and the new versions calculated based on the added commits. These with messages similar to `🆕 Calculated new version "x.x.x"`.

### - How to add new terraform modules:

If for some reason we need to add a new terrafom module we can do manually:

#### - Manually:

Inside the root folder you can create a new subfolder with the following structure:

```
├── newModule
    ├── main.tf
    ├── another..+n.tf
    ├── package.json
    └── project.json
```

We take as reference the `package.json` and `project.json` files from one of the other existing terraform modules and update the following values:

- "name"(`package.json`|`project.json`): name of project, as same of Helm Chart and directory
- "version"(`package.json`): if we start from zero it would be 0.0.1, and the same in Chart.yaml
- "description"(`package.json`): short info about this new Helm Chart
- "scripts"(`package.json`): change the references to the name of the new Helm Chart
- "sourceRoot"(`project.json`): set relative path of the Helm Chart code
- "changelogHeader"(`project.json`): change the references to the name of the new Helm Chart
- "header"(`project.json`): change the references to the name of the new Helm Chart
- "postTargets"(`project.json`): change the references to the name of the new Helm Chart
- "path"(`project.json`): set relative path of the Helm Chart code
