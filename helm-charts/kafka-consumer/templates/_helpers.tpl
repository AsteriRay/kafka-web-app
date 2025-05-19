{{- define "kafka-consumer.name" -}}
kafka-consumer
{{- end }}

{{- define "kafka-consumer.fullname" -}}
{{ .Release.Name }}-{{ include "kafka-consumer.name" . }}
{{- end }}
