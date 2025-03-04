FROM rust:1.83-bullseye AS rust-builder

FROM rust-builder AS simulator

RUN mkdir /vex-v5-qemu                                                                              \
  && curl -L --output                                                                               \
  -H "Accept: application/vnd.github+json"                                                          \
  -H "X-GitHub-Api-Version: 2022-11-28"                                                             \
  https://api.github.com/repos/vexide/vex-v5-qemu/tarball/f9a57b3516fdda27c5c9fc4d02128882e45e3ee9  \
  | tar zxf - -C /vex-v5-qemu --strip-components=1

WORKDIR /vex-v5-qemu
RUN cd packages/kernel; cargo build --target-dir /target/kernel

RUN cd packages/client-cli; cargo install --path . --root /target/client-cli

FROM debian:bullseye-slim AS runner

# Install qemu
RUN apt-get update
RUN apt-get -y install qemu-system
RUN apt-get clean # Cleanup image

# Copy the sim kernel, as its required to run the simulator
ENV V5_SIM_PATH="/.vex-v5-qemu"
ENV V5_SIM_KERNEL_PATH="$V5_SIM_PATH/kernel"
COPY --from=simulator /target/kernel/armv7a-none-eabi/debug/kernel $V5_SIM_KERNEL_PATH
COPY --from=simulator /target/client-cli/bin/client-cli /usr/local/bin/simulator

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
