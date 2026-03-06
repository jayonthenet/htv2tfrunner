#!/bin/sh
# Wrapper that strips OpenTofu-specific CLI flags before forwarding to Terraform.
# The Humanitec runner calls `tofu` internally, so this script sits at /usr/local/bin/tofu
# and translates the call for Terraform compatibility.
#
# Known OpenTofu-only flags (not recognized by Terraform CLI):
#   -consolidate-errors    (tofu 1.9+, groups similar errors)
#   -consolidate-warnings  (tofu 1.9+, groups similar warnings)
#   -concise               (suppresses progress output)

args=""
for arg in "$@"; do
  case "$arg" in
    -consolidate-errors) ;;
    -consolidate-warnings) ;;
    -concise) ;;
    *) args="$args $arg" ;;
  esac
done

exec /usr/local/bin/terraform $args
