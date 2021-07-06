# Quorum Key-manager-helm

## Quorum Key Manager
Quorum Key Manager(QKM) is a key management service developed under the BSL 1.1 license and written in Go. 

Quorum Key Manager exposes a HTTP API service to manage your secrets, keys and ethereum accounts. QKM supports the integration with
*Amazon Key Management Service*, *Azure Key Vault* and *Hashicorp Vault*. 

In addition, using QKM, you can connect to your ethereum nodes to sign your transaction using the ethereum account stored in your secure key vault.

## Installing the Chart

To install the chart with the release name `qkm`:

```console
$ helm repo add helm-consensys https://artifacts.consensys.net/public/helm/helm/charts/
$ helm install qkm helm-consensys/qkm
```

These commands deploy Quorum Key Manager on the Kubernetes cluster with the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `qkm` deployment:

```console
$ helm delete qkm
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

The following tables lists the configurable parameters of the Quoum Key Manager chart and their default values.

| Parameter                                            | Description                                                                                                            | Default                                       |
|------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------|
| `replicaCount`                                       | Number of Quorum Key Manager replicas                                                                                  | `1`                                           |
| `nameOverride`                                       | String to partially override quorumkeymanager.fullname template with a string (will prepend the release name)          | `nil`                                         |
| `fullnameOverride`                                   | String to fully override quorumkeymanager.fullname template with a string                                              | `nil`                                         |
| `image.repository`                                   | Path to Orchestrate image                                                                                              | `docker.consensys.net/pub/quorum-key-manager` |
| `image.tag`                                          | Orchestrate image tag                                                                                                  | `latest`                                     |
| `image.pullPolicy`                                   | Orchestrate image pull policy                                                                                          | `IfNotPresent`                                |
| `imageCredentials.create`                            | If true, create a secret containing the image credentials                                                              | `false`                                       |
| `imageCredentials.name`                              | Name of the secret                                                                                                     | `existing-secret`                             |
| `imageCredentials.registry`                          | Docker registry where Quorum Key Manager images are stored                                                             | `docker.consensys.net`                        |
| `imageCredentials.username`                          | Username of the registry                                                                                               | `someone`                                     |
| `imageCredentials.password`                          | Password of the registry                                                                                               | `sillyness`                                   |
| `serviceAccount.create`                              | If true, create a service account                                                                                      | `false`                                       |
| `serviceAccount.annotations`                         | Annotations for service account                                                                                        | `{}`                                          |
| `serviceAccount.name`                                | The name of the service account to use. If not set and create is true, a name is generated using the fullname template | ``                                            |
| `podAnnotations`                                     | Annotations to add to the Quorum Key Manager's pods                                                                    | `{}`                                          |
| `podSecurityContext`                                 | Pod security context                                                                                                   | `{}`                                          |
| `securityContext`                                    | Container security context                                                                                             | `{}`                                          |
| `service.type`                                       | Kubernetes Service type                                                                                                | `ClusterIP`                                   |
| `service.http.port`                                  | Quorum Key Manager port                                                                                                | `8080`                                        |
| `service.metrics.port`                               | Quorum Key Manager metrics port                                                                                        | `8081`                                        |
| `ingress.enabled`                                    | Enable ingress controller resource                                                                                     | `false`                                       |
| `ingress.annotations`                                | Ingress annotations                                                                                                    | `{}`                                          |
| `ingress.hosts[0].host`                              | Hostname to your Quorum Key Manager                                                                                    | `qkm.local`                                   |
| `ingress.hosts[0].http.paths[0].path`                | Path within the url structure                                                                                          | `/`                                           |
| `ingress.hosts[0].http.paths[0].backend.servicePort` | Service port to serve                                                                                                  | `http-svc`                                    |
| `ingress.tls[0].secretName`                          | TLS Secret Name                                                                                                        | `nil`                                         |
| `ingress.tls[0].hosts`                               | Array of TLS hosts for ingress record                                                                                  | `[]`                                          |
| `resources.limits`                                   | The resources limits for Quorum Key Manager containers                                                                 | `{}`                                          |
| `resources.requests`                                 | The requested resources for Quorum Key Manager containers                                                              | `{}`                                          |
| `nodeSelector`                                       | Node labels for pod assignment                                                                                         | `{}`                                          |
| `tolerations`                                        | Tolerations for pod assignment                                                                                         | `[]`                                          |
| `affinity`                                           | Affinity for pod assignment                                                                                            | `{}`                                          |
| `environment`                                        | Environment variables passed to Quorum Key Manager containers                                                          | `{}`                                          |
| `environmentSecrets`                                 | Environment variables (as Kubernetes secrets) passed to Quorum Key Manager containers                                  | `{}`                                          |
| `vaultAgent.enabled`                                 | Run Vault Agent to retrieve the Key Manager client token from Hashicorp Vault                                          | `false`                                       |
| `vaultAgent.role`                                    | Role eligible to retrieve a token                                                                                      | `client`                                      |
| `vaultAgent.image.repository`                        | Hashicorp Vault image                                                                                                  | `vault`                                       |
| `vaultAgent.image.tag`                               | Hashicorp Vault tag                                                                                                    | `1.6.2`                                       |
| `vaultAgent.config.wrapTTL`                          | Response-wrapped TTL, see https://www.vaultproject.io/docs/agent/autoauth                                              | ``                                            |
| `manifests`                                          | List of manifests to be loaded by the Quorumm Key Manager                                                              | ``                                            |
