{{ define "containerssh.namespaces" }}
apiVersion: v1
kind: Namespace
metadata:
  name: {{ include "containerssh.namespace" . }}
---
apiVersion: v1
kind: Namespace
metadata:
  name: {{ include "containerssh.namespace" . }}-guests
{{- end }}