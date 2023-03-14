# The kitty zone infrastructure
To the repository where everything lies that I currently run and that is publically available on [TheKitty.zone](https://thekitty.zone/services/).

## Deployments:
A non exhaustive list of deployed services.

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
- [Kube-Prometheus-Stack](https://github.com/prometheus-community/helm-charts/blob/main/charts/kube-prometheus-stack/README.md)
- [Nginx Ingress](https://github.com/kubernetes/ingress-nginx)
- [Certmanager](https://cert-manager.io/docs/installation/)
- [Cryptpad](https://github.com/xwiki-labs/cryptpad)
- [Flux](https://github.com/fluxcd/flux2)
- [Loki](https://github.com/grafana/loki)
- [Sealed-Secrets-Controller](https://github.com/bitnami-labs/sealed-secrets)
- [Weave GitOps](https://docs.gitops.weave.works/)
- [Vaultwarden](https://github.com/dani-garcia/vaultwarden)
- [Mastodon](https://github.com/glitch-soc/mastodon)
## Planned Deployments:
- Matrix

- Nextcloud

Below you will find instruction on how to set this repo up yourself.
## Prerequisites

You will need a Ceph cluster and you need to configure at least every ingress to your domain, you might also change any other configuration.
To create the K3S cluste you will need an Hetzner account and the api token that you can generate from a given project.

Install Terraform on MacOS or Linux using Homebrew:

```sh
brew install terraform
```
The you will need get the latest kubehetzner version:

```sh
wget https://raw.githubusercontent.com/kube-hetzner/terraform-hcloud-kube-hetzner/master/kube.tf.example > terraform/kube.tf

```
You will need to customize it and activate nginx ingress, also the deployments need at least 24GB of ram.

After that you run:
```sh
cd terraform && terraform init
```
and
```sh
terraform apply
```

In order to apply this yourself, you'll need a GitHub account and a
[personal access token](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line)
that can create repositories (check all permissions under `repo`).

Install the Flux CLI on MacOS or Linux using Homebrew:

```sh
brew install fluxcd/tap/flux
```

Or install the CLI by downloading precompiled binaries using a Bash script:

```sh
curl -s https://fluxcd.io/install.sh | sudo bash
```

## Repository structure

The Git repository contains the following top directories:

- **apps** dir contains a list of directories named after the namespaces that has deployments. These folders contain the configuration files such as Helm Releases for each app
- **infrastructure** dir contains common infra tools such as sealed-secrets-controller and other tools not installed by terraform
- **clusters** dir contains the Flux configuration

```
├── apps
│   ├── base
│   └── production 
├── infrastructure
│   ├── configs
│   └── controllers
└── clusters
    └── production
```
## Bootstrap production


The clusters dir contains the Flux configuration:

```
./clusters/
└── production
    ├── apps.yaml
    └── infrastructure.yaml

```

In **clusters/production/** dir we have the Flux Kustomization definitions, for example:

```yaml
apiVersion: kustomize.toolkit.fluxcd.io/v1beta2
kind: Kustomization
metadata:
  name: apps
  namespace: flux-system
spec:
  interval: 10m0s
  dependsOn:
    - name: infra-configs
  sourceRef:
    kind: GitRepository
    name: flux-system
  path: ./apps/production
  prune: true
  wait: true
```

Note that with `path: ./apps/production` we configure Flux to sync the production Kustomize overlay and 
with `dependsOn` we tell Flux to create the infrastructure items before deploying the apps.

Fork this repository on your personal GitHub account and export your GitHub access token, username and repo name:

```sh
export GITHUB_TOKEN=<your-token>
export GITHUB_USER=<your-username>
export GITHUB_REPO=<repository-name>
```

Verify that your production cluster satisfies the prerequisites with:

```sh
flux check --pre
```

```
Bootstrap Flux on production by setting the context and path to your production cluster:

```sh
flux bootstrap github \
    --context=production \
    --owner=${GITHUB_USER} \
    --repository=${GITHUB_REPO} \
    --branch=main \
    --personal \
    --path=clusters/production
```

Watch the production reconciliation:

```console
$ flux get kustomizations --watch

NAME             	REVISION     	SUSPENDED	READY	MESSAGE                         
apps             	main/696182e	False    	True 	Applied revision: main/696182e	
flux-system      	main/696182e	False    	True 	Applied revision: main/696182e	
infra-configs    	main/696182e	False    	True 	Applied revision: main/696182e	
infra-controllers	main/696182e	False    	True 	Applied revision: main/696182e	
```

### Access the Flux UI

To access the Flux UI on a cluster, first start port forwarding with:

```sh
kubectl -n flux-system port-forward svc/weave-gitops 9001:9001
```

Navigate to http://localhost:9001 and login using the username `admin` and the password set in **infrastructure/controllers/weave-gitops.yaml**.

[Weave GitOps](https://docs.gitops.weave.works/) provides insights into your application deployments,
and makes continuous delivery with Flux easier to adopt.
The GUI provides a guided experience to build understanding and simplify getting started for new users;
they can easily discover the relationship between Flux objects and navigate to deeper levels of information as required.

You can change the admin password bcrypt hash in **infrastructure/controllers/weave-gitops.yaml**:

```yaml
apiVersion: helm.toolkit.fluxcd.io/v2beta1
kind: HelmRelease
metadata:
  name: weave-gitops
  namespace: flux-system
spec:
  # ...omitted for brevity
  values:
    adminUser:
      create: true
      username: admin
      # bcrypt hash for password "flux"
      passwordHash: "$2a$10$P/tHQ1DNFXdvX0zRGA8LPeSOyb0JXq9rP3fZ4W8HGTpLV7qHDlWhe"
```

To generate a bcrypt hash please see Weave GitOps
[documentation](https://docs.gitops.weave.works/docs/configuration/securing-access-to-the-dashboard/#login-via-a-cluster-user-account). 

Note that on production systems it is recommended to expose Weave GitOps over TLS with an ingress controller and
to enable OIDC authentication for your organisation members.
To configure OIDC with Dex and GitHub please see this [guide](https://docs.gitops.weave.works/docs/guides/setting-up-dex/).