{{/*
Expand the name of the chart.
*/}}
{{- define "libreddit.name" -}}
    {{ if .Values.nameOverride }}
        {{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
    {{ else }}
        {{- default .Chart.Name | trunc 63 | trimSuffix "-" -}}
    {{ end }}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "libreddit.fullname" -}}
    {{ if .Values.nameOverride }}
        {{- $name := default .Chart.Name .Values.nameOverride -}}
    {{ else }}       
        {{- $name := default .Chart.Name -}}
    {{ end }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
