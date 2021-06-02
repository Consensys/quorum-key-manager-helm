{{/*
Expand the name of the chart.
*/}}
{{- define "quorum-key-manager-helm.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "quorum-key-manager-helm.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "quorum-key-manager-helm.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common annotations
*/}}
{{- define "quorum-key-manager-helm.annotations" -}}
meta.helm.sh/release-name: {{ .Release.Name }}
meta.helm.sh/release-namespace: {{ .Release.Namespace }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "quorum-key-manager-helm.labels" -}}
helm.sh/chart: {{ include "quorum-key-manager-helm.chart" . }}
{{ include "quorum-key-manager-helm.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "quorum-key-manager-helm.selectorLabels" -}}
app.kubernetes.io/name: {{ include "quorum-key-manager-helm.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "quorum-key-manager-helm.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "quorum-key-manager-helm.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Define imageCredentials name.
*/}}
{{- define "quorum-key-manager-helm.imagePullSecretName" -}}
{{- if .Values.imageCredentials.create -}}
	{{ printf "%s-%s" (include "quorum-key-manager-helm.fullname" .) "registry" | trunc 63 | trimSuffix "-" }}
{{- else -}}
	{{ .Values.imageCredentials.name }}
{{- end -}}
{{- end -}}

{{- define "quorum-key-manager-helm.imagePullSecret" }}
{{- printf "{\"auths\": {\"%s\": {\"auth\": \"%s\"}}}" .Values.imageCredentials.registry (printf "%s:%s" .Values.imageCredentials.username .Values.imageCredentials.password | b64enc) | b64enc }}
{{- end }}
