{{ define "containerssh.configMap" }}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "containerssh.fullname" . }}-config
  namespace: {{ include "containerssh.namespace" . }}
data:
  {{ (.Files.Glob "config.yaml").AsConfig | nindent 2 }}
{{- end }}