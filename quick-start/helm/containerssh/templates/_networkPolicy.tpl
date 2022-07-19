{{ define "containerssh.guestNetworkPolicy" }}
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: {{ .Values.networkPolicy.name }}
  namespace: {{ .Values.networkPolicy.namespace }}
spec:
  {{- toYaml .Values.networkPolicy.spec | nindent 2}}
{{- end }}