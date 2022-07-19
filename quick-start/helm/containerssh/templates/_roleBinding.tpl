{{ define "containerssh.roleBinding" }}
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: {{ .Values.rolebinding.name  }}
  namespace: {{ .Values.rolebinding.namespace  }}
roleRef:
  {{- toYaml .Values.rolebinding.roleRef | nindent 2 }}
subjects:
  {{- toYaml .Values.rolebinding.subjects | nindent 2 }}
{{- end }}