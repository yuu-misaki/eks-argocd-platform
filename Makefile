
.PHONY: fastapi-init
fastapi-init:
	kubectl apply -f manifest/fastapi/namespace.yaml
	kubectl apply -f manifest/fastapi/service_account.yaml
	kubectl apply -f manifest/fastapi/ingress.yaml

.PHONY: fastapi-argocd-app
fastapi-argocd-app:
# IAMのデプロイ 
	kubectl apply -f manifest/fastapi/application.yaml

.PHONY: argocd-init
argocd-init:
	kubectl create namespace argocd
	kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

.PHONY: destroy-all
fastapi-destroy:
	kubectl delete namespace fastapi
	kubectl delete namespace argocd

.PHONY: argocd-port-forward
argocd-port-forward:
	kubectl port-forward svc/argocd-server -n argocd 8181:443
	
.PHONY: argocd-image-updater
argocd-image-updater:
# IAMのデプロイ 
	kubectl apply -k manifest/argocd_image_updater/


.PHONY: tf-init
tf-init:
	cd terraform && terraform init

.PHONY: tf-plan
tf-plan: 
	cd terraform && terraform plan

.PHONY: tf-apply
tf-apply: 
	cd terraform && terraform apply

.PHONY: tf-destroy
tf-destroy: 
	cd terraform && terraform destroy
