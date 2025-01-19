# VEX V5 Simulator GitHub Action

This project is a fork of the [VEX V5 Simulator](https://github.com/vexide/vex-v5-qemu) that is used as a GitHub Action.

To use this action, you can add the following steps to your GitHub Actions workflow:

```yaml
jobs:
  build-and-run:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4
      - name: Build project
        uses: jerrylum/pros-build@v2.0.0
        with:
          build_args: "all -j" # -j enables multi-threading
      - name: Run simulator
        uses: jerrylum/vex-v5-qemu-gh-action@main
```

# Build the Docker image locally

In addition, we also provide a Dockerfile for you to build and use the simulator via Docker locally.

To build the Docker image, run the following command:
```bash
docker build -f Dockerfile.local -t vex-v5-qemu .
```

Then, you can run the simulator with the following command:

```bash
docker run --rm -it -v "./bin/monolith.bin:/test.bin" vex-v5-qemu simulator monolith /test.bin
```
