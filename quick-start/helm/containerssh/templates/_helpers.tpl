{{/*
Expand the name of the chart.
*/}}
{{- define "containerssh.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "containerssh.fullname" -}}
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
{{- define "containerssh.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "containerssh.labels" -}}
helm.sh/chart: {{ include "containerssh.chart" . }}
{{ include "containerssh.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "containerssh.selectorLabels" -}}
app.kubernetes.io/name: {{ include "containerssh.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "containerssh.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "containerssh.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the namespaces.
*/}}
{{- define "containerssh.namespace" -}}
{{- if .Values.host.namespace }}
{{- default (include "containerssh.fullname" .) .Values.host.namespace }}
{{- end }}
{{- end }}

# {{/*
# Create the name of the host ssh-key to use
# */}}
# {{- define "containerssh.hostsshkey" -}}
# {{- if .Values.secrets.ssh.create }}
# {{- printf "%s-%s" .Release.Name "hostkey" }}
# {{- else }}
# {{- default "default" .Values.serviceAccount.name }}
# {{- end }}
# {{- end }}
