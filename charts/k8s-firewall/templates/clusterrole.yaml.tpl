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
{{- if .Values.rbac.aiVisibility }}
  - apiGroups:
      - apps
    resources:
      - deployments
      - replicasets
      - statefulsets
      - daemonsets
    verbs:
      - get
      - list
      - watch
  - apiGroups:
      - batch
    resources:
      - jobs
      - cronjobs
    verbs:
      - get
      - list
      - watch
{{- end }}
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
{{- end }}
