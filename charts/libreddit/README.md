# Libreddit Helm chart

Easily deploy Libreddit to Kubernetes.

## Installing Helm chart

```sh
# Build Helm dependencies
$ helm dep build

# Install Helm app to your Kubernetes cluster
$ helm install libreddit ./
```

## Upgrading

```sh
# Upgrading is easy, too!
$ helm upgrade libreddit ./
```

## Uninstall

```sh
$ helm delete libreddit
```
