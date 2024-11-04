# Disturbed CLI

Simple CLI that update users in Slack user groups based on OpsGenie on-call schedules.

Learn more: [disturbed_cli][github-repository].

This chart creates a disturbed-cli cronjob on a [Kubernetes][kubernetes] cluster using the [Helm][helm] package manager.

## Get Repository Info

```console
helm repo add hpedrorodrigues-charts https://hpedrorodrigues.github.io/helm-charts
helm repo update
```

_See [`helm repo`][helm-cli-repo] for command documentation._

## Install Chart

```console
helm install [RELEASE_NAME] hpedrorodrigues-charts/disturbed-cli
```

_See [configuration](#configuration) below._

_See [helm install][helm-cli-install] for command documentation._

## Uninstall Chart

```console
helm uninstall [RELEASE_NAME]
```

This removes all the Kubernetes components associated with the chart and deletes the release.

_See [helm uninstall][helm-cli-uninstall] for command documentation._

## Upgrading Chart

```console
helm upgrade [RELEASE_NAME] [CHART] --install
```

_See [helm upgrade][helm-cli-upgrade] for command documentation._

## Configuration

See [Customizing the chart before installing][helm-intro-chart-customization]. To check all configurable options with
detailed comments, visit the chart's [values.yaml](./values.yaml), or run these configuration commands:

```console
helm show values hpedrorodrigues-charts/disturbed-cli
```

[kubernetes]: https://kubernetes.io
[helm]: https://helm.sh
[helm-cli-repo]: https://helm.sh/docs/helm/helm_repo
[helm-cli-install]: https://helm.sh/docs/helm/helm_install
[helm-cli-uninstall]: https://helm.sh/docs/helm/helm_uninstall
[helm-cli-upgrade]: https://helm.sh/docs/helm/helm_upgrade
[helm-intro-chart-customization]: https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing
[github-repository]: https://github.com/hpedrorodrigues/disturbed_cli
