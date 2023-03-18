apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
- ./auth-external-dns.yaml
- ./pgo
- ./auth-pgo-s3-creds.yaml