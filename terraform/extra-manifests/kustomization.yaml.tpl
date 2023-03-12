apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
- ./cephfs-csi-auth.yaml
- ./auth-external-dns.yaml
- ./pgo
- ./prometheus
- ./loki
- ./auth-pgo-s3-creds.yaml
- ./postgres.yaml
