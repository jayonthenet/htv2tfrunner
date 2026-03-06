FROM ghcr.io/humanitec/humanitec-runner:v1.10.3

ARG TERRAFORM_VERSION=1.14.6
ARG TARGETARCH

USER root

# Remove OpenTofu, install Terraform, add wrapper that strips tofu-only flags
RUN rm /usr/local/bin/tofu \
    && wget -q "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_${TARGETARCH}.zip" \
       -O /tmp/terraform.zip \
    && unzip -o /tmp/terraform.zip -d /usr/local/bin/ \
    && rm /tmp/terraform.zip \
    && terraform version

COPY tofu-wrapper.sh /usr/local/bin/tofu
RUN chmod +x /usr/local/bin/tofu

USER nobody
