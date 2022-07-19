{{ define "containerssh.deployment" }}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "containerssh.fullname" . }}
  labels:
    {{- include "containerssh.labels" . | nindent 4 }}
spec:
  {{- if not .Values.autoscaling.enabled }}
  {{- with .Values.host }}
  replicas: {{ .replicaCount }}
  {{- end }}
  {{- end }}
  selector:
    matchLabels:
      {{- include "containerssh.selectorLabels" . | nindent 6 }}
  template:
    metadata:
      {{- with .Values.podAnnotations }}
      annotations:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      labels:
        {{- include "containerssh.selectorLabels" . | nindent 8 }}
    spec:
      {{- with .Values.imagePullSecrets }}
      imagePullSecrets:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      serviceAccountName: {{ include "containerssh.serviceAccountName" . }}
      {{- with .Values.host }}
      securityContext:
        {{- toYaml .podSecurityContext | nindent 8 }}
      {{- end}}
      containers:
        - name: {{ .Chart.Name }}
          {{- with .Values.host }}
          image: "{{ .image.repository }}{{ .image.tag }}"
          securityContext:
            {{- toYaml .securityContext | nindent 12 }}
          imagePullPolicy: {{ .image.pullPolicy }}
          {{- end }}
          ports:
            - name: http
              containerPort: {{ .Values.host.port.containerPort }}
              protocol: TCP
          {{- if .Values.secrets.env.create }}
          envFrom:
          - secretRef:
              name: {{ include "containerssh.fullname" . }}-secret
          {{- end }}
          {{- with .Values.host }}
          resources:
          {{- toYaml .resources | nindent 12 }}
          {{- end }}
          volumeMounts:
              # Mount the host key
            - name: hostkey
              mountPath: /etc/containerssh/host.key
              subPath: key
              readOnly: true
              # Mount the config file
            - name: config
              mountPath: /etc/containerssh/config.yaml
              readOnly: true
        # Run the auth-config test server for authentication
        {{- if .Values.host.sidecar_authserver.create }}
        {{- with .Values.host.sidecar_authserver }}
        - name: {{ .name }}
          image: {{ .image }}
          securityContext:
            {{- toYaml .securityContext | nindent 12 }}
        {{- end }}
        {{- end }}
      volumes:
        - name: hostkey
          secret:
            secretName: containerssh-hostkey
        - name: config
          configMap:
            name: containerssh-config
      {{- with .Values.nodeSelector }}
      nodeSelector:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .Values.affinity }}
      affinity:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .Values.tolerations }}
      tolerations:
        {{- toYaml . | nindent 8 }}
      {{- end }}
{{- end }}