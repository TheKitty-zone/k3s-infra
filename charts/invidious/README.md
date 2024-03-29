# invidious

![Version: 1.2.3](https://img.shields.io/badge/Version-1.2.3-informational?style=flat-square) ![AppVersion: latest](https://img.shields.io/badge/AppVersion-latest-informational?style=flat-square)

Invidious is an alternative front-end to YouTube

**Homepage:** <https://invidious.io/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| 11Tuvork28 | <zofi@xamh.de> | <https://github.com/11tuvork28/> |

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm repo add 11tuvork28 https://11tuvork28.github.io
$ helm install my-release 11tuvork28/invidious
```
## Source Code

* <https://github.com/11tuvork28/invidious>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| autoscaling | object | See below | Configure the HPA minReplicas should match replicaCount |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"ghcr.io/11tuvork28/invidious"` |  |
| image.tag | string | `"latest"` |  |
| ingress | object | See below | Configure the ingress definition Note: middlewares are only supported when using traefik |
| name | string | `"invidious"` |  |
| resources | object | See below | Configure resource limits here My custom image never exceeds 1024Mi, highest I have seen is 870Mi |
| rollingUpdate.replicaCount | int | `1` |  |
| rollingUpdate.surge | int | `0` |  |
| rollingUpdate.unavailable | int | `1` |  |
| secret | object | See below | Configure the secret that holds sensitive infos We assume that sealed-secrets are used, if not enable below and set the db values accordingly otherwise this should be ignored We also assume an external postgres cluster is being used |
| securityContext | object | See below | Configure the secruity Context below Invdious doesn't need special permissions to run |
| service.port | int | `3000` |  |
| service.type | string | `"ClusterIP"` |  |
| strategy | string | See below | Configure the update strategy Currently only RollingUpdate is supported |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)