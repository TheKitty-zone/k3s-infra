# Welcome
To the repository where everything lies that I currently run and that is publically available on [TheKitty.zone](https://thekitty.zone/services/).
This repo is currently undergoing a rework so that it is compatible with Flux, because I wanna do more GitOps instead of applying everything manually
Following the issues you can see what I currently plan on implementing or fixing.

Interested in pod uptime and the active alerts?
[Click here](https://grafana.thekitty.zone/public-dashboards/f5ea67d8defb4c8ea23aeaaa87af7fcb?orgId=1&refresh=5s)

## Deployments:
- [Invidious](https://github.com/11Tuvork28/invidious)
- [Searx](https://github.com/11Tuvork28/searxng/searxng)
- [MPW](https://github.com/PIVX-Labs/MyPIVXWallet)
- [Libreddit](https://github.com/libreddit/libreddit)
- [Rimgo](https://codeberg.org/video-prize-ranch/rimgo)
- [Librarian](https://codeberg.org/librarian/librarian)
- [Homepage](https://github.com/11Tuvork28/thekitty.zone)
- [Proxitok](https://github.com/pablouser1/ProxiTok)
- [PostgreSQL Cluster using the crunchy operator](https://github.com/11Tuvork28/prod-postgres-operator)
- [External-dns](https://github.com/kubernetes-sigs/external-dns)
- [Longhorn](https://github.com/longhorn/longhorn)
- [Kube-Prometheus-Stack](https://github.com/prometheus-community/helm-charts/blob/main/charts/kube-prometheus-stack/README.md)
- [Traefik](https://github.com/traefik/traefik)
- [Certmanager](https://cert-manager.io/docs/installation/)
- [Cryptpad](https://github.com/xwiki-labs/cryptpad)
- [Flux](https://github.com/fluxcd/flux2)
- [Loki](https://github.com/grafana/loki)
- [Sealed-Secrets-Controller](https://github.com/bitnami-labs/sealed-secrets)
## Planned Deployments:
- Matrix(Needs its own Helm Chart to be written)
- Mastodon(Requires better Storage handling and a Helm Chart as well)
- Nextcloud(Needs RWX Volumes to be configured in Longhorn)

## Deploy Infra:
- terraform apply

## Deploy Deployments:
- helm repo add bjw-s https://bjw-s.github.io/helm-charts/
- helm upgrade --install *name* -n *namespace* --create-namespace bjw-s/app-template --values *path to values*

## Deploy Other charts:
- helm upgrade --install prometheus-stack  prometheus-community/kube-prometheus-stack --namespace monitoring --values deployments/monitoring/prometheus-values.yaml --create-namespace
- helm upgrade loki grafana/loki-stack --namespace monitoring --values deployments/monitoring/loki.yaml
- helm upgrade searxng searxng/searxng -n searxng --values deployments/searx/values-searx
