---
{{- define "crontab.name" -}}
{{- default .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "crontab.version" -}}
version: "{{ .Chart.Version }}+{{ .Release.Time.Seconds }}"
{{- end -}}

{{- define "crontab.label_base" -}}
app: {{ include "crontab.name" . | quote }}
app.kubernetes.io/name: {{ include "crontab.name" . | quote }}
{{- end -}}

{{- define "crontab.label_chart" -}}
helm.sh/chart: {{- printf "%s-%s" .Chart.Name .Chart.Version | trunc 63 | trimSuffix "-" -}}
app.kubernetes.io/instance: {{ .Release.Name | trunc 63 | trimSuffix "-" }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}
