#!/usr/local/bin/bash -eux
#
# this script posts a fake "location" cloud event to set up a "constellation" location.
# It assumes you have a view or full TAP cluster targeted as your current context.
#
TOKEN=$(kubectl create token -n amr-observer-system amr-observer-editor)
CLOUD_EVENT_SINK=$(kubectl get httpproxy -n metadata-store amr-cloudevent-handler-ingress -ojson | jq -r .spec.virtualhost.fqdn)
PAYLOAD=$(cat <<EOF
{
  "specversion": "1.0",
  "id": "constellation-location",
  "source": "tekton-task",
  "type": "vmware.tanzu.apps.location.created.v1",
  "contentType": "application/json",
  "data": {
    "reference": "constellation",
    "labels": [
      {
        "key": "env",
        "value": "constellation"
      }
    ]
  }
}
EOF
)

curl -k -X POST \
  -H "Content-Type: application/cloudevents+json" \
  -H "Authorization: Bearer ${TOKEN}" \
  -d "${PAYLOAD}" \
  https://${CLOUD_EVENT_SINK}

PAYLOAD=$(cat <<EOF
{
  "specversion": "1.0",
  "id": "container-running-19153",
  "source": "constellation",
  "type": "vmware.tanzu.apps.container.running.v1",
  "contentType": "application/json",
  "data": {
    "correlationId":"https://github.com/scothis/spring-petclinic.git?sub_path=/",
    "timestamp":"2023-11-16T20:54:59Z",
    "imageUrl":"us-west2-docker.pkg.dev/shepherd-v2-environment-1/sh2-rake-304330-oci-registry/workloads/petclinic-my-apps",
    "imageDigest":"sha256:efc3c93515d71cade88325fc1349d79e0341bf69698dc21c829aa92c0c8d6ab1",
    "name":"container-running-19153",
    "namespace":"not-a-real-namespace",
    "state":"running"
  }
}
EOF
)

curl -k -X POST \
  -H "Content-Type: application/cloudevents+json" \
  -H "Authorization: Bearer ${TOKEN}" \
  -d "${PAYLOAD}" \
  https://${CLOUD_EVENT_SINK}
