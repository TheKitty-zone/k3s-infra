# Welcome
To the repository where everything lies that I currently run and that is publically available on [TheKitty.zone](https://thekitty.zone/services/).
This repo is currently undergoing a rework so that it is compatible with Flux, because I wanna do more GitOps instead of applying everything manually
Following the issues you can see what I currently plan on implementing or fixing.

Interested in pod uptime and the active alerts?
[Click here](https://grafana.thekitty.zone/public-dashboards/f5ea67d8defb4c8ea23aeaaa87af7fcb?orgId=1&refresh=5s)

## Deployments:
- Invidious
- Searx
- MPW
- Libreddit
- Rimgo
- Librarian
- Homepage
- Proxitok
- PostgreSQL Cluster using the crunchy operator
- External-dns
- Longhorn
- Kube-Prometheus-Stack
- Traefik
- Certmanager
- Cryptpad
- Flux
- Loki
- Sealed-Secrets-Controller
## Planned Deployments:
- Matrix(Needs its own Helm Chart to be written)
- Mastodon(Requires better Storage handling and a Helm Chart as well)

## Deploy Infra:
- terraform plan --out
- terraform apply

## Deploy Deployments:
- helm repo add bjw-s https://bjw-s.github.io/helm-charts/
- helm upgrade --install *name* -n *namespace* --create-namespace bjw-s/app-template --values *path to values*

## Deploy Other charts:
- helm upgrade --install prometheus-stack  prometheus-community/kube-prometheus-stack --namespace monitoring --values deployments/monitoring/prometheus-values.yaml --create-namespace
- helm upgrade loki grafana/loki-stack --namespace monitoring --values deployments/monitoring/loki.yaml
- helm upgrade searxng searxng/searxng -n searxng --values deployments/searx/values-searx
