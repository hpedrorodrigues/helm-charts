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

## Example / Flux + External Secrets Operator

<details>
<summary>namespace.yaml</summary>

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: disturbed-cli
```

</details>

<details>
<summary>repository.yaml</summary>

```yaml
apiVersion: source.toolkit.fluxcd.io/v1
kind: HelmRepository
metadata:
  name: disturbed-cli
spec:
  interval: 1h
  url: https://hpedrorodrigues.github.io/helm-charts
```

</details>

<details>
<summary>release.yaml</summary>

```yaml
apiVersion: helm.toolkit.fluxcd.io/v2
kind: HelmRelease
metadata:
  name: disturbed-cli
spec:
  interval: 1h
  chart:
    spec:
      chart: disturbed-cli
      version: <version>
      sourceRef:
        kind: HelmRepository
        name: disturbed-cli
  values:
    env:
      - name: DISTURBED_SLACK_API_TOKEN
        valueFrom:
          secretKeyRef:
            name: disturbed-cli
            key: DISTURBED_SLACK_API_TOKEN
      - name: DISTURBED_OPSGENIE_API_KEY
        valueFrom:
          secretKeyRef:
            name: disturbed-cli
            key: DISTURBED_OPSGENIE_API_KEY
    configuration:
      content: |-
        schedules_mapping:
        - schedule_name: product
          user_group_name: 'product-oncall'
        - schedule_name: sre
          user_group_name: 'sre-oncall'
          overrides:
          - user_email: john.doe@gmail.com
            timezone: 'America/Fortaleza'
            starts_on: '23:00:00'
            ends_on: '01:00:00'
            repeats_on: weekdays
            replace_by:
            - jane.doe@gmail.com
```

</details>

<details>
<summary>external-secret.yaml</summary>

```yaml
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: disturbed-cli
spec:
  secretStoreRef:
    name: <store-name>
    kind: ClusterSecretStore
  target:
    name: disturbed-cli
    deletionPolicy: Delete
  data:
    - remoteRef:
        key: disturbed_cli_secrets
        property: opsgenie_api_key
      secretKey: DISTURBED_OPSGENIE_API_KEY
    - remoteRef:
        key: disturbed_cli_secrets
        property: slack_api_token
      secretKey: DISTURBED_SLACK_API_TOKEN
```

</details>

<details>
<summary>kustomization.yaml</summary>

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
namespace: disturbed-cli
resources:
  - namespace.yaml
  - repository.yaml
  - release.yaml
  - secrets.yaml
```

</details>

[kubernetes]: https://kubernetes.io
[helm]: https://helm.sh
[helm-cli-repo]: https://helm.sh/docs/helm/helm_repo
[helm-cli-install]: https://helm.sh/docs/helm/helm_install
[helm-cli-uninstall]: https://helm.sh/docs/helm/helm_uninstall
[helm-cli-upgrade]: https://helm.sh/docs/helm/helm_upgrade
[helm-intro-chart-customization]: https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing
[github-repository]: https://github.com/hpedrorodrigues/disturbed_cli
