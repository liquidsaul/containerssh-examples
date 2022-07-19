{{ define "containerssh.role" }}
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: {{ .Values.role.name }}}
  namespace: {{ .Values.role.namespace }}
rules:
  {{- toYaml .Values.role.rules | nindent 2 }}
{{- end }}