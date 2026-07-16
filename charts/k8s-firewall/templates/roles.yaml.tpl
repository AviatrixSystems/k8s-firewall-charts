{{- if .Values.rbac.create }}
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: {{ .Values.role.name }}
rules:
  - apiGroups:
      - ""
    resources:
      - nodes
      - pods
      - services
      - namespaces
    verbs:
      - get
      - list
      - watch
  - apiGroups:
      - discovery.k8s.io
    resources:
      - endpointslices
    verbs:
      - get
      - list
      - watch
  - apiGroups:
      - events.k8s.io
    resources:
      - events
    verbs:
      - create
      - patch
  - apiGroups:
      - networking.aviatrix.com
    resources:
      - "*"
    verbs:
      - update
      - patch
      - get
      - list
      - watch
{{- if .Values.rbac.manageNetworkPolicies }}
  - apiGroups:
      - networking.k8s.io
    resources:
      - networkpolicies
    verbs:
      - get
      - list
      - watch
      - create
      - update
      - patch
      - delete
{{- end }}
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