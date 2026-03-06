# Humanitec Runner with Terraform

Custom [Humanitec v2 runner](https://developer.humanitec.com/platform-orchestrator/docs/configure/runners/overview/) image that replaces OpenTofu with Terraform CLI.

The runner binary hardcodes calls to `tofu` (init, plan, apply, etc). This image removes the OpenTofu binary, installs Terraform, and symlinks `tofu` -> `terraform` so the runner transparently uses Terraform instead.

## Image

```
ghcr.io/<owner>/humanitec-runner-terraform:latest
```

## Tags

| Tag | Meaning |
|-----|---------|
| `latest` | Latest build from `main` |
| `tf1.14.6` | Pinned to a specific Terraform version |
| `v1.0.0` | Semver release tag |
| `sha-abc1234` | Specific commit |

## Usage in Humanitec

Set the custom runner image in your runner configuration's `pod_template`:

```yaml
runner_image: ghcr.io/<owner>/humanitec-runner-terraform:latest
```

## Building locally

```bash
docker buildx build --platform linux/amd64,linux/arm64 \
  --build-arg TERRAFORM_VERSION=1.14.6 \
  -t humanitec-runner-terraform:latest .
```

## Updating Terraform version

Either:
- Edit `TERRAFORM_VERSION` in the Dockerfile and push
- Trigger the workflow manually with a custom version via `workflow_dispatch`
