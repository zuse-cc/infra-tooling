# Module Repo Runbook

**Owner:** Infra Team
**On-Call:** #terraforge
**Est. Time:** 5-10 minutes

## Service Overview

- Module repositories are used to maintain Terraform modules
- Terraform modules represent reusable pieces of infrastructure

## Architecture

- Link to infra CD pipeline architecture document
- Embed a relevant diagram from the above doc

## Preconditions

- Common workstation setup complete (link to guide, includes `gh`)
- Access to organisations GitHub account
- Permissions to create repositories (birth-right for engineers)
- Valid `$GITHUB_TOKEN` set in shell env

## Conventions

- Naming conventions: `terraform-${PROVIDER}-${SERVICE}`
- We keep _module_ repos environment agnostic and open source under Apache 2.0 license

## Common Operations

### Create Module Repo

```sh
gh repo create zuse-cc/terraform-${PROVIDER}-${SERVICE} --template zuse-cc/terraform-module-template --public
git clone git@github.com:zuse-cc/terraform-${PROVIDER}-${SERVICE}
```

### Monitoring

- Link to GH deployment dashboards
- Link to drift detection dashboards

### Troubleshooting

**Symptom:** Terraform fails with message "workspace is locked"
**Diagnosis:** Look for other PRs that may be running parallel
**Resolution:** Wait for the other PRs to complete, if needed unlock manually (instructions...)

[Repeat for common issues]

### Emergency Procedures

- Perform privilege escalation workflow to get emergency access
- Run Linode CLI commands to manually reconcile resources

## Dependencies

- Infra tooling team is managing the GH environment, tag `@infra-tooling-on-duty`
- Linode 1st level support for Linode related issues (OSS, accounts, etc.)

## Configuration
[Environment variables, secrets, feature flags]

## Useful Commands

- Set `TF_LOG=debug` to get more verbose output from terraform
- Use the `tf state` family of commands to manually fix state problems only as a last resort!
