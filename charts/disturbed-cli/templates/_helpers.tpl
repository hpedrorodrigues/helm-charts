{{/* Expand the name of the chart. */}}
{{- define "disturbed.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/* Expand the version of the chart. */}}
{{- define "disturbed.version" -}}
{{ .Chart.AppVersion | quote }}
{{- end }}

{{/* Expand the name and version of the chart. */}}
{{- define "disturbed.chart" -}}
{{ .Chart.Name }}-{{ .Chart.Version }}
{{- end }}

{{/* Common labels. */}}
{{- define "disturbed.labels" -}}
app.kubernetes.io/name: {{ include "disturbed.name" . }}
app.kubernetes.io/version: {{ include "disturbed.version" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
helm.sh/chart: {{ include "disturbed.chart" . }}
{{- if .Values.commonLabels }}
{{ toYaml .Values.commonLabels }}
{{- end }}
{{- end }}

{{/* Image. */}}
{{- define "disturbed.image" -}}
{{- $image := .Values.image.repository -}}
{{- $version := default .Chart.AppVersion .Values.image.tag -}}
{{- printf "%s:%s"  $image $version -}}
{{- end }}
