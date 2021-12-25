#!/bin/bash

## Download images from Dockerhub and load into the kind
ciliumMeshImage=("quay.io/cilium/cilium-service-mesh:v1.11.0-beta.1" "quay.io/cilium/operator-generic-service-mesh:v1.11.0-beta.1" "quay.io/cilium/hubble-relay-service-mesh:v1.11.0-beta.1")

for i in ${ciliumMeshImage[@]}
do
	docker pull $i
	kind load docker-image $i
done

cilium install --version -service-mesh:v1.11.0-beta.1 --config enable-envoy-config=true --kube-proxy-replacement=probe --agent-image='quay.io/cilium/cilium-service-mesh:v1.11.0-beta.1' --operator-image='quay.io/cilium/operator-generic-service-mesh:v1.11.0-beta.1'  --datapath-mode=vxlan

sleep 1

cilium status

sleep 1

cilium hubble enable --relay-image='quay.io/cilium/hubble-relay-service-mesh:v1.11.0-beta.1' --ui

sleep 1

bash ./kmesh-demo-lb.sh

docker pull hashicorp/http-echo:0.2.3

kind load docker-image hashicorp/http-echo:0.2.3

kubectl apply -f app.yaml

kubectl apply -f cilium-ingress.yaml

kubectl get svc

kubectl get ing

