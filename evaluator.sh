#!/bin/sh
# SPDX-License-Identifier: MIT

VERSION=0.1.0
RELEASE=$(uname -r)
WORKDIR=/projappl/${ACCOUNT:-undefined}/container-evaluator

# Print horizontal line
hline() {
    # shellcheck disable=SC2183
    printf "%80s\n" | tr " " "-"
}

# Print command and run it
cmd() {
    echo + "$*"
    eval "$*"
}

# Attempt to find the current kernel configuration
kconfig() {
    if [ -f "/proc/config.gz" ]; then
        zcat "/proc/config.gz"
    elif [ -f "/boot/config-$RELEASE" ]; then
        cat "/boot/config-$RELEASE"
    fi
}

# Execution
hline
echo "Container Evaluator v$VERSION"
date

hline
cmd mkdir -p "$WORKDIR" || exit 1
cmd cd "$WORKDIR" || exit 1

hline
cmd uname -a

hline
cmd 'lscpu | head -13'

hline
cmd 'kconfig | grep -E "USER_NS|NAMESPACES|CGROUP"'

hline
cmd whoami
cmd id

hline
cmd ls -l /etc/sysctl.conf /etc/sysctl.d

hline
cmd cat /etc/sysctl.conf

hline
cmd sysctl user

hline
cmd sysctl kernel.unprivileged_userns_clone

hline
cmd cat /etc/subuid
cmd cat /etc/subgid

hline
cmd ls /dev/kvm

if [ -n "${RUN_TESTS++}" ]; then
    hline
    cmd rm -rf apptainer apptainer-tmp
    cmd 'curl -fL https://raw.githubusercontent.com/apptainer/apptainer/main/tools/install-unprivileged.sh | bash -s - apptainer'
    export APPTAINER_TMPDIR="$WORKDIR/apptainer-tmp"
    cmd mkdir -p "$APPTAINER_TMPDIR"
    cmd ./apptainer/bin/apptainer run docker://sylabsio/lolcow:latest
    hline
    cmd 'curl -fL https://get.docker.com/rootless | sh'
    # TODO: Run tests with rootless Docker
    # TODO: Rootless Podman?
fi

hline
exit 0
