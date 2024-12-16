ARG VARIANT="1-3.11-bullseye"

FROM mcr.microsoft.com/vscode/devcontainers/python:${VARIANT}

RUN apt update && apt install -y \
    bash-completion \
    dnsutils \
    default-jre

# kubectlのインストール
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256" && \
    echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm -f kubectl

# k9sのインストール
RUN curl -sS https://webinstall.dev/k9s | bash && \
    bash -c "source ~/.config/envman/PATH.env"

# kustomizeのインストール
RUN curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash

# Install Terraform
ARG TF_VERSION=1.9.8
RUN wget https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip \
    && unzip ./terraform_${TF_VERSION}_linux_amd64.zip -d /usr/local/bin/ \
    && rm -rf ./terraform_${TF_VERSION}_linux_amd64.zip

# argocd cliのインストール
RUN curl -sSL -o argocd-linux-arm64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-arm64 && \
    sudo install -m 555 argocd-linux-arm64 /usr/local/bin/argocd && \
    rm argocd-linux-arm64