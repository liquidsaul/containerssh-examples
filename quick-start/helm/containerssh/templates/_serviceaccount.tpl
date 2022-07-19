{{- define "containerssh.serviceAccount" }}
{{- if .Values.serviceAccount.create }}
apiVersion: v1
kind: ServiceAccount
metadata:
  name: {{ include "containerssh.serviceAccountName" . }}
  labels:
    {{- include "containerssh.labels" . | nindent 4 }}
  {{- with .Values.serviceAccount.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- if .Values.serviceAccount.automountServiceAccountToken }}
automountServiceAccountToken: {{ .Values.serviceAccount.automountServiceAccountToken }}
{{- end }}
{{- end }}
{{- end }}