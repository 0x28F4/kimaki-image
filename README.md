# kimaki-image

Docker image for running [kimaki](https://github.com/remorses/kimaki) + [opencode](https://opencode.ai) agents.

Ubuntu 24.04 with Node 22, pnpm, bun, gh, python3, git, ripgrep, and common dev tools pre-installed.

## Usage

```
docker pull ghcr.io/0x28f4/kimaki-image:latest
docker run -it ghcr.io/0x28f4/kimaki-image
```

## Build locally

```
docker build -t kimaki-image .
```
