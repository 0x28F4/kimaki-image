FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Core dev tools
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    build-essential \
    ca-certificates \
    gnupg \
    unzip \
    tar \
    jq \
    ripgrep \
    fd-find \
    tree \
    htop \
    sudo \
    openssh-client \
    python3 \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

# Node.js (LTS) via NodeSource
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# pnpm + bun
RUN npm install -g pnpm \
    && curl -fsSL https://bun.sh/install | bash

# GitHub CLI
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
    | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update && apt-get install -y gh \
    && rm -rf /var/lib/apt/lists/*

# Install opencode
RUN curl -fsSL https://opencode.ai/install | bash

# Install kimaki
RUN npm install -g kimaki@latest

# Add opencode + bun to PATH
ENV PATH="/root/.opencode/bin:/root/.bun/bin:${PATH}"

# Git config defaults
RUN git config --global init.defaultBranch main \
    && git config --global user.email "agent@kimaki" \
    && git config --global user.name "Kimaki Agent"

WORKDIR /projects

CMD ["kimaki"]
