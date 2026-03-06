#!/bin/sh
# Wrapper that strips OpenTofu-specific CLI flags before forwarding to Terraform.
# The Humanitec runner calls `tofu` internally, so this script sits at /usr/local/bin/tofu
# and translates the call for Terraform compatibility.
#
# Source: internal/runner/runner.go in humanitec-runner
#
# Flags the runner passes that Terraform does NOT recognize:
#   -consolidate-errors    used by: init, plan, apply, destroy
#   -show-sensitive        used by: output
#
# Flags the runner passes that Terraform DOES recognize (no stripping needed):
#   -no-color, -json, -compact-warnings, -auto-approve, -out, -chdir

args=""
for arg in "$@"; do
  case "$arg" in
    -consolidate-errors) ;;
    -show-sensitive) ;;
    *) args="$args $arg" ;;
  esac
done

exec /usr/local/bin/terraform $args
