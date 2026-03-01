# Deployment Repo Runbook

**Owner:** Infra Team
**On-Call:** #terraforge
**Est. Time:** 1-2 hours

## Service Overview

- Deployment repositories are used to maintain Terraform deployment configurations
- These configurations declare the desired state of the infrastructure we want to deploy
- GHA workflows will reconcile desired state into actual state via Terraform

## Architecture

- Link to infra CD pipeline architecture document
- Embed a relevant diagram from the above doc

## Preconditions

- Common workstation setup complete (link to guide, includes `gh`)
- Access to organisations' GitHub account
- Permissions to create repositories (birth-right for engineers)
- Valid `$GITHUB_TOKEN` set in shell env
- Valid `$LINODE_TOKEN` set in shell env

## Conventions

> [!IMPORTANT]
> Deployment repos are sensitive and MUST be `private`!

- Naming convention: `zuse-cc/${SERVICE}-infra`, e.g. `zuse-cc/developer-enablement-infra`
- Follow https://github.com/zuse-cc/terraform-infra-template/blob/main/README.md for further setup

```sh
OWNER=zuse-cc
SERVICE=...
gh repo create ${OWNER}/${SERVICE}-infra --template zuse-cc/terraform-infra-template --private
git clone git@github.com:${OWNER}/${SERVICE}-infra
```
