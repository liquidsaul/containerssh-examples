{{ define "containerssh.service" }}
apiVersion: v1
kind: Service
metadata:
  name: {{ include "containerssh.fullname" . }}
  labels:
    {{- include "containerssh.labels" . | nindent 4 }}
  namespace: {{ include "containerssh.namespace" . }}
spec:
  type: {{ .Values.service.type }}
  ports:
    - name: ssh 
      port: {{ .Values.service.port }}
      targetPort: 2222
      protocol: TCP
  selector:
    {{- include "containerssh.selectorLabels" . | nindent 4 }}
{{- end }}