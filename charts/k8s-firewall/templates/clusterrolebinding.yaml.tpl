{{- if .Values.rbac.create }}
---
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: {{ .Values.role.name }}
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: {{ .Values.role.name }}
subjects:
{{- if .Values.role.subject }}
  - kind: {{ .Values.role.subject.kind }}
    name: {{ .Values.role.subject.name }}
{{- if and (eq .Values.role.subject.kind "ServiceAccount") .Values.role.subject.namespace }}
    namespace: {{ .Values.role.subject.namespace }}
{{- end }}
{{- end }}
{{- if .Values.serviceAccount.create }}
  - kind: ServiceAccount
    name: {{ .Values.serviceAccount.name }}
    namespace: {{ .Release.Namespace }}
{{- end }}
{{- end }}
