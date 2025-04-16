FROM nvidia/cuda:12.4.1-devel-ubuntu22.04

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# hadolint ignore=DL3008
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update && apt-get install --no-install-recommends -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && rm -rf /var/lib/apt/lists/*

# hadolint ignore=DL3008
RUN apt-get update && apt-get install --no-install-recommends -y \
    curl \
    git \
    git-lfs \
    libgl1 \
    libglib2.0-0 \
    nano \
    python-is-python3 \
    python3-dev \
    python3-pip \
    ssh \
    tmux \
    vim \
    wget \
    && rm -rf /var/lib/apt/lists/*

# hadolint ignore=DL3013,DL3042
RUN --mount=type=cache,target=/root/.cache/pip \
    pip install torch torchvision torchaudio

USER $USERNAME
