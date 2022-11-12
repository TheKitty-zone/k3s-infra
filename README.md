infra:
- terraform plan --out
- terraform apply

Deployments:
- helm repo add bjw-s https://bjw-s.github.io/helm-charts/
- helm upgrade --install *name* -n *namespace* --create-namespace bjw-s/app-template --values *path to values*
Other charts
- helm upgrade --install prometheus-stack  prometheus-community/kube-prometheus-stack --namespace monitoring --values deployments/monitoring/prometheus-values.yaml --create-namespace
- helm upgrade loki grafana/loki-stack --namespace monitoring --values deployments/monitoring/loki.yaml
- helm upgrade searxng searxng/searxng -n=searxng --values deployments/searx/values-searx