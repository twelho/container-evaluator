# Container Evaluator

Container support evaluation tool, made for HPC/supercomputer environments. When dispatched as a workload, gathers node information, configuration and environment, and attempts to evaluate support for running various (rootless) container runtimes. Optimized for [CSC's](https://csc.fi/) supercomputing platforms.

## Usage

```shell
export ACCOUNT=project_123 # Enter your Slurm account here
RUN_TESTS= ./run.sh # Set RUN_TESTS= to also run tests with container runtimes
```

Alternatively, to just run on the login node:

```shell
export ACCOUNT=project_123 # Enter your Slurm account here (optional)
RUN_TESTS= ./evaluator.sh # Set RUN_TESTS= to also run tests with container runtimes
```

## Results

(Redacted) logs of Container Evaluator runs on [CSC's](https://csc.fi/) supercomputers, highlighting the lack of proper OCI container runtime support on all evaluated platforms.

<details>
<summary> <a href="https://docs.csc.fi/computing/systems-puhti/">Puhti</a> supercomputer</summary>

```
--------------------------------------------------------------------------------
Container Evaluator v0.1.0
Mon Sep  8 17:47:12 EEST 2025
--------------------------------------------------------------------------------
+ mkdir -p /projappl/project_XXXXXXX/container-evaluator-tmp
+ cd /projappl/project_XXXXXXX/container-evaluator-tmp
--------------------------------------------------------------------------------
+ uname -a
Linux r18c37.bullx 4.18.0-553.63.1.el8_10.x86_64 #1 SMP Thu Jul 24 11:45:38 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
--------------------------------------------------------------------------------
+ lscpu | head -13
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
CPU(s):              40
On-line CPU(s) list: 0-39
Thread(s) per core:  1
Core(s) per socket:  20
Socket(s):           2
NUMA node(s):        2
Vendor ID:           GenuineIntel
CPU family:          6
Model:               85
Model name:          Intel(R) Xeon(R) Gold 6230 CPU @ 2.10GHz
--------------------------------------------------------------------------------
+ hostnamectl status
--------------------------------------------------------------------------------
+ systemd-detect-virt
none
--------------------------------------------------------------------------------
+ kconfig | grep -E "USER_NS|NAMESPACES|CGROUP"
CONFIG_CGROUPS=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_USER_NS=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_CGROUP_IOLATENCY=y
CONFIG_BLK_CGROUP_FC_APPID=y
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
# CONFIG_BFQ_CGROUP_DEBUG is not set
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
--------------------------------------------------------------------------------
+ ls -l /etc/sysctl.conf /etc/sysctl.d
-rw-r--r--  1 root root 1432 Aug 12 12:07 /etc/sysctl.conf

/etc/sysctl.d:
total 12
-rwxr-x---. 1 root root  59 May 24  2022 01-csc-dmesg.conf
-rw-r--r--. 1 root root 748 Aug  7 15:18 80-es-multi-rail.conf
-rw-r--r--. 1 root root  30 Sep 13  2022 90-csc-coredump.conf
lrwxrwxrwx. 1 root root  14 Apr 22 11:54 99-sysctl.conf -> ../sysctl.conf
--------------------------------------------------------------------------------
+ cat /etc/sysctl.conf
# sysctl settings are defined through files in
# /usr/lib/sysctl.d/, /run/sysctl.d/, and /etc/sysctl.d/.
#
# Vendors settings live in /usr/lib/sysctl.d/.
# To override a whole file, create a new file with the same in
# /etc/sysctl.d/ and put new settings there. To override
# only specific settings, add a file with a lexically later
# name in /etc/sysctl.d/ and put new settings there.
#
# For more information, see sysctl.conf(5) and sysctl.d(5).
# vm.min_free_kbytes: New value of vm.min_free_kbytes for keep minimum reserved memory.
vm.min_free_kbytes = 1048576
net.ipv4.neigh.default.gc_thresh2 = 8192
# net.ipv4.neigh.default.gc_thresh1: Increase the arp cache parameters of the kernel
net.ipv4.neigh.default.gc_thresh1 = 4096
net.ipv4.neigh.default.gc_stale_time = 86400
kernel.shmall = 4294967296
net.ipv4.neigh.default.base_reachable_time_ms = 86400000
# kernel.sem: New default value of kernel.sem
kernel.sem = 250 32000 32 256
# kernel.shmmax: New default value of kernel.shmmax for shared memory segment
kernel.shmmax = 68719476736
net.ipv4.conf.default.arp_ignore = 2
net.ipv4.neigh.default.gc_thresh3 = 8192
kernel.unknown_nmi_panic = 0
# kernel.panic_print: Print reason for kernel panic
kernel.panic_print = 1
# user.max_user_namespaces: Disable user ns, it is used in many exploits
user.max_user_namespaces = 0
# user.max_net_namespaces: Disable user net ns, it is used in many exploits
user.max_net_namespaces = 0
--------------------------------------------------------------------------------
+ cat /etc/sysctl.d/01-csc-dmesg.conf /etc/sysctl.d/80-es-multi-rail.conf /etc/sysctl.d/90-csc-coredump.conf /etc/sysctl.d/99-sysctl.conf
kernel.core_pattern = core.%p
kernel.panic_print = 1
kernel.sem = 250 32000 32 256
kernel.shmall = 4294967296
kernel.shmmax = 68719476736
kernel.unknown_nmi_panic = 0
net.ipv4.conf.all.accept_local = 1
net.ipv4.conf.all.arp_announce = 2
net.ipv4.conf.all.arp_filter = 0
net.ipv4.conf.all.arp_ignore = 1
net.ipv4.conf.all.rp_filter = 0
net.ipv4.conf.default.accept_local = 1
net.ipv4.conf.default.arp_announce = 2
net.ipv4.conf.default.arp_filter = 0
net.ipv4.conf.default.arp_ignore = 1
net.ipv4.conf.default.arp_ignore = 2
net.ipv4.conf.default.rp_filter = 0
net.ipv4.neigh.default.base_reachable_time_ms = 86400000
net.ipv4.neigh.default.gc_stale_time = 86400
net.ipv4.neigh.default.gc_thresh1 = 4096
net.ipv4.neigh.default.gc_thresh2 = 8192
net.ipv4.neigh.default.gc_thresh3 = 8192
user.max_net_namespaces = 0
user.max_user_namespaces = 0
vm.min_free_kbytes = 1048576
--------------------------------------------------------------------------------
+ sysctl user
user.max_cgroup_namespaces = 766058
user.max_inotify_instances = 128
user.max_inotify_watches = 1048576
user.max_ipc_namespaces = 766058
user.max_mnt_namespaces = 766058
user.max_net_namespaces = 0
user.max_pid_namespaces = 766058
user.max_time_namespaces = 766058
user.max_user_namespaces = 0
user.max_uts_namespaces = 766058
--------------------------------------------------------------------------------
+ sysctl kernel.unprivileged_userns_clone
--------------------------------------------------------------------------------
+ cat /etc/subuid
+ cat /etc/subgid
--------------------------------------------------------------------------------
+ ls /dev/kvm
--------------------------------------------------------------------------------
+ cat /etc/apptainer/apptainer.conf
# APPTAINER.CONF
# This is the global configuration file for Apptainer. This file controls
# what the container is allowed to do on a particular host, and as a result
# this file must be owned by root.

# ALLOW SETUID: [BOOL]
# DEFAULT: yes
# Should we allow users to utilize the setuid program flow within Apptainer?
# note1: This is the default mode, and to utilize all features, this option
# must be enabled.  For example, without this option loop mounts of image 
# files will not work; only sandbox image directories, which do not need loop
# mounts, will work (subject to note 2).
# note2: If this option is disabled, it will rely on unprivileged user
# namespaces which have not been integrated equally between different Linux
# distributions.
allow setuid = yes

# MAX LOOP DEVICES: [INT]
# DEFAULT: 256
# Set the maximum number of loop devices that Apptainer should ever attempt
# to utilize.
max loop devices = 1024

# ALLOW PID NS: [BOOL]
# DEFAULT: yes
# Should we allow users to request the PID namespace? Note that for some HPC
# resources, the PID namespace may confuse the resource manager and break how
# some MPI implementations utilize shared memory. (note, on some older
# systems, the PID namespace is always used)
allow pid ns = yes

# CONFIG PASSWD: [BOOL]
# DEFAULT: yes
# If /etc/passwd exists within the container, this will automatically append
# an entry for the calling user.
config passwd = yes

# CONFIG GROUP: [BOOL]
# DEFAULT: yes
# If /etc/group exists within the container, this will automatically append
# group entries for the calling user.
config group = yes

# CONFIG RESOLV_CONF: [BOOL]
# DEFAULT: yes
# If there is a bind point within the container, use the host's
# /etc/resolv.conf.
config resolv_conf = yes

# MOUNT PROC: [BOOL]
# DEFAULT: yes
# Should we automatically bind mount /proc within the container?
mount proc = yes

# MOUNT SYS: [BOOL]
# DEFAULT: yes
# Should we automatically bind mount /sys within the container?
mount sys = yes

# MOUNT DEV: [yes/no/minimal]
# DEFAULT: yes
# Should we automatically bind mount /dev within the container? If 'minimal'
# is chosen, then only 'null', 'zero', 'random', 'urandom', and 'shm' will
# be included (the same effect as the --contain options)
mount dev = yes

# MOUNT DEVPTS: [BOOL]
# DEFAULT: yes
# Should we mount a new instance of devpts if there is a 'minimal'
# /dev, or -C is passed?  Note, this requires that your kernel was
# configured with CONFIG_DEVPTS_MULTIPLE_INSTANCES=y, or that you're
# running kernel 4.7 or newer.
mount devpts = yes

# MOUNT HOME: [BOOL]
# DEFAULT: yes
# Should we automatically determine the calling user's home directory and
# attempt to mount it's base path into the container? If the --contain option
# is used, the home directory will be created within the session directory or
# can be overridden with the APPTAINER_HOME or APPTAINER_WORKDIR
# environment variables (or their corresponding command line options).
mount home = no

# MOUNT TMP: [BOOL]
# DEFAULT: yes
# Should we automatically bind mount /tmp and /var/tmp into the container? If
# the --contain option is used, both tmp locations will be created in the
# session directory or can be specified via the  APPTAINER_WORKDIR
# environment variable (or the --workingdir command line option).
mount tmp = yes

# MOUNT HOSTFS: [BOOL]
# DEFAULT: no
# Probe for all mounted file systems that are mounted on the host, and bind
# those into the container?
mount hostfs = no

# BIND PATH: [STRING]
# DEFAULT: Undefined
# Define a list of files/directories that should be made available from within
# the container. The file or directory must exist within the container on
# which to attach to. you can specify a different source and destination
# path (respectively) with a colon; otherwise source and dest are the same.
# NOTE: these are ignored if apptainer is invoked with --contain except
# for /etc/hosts and /etc/localtime. When invoked with --contain and --net,
# /etc/hosts would contain a default generated content for localhost resolution.
#bind path = /etc/apptainer/default-nsswitch.conf:/etc/nsswitch.conf
#bind path = /opt
#bind path = /scratch
bind path = /etc/localtime
bind path = /etc/hosts

# USER BIND CONTROL: [BOOL]
# DEFAULT: yes
# Allow users to influence and/or define bind points at runtime? This will allow
# users to specify bind points, scratch and tmp locations. (note: User bind
# control is only allowed if the host also supports PR_SET_NO_NEW_PRIVS)
user bind control = yes

# ENABLE FUSEMOUNT: [BOOL]
# DEFAULT: yes
# Allow users to mount fuse filesystems inside containers with the --fusemount
# command line option.
enable fusemount = yes

# ENABLE OVERLAY: [yes/no/driver/try]
# DEFAULT: yes
# Enabling this option will make it possible to specify bind paths to locations
# that do not currently exist within the container.  If 'yes', kernel overlayfs
# will be tried but if it doesn't work, the image driver (i.e. fuse-overlayfs)
# will be used instead.  'try' is obsolete and treated the same as 'yes'.
# If 'driver' is chosen, overlay will always be handled by the image driver.
# If 'no' is chosen, then no overlay type will be used for missing bind paths
# nor for any other purpose.
# The ENABLE UNDERLAY 'preferred' option below overrides this option for
# creating bind paths.
enable overlay = yes

# ENABLE UNDERLAY: [yes/no/preferred]
# DEFAULT: yes
# Enabling this option will make it possible to specify bind paths to locations
# that do not currently exist within the container without using any overlay
# feature, when the '--underlay' action option is given by the user or when
# the ENABLE OVERLAY option above is set to 'no'.
# If 'preferred' is chosen, then underlay will always be used instead of
# overlay for creating bind paths.
# This option is deprecated and will be removed in a future release, because
# the implementation is complicated and the performance is similar to
# overlayfs and fuse-overlayfs.
enable underlay = yes

# MOUNT SLAVE: [BOOL]
# DEFAULT: yes
# Should we automatically propagate file-system changes from the host?
# This should be set to 'yes' when autofs mounts in the system should
# show up in the container.
mount slave = yes

# SESSIONDIR MAXSIZE: [STRING]
# DEFAULT: 64
# This specifies how large the default sessiondir should be (in MB). It will
# affect users who use the "--contain" options and don't also specify a
# location to do default read/writes to (e.g. "--workdir" or "--home") and
# it will also affect users of "--writable-tmpfs".
sessiondir max size = 64

# *****************************************************************************
# WARNING
#
# The 'limit container' and 'allow container' directives are not effective if
# unprivileged user namespaces are enabled. They are only effectively applied
# when Apptainer is running using the native runtime in setuid mode, and
# unprivileged container execution is not possible on the host.
#
# You must disable unprivileged user namespace creation on the host if you rely
# on the these directives to limit container execution.
#
# See the 'Security' and 'Configuration Files' sections of the Admin Guide for
# more information.
# *****************************************************************************

# LIMIT CONTAINER OWNERS: [STRING]
# DEFAULT: NULL
# Only allow containers to be used that are owned by a given user. If this
# configuration is undefined (commented or set to NULL), all containers are
# allowed to be used. 
#
# Only effective in setuid mode, with unprivileged user namespace creation
# disabled.  Ignored for the root user.
#limit container owners = gmk, apptainer, nobody


# LIMIT CONTAINER GROUPS: [STRING]
# DEFAULT: NULL
# Only allow containers to be used that are owned by a given group. If this
# configuration is undefined (commented or set to NULL), all containers are
# allowed to be used.
#
# Only effective in setuid mode, with unprivileged user namespace creation
# disabled.  Ignored for the root user.
#limit container groups = group1, apptainer, nobody


# LIMIT CONTAINER PATHS: [STRING]
# DEFAULT: NULL
# Only allow containers to be used that are located within an allowed path
# prefix. If this configuration is undefined (commented or set to NULL),
# containers will be allowed to run from anywhere on the file system.
#
# Only effective in setuid mode, with unprivileged user namespace creation
# disabled.  Ignored for the root user.
#limit container paths = /scratch, /tmp, /global


# ALLOW CONTAINER ${TYPE}: [BOOL]
# DEFAULT: yes
# This feature limits what kind of containers that Apptainer will allow
# users to use.
#
# Only effective in setuid mode, with unprivileged user namespace creation
# disabled.  Ignored for the root user. Note that some of the
# same operations can be limited in setuid mode by the ALLOW SETUID-MOUNT
# feature below; both types need to be "yes" to be allowed.
#
# Allow use of unencrypted SIF containers
allow container sif = yes
#
# Allow use of encrypted SIF containers
allow container encrypted = yes
#
# Allow use of non-SIF image formats
allow container squashfs = yes
allow container extfs = yes
allow container dir = yes

# ALLOW SETUID-MOUNT ${TYPE}: [see specific types below]
# This feature limits what types of kernel mounts that Apptainer will
# allow unprivileged users to use in setuid mode.  Note that some of
# the same operations can also be limited by the ALLOW CONTAINER feature
# above; both types need to be "yes" to be allowed.  Ignored for the root
# user.
#
# ALLOW SETUID-MOUNT ENCRYPTED: [BOOL}
# DEFAULT: yes
# Allow mounting of SIF encryption using the kernel device-mapper in
# setuid mode.  If set to "no", gocryptfs (FUSE-based) encryption will be
# used instead, which uses a different format in the SIF file, the same
# format used in unprivileged user namespace mode.
allow setuid-mount encrypted = no
#
# ALLOW SETUID-MOUNT SQUASHFS: [yes/no/iflimited]
# DEFAULT: iflimited
# Allow mounting of squashfs filesystem types by the kernel in setuid mode,
# both inside and outside of SIF files.  If set to "no", a FUSE-based
# alternative will be used, the same one used in unprivileged user namespace
# mode.  If set to "iflimited" (the default), then if either a LIMIT CONTAINER
# option is used above or the Execution Control List (ECL) feature is activated
# in ecl.toml, this setting will be treated as "yes", and otherwise it will be
# treated as "no". 
# WARNING: in setuid mode a "yes" here while still allowing users write
# access to the underlying filesystem data enables potential attacks on
# the kernel.  On the other hand, a "no" here while attempting to limit
# users to running only approved containers enables the users to potentially
# override those limits using ptrace() functionality since the FUSE processes
# run under the user's own uid.  So leaving this on the default setting is
# advised.
# allow setuid-mount squashfs = iflimited
#
# ALLOW SETUID-MOUNT EXTFS: [BOOL]
# DEFAULT: no
# Allow mounting of extfs filesystem types by the kernel in setuid mode, both
# inside and outside of SIF files.  If set to "no", a FUSE-based alternative
# will be used, the same one used in unprivileged user namespace mode.
# WARNING: this filesystem type frequently has relevant kernel CVEs that take
# a long time for vendors to patch because they are not considered to be High
# severity since normally unprivileged users do not have write access to the
# raw filesystem data.  That leaves the kernel vulnerable to attack when
# this option is enabled in setuid mode. That is why this option defaults to
# "no".  Change it at your own risk.
# allow setuid-mount extfs = no

# ALLOW NET USERS: [STRING]
# DEFAULT: NULL
# Allow specified root administered CNI network configurations to be used by the
# specified list of users. By default only root may use CNI configuration,
# except in the case of a fakeroot execution where only 40_fakeroot.conflist
# is used. This feature only applies when Apptainer is running in
# SUID mode and the user is non-root.
#allow net users = gmk, apptainer


# ALLOW NET GROUPS: [STRING]
# DEFAULT: NULL
# Allow specified root administered CNI network configurations to be used by the
# specified list of users. By default only root may use CNI configuration,
# except in the case of a fakeroot execution where only 40_fakeroot.conflist
# is used. This feature only applies when Apptainer is running in
# SUID mode and the user is non-root.
#allow net groups = group1, apptainer


# ALLOW NET NETWORKS: [STRING]
# DEFAULT: NULL
# Specify the names of CNI network configurations that may be used by users and
# groups listed in the allow net users / allow net groups directives. Thus feature
# only applies when Apptainer is running in SUID mode and the user is non-root.
#allow net networks = bridge


# ALWAYS USE NV ${TYPE}: [BOOL]
# DEFAULT: no
# This feature allows an administrator to determine that every action command
# should be executed implicitly with the --nv option (useful for GPU only 
# environments). 
always use nv = no

# USE NVIDIA-NVIDIA-CONTAINER-CLI ${TYPE}: [BOOL]
# DEFAULT: no
# EXPERIMENTAL
# If set to yes, Apptainer will attempt to use nvidia-container-cli to setup
# GPUs within a container when the --nv flag is enabled.
# If no (default), the legacy binding of entries in nvbliblist.conf will be performed.
use nvidia-container-cli = no

# ALWAYS USE ROCM ${TYPE}: [BOOL]
# DEFAULT: no
# This feature allows an administrator to determine that every action command
# should be executed implicitly with the --rocm option (useful for GPU only
# environments).
always use rocm = no

# ROOT DEFAULT CAPABILITIES: [full/file/no]
# DEFAULT: full
# Define default root capability set kept during runtime
# - full: keep all capabilities (same as --keep-privs)
# - file: keep capabilities configured for root in
#         ${prefix}/etc/apptainer/capability.json
# - no: no capabilities (same as --no-privs)
root default capabilities = full

# MEMORY FS TYPE: [tmpfs/ramfs]
# DEFAULT: tmpfs
# This feature allow to choose temporary filesystem type used by Apptainer.
# Cray CLE 5 and 6 up to CLE 6.0.UP05 there is an issue (kernel panic) when Apptainer
# use tmpfs, so on affected version it's recommended to set this value to ramfs to avoid
# kernel panic
memory fs type = tmpfs

# CNI CONFIGURATION PATH: [STRING]
# DEFAULT: Undefined
# Defines path where CNI configuration files are stored
#cni configuration path =

# CNI PLUGIN PATH: [STRING]
# DEFAULT: Undefined
# Defines path where CNI executable plugins are stored
#cni plugin path =


# BINARY PATH: [STRING]
# DEFAULT: $PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
# Colon-separated list of directories to search for many binaries.  May include
# "$PATH:", which will be replaced by the user's PATH when not running a binary
# that may be run with elevated privileges from the setuid program flow.  The
# internal bin ${prefix}/libexec/apptainer/bin is always included, either at the
# beginning of "$PATH:" if it is present or at the very beginning if "$PATH:" is
# not present.
# binary path = 

# MKSQUASHFS PROCS: [UINT]
# DEFAULT: 0 (All CPUs)
# This allows the administrator to specify the number of CPUs for mksquashfs 
# to use when building an image.  The fewer processors the longer it takes.
# To enable it to use all available CPU's set this to 0.
# mksquashfs procs = 0
mksquashfs procs = 0

# MKSQUASHFS MEM: [STRING]
# DEFAULT: Unlimited
# This allows the administrator to set the maximum amount of memory for mkswapfs
# to use when building an image.  e.g. 1G for 1gb or 500M for 500mb. Restricting memory
# can have a major impact on the time it takes mksquashfs to create the image.
# NOTE: This functionality did not exist in squashfs-tools prior to version 4.3
# If using an earlier version you should not set this.
mksquashfs mem = 1G


# SHARED LOOP DEVICES: [BOOL]
# DEFAULT: no
# Allow to share same images associated with loop devices to minimize loop
# usage and optimize kernel cache (useful for MPI)
shared loop devices = yes

# IMAGE DRIVER: [STRING]
# DEFAULT: Undefined
# This option specifies the name of an image driver provided by a plugin that
# will be used to handle image mounts. This will override the builtin image
# driver which provides unprivileged image mounts for squashfs, extfs, 
# overlayfs, and gocryptfs.  The overlayfs image driver will only be used
# if the kernel overlayfs is not usable, but if the 'enable overlay' option
# above is set to 'driver', the image driver will always be used for overlay.
# If the driver name specified has not been registered via a plugin installation
# the run-time will abort.
image driver = 

# DOWNLOAD CONCURRENCY: [UINT]
# DEFAULT: 3
# This option specifies how many concurrent streams when downloading (pulling)
# an image from cloud library.
download concurrency = 3

# DOWNLOAD PART SIZE: [UINT]
# DEFAULT: 5242880
# This option specifies the size of each part when concurrent downloads are
# enabled.
download part size = 5242880

# DOWNLOAD BUFFER SIZE: [UINT]
# DEFAULT: 32768
# This option specifies the transfer buffer size when concurrent downloads
# are enabled.
download buffer size = 32768

# SYSTEMD CGROUPS: [BOOL]
# DEFAULT: yes
# Whether to use systemd to manage container cgroups. Required for rootless cgroups
# functionality. 'no' will manage cgroups directly via cgroupfs.
systemd cgroups = yes

# APPTHEUS SOCKET PATH: [STRING]
# DEFAULT: /run/apptheus/gateway.sock
# Defines apptheus socket path
apptheus socket path = /run/apptheus/gateway.sock

# ALLOW MONITORING: [BOOL]
# DEFAULT: no
# Allow to monitor the system resource usage of apptainer. To enable this option
# additional tool, i.e. apptheus, is required.
allow monitoring = no
--------------------------------------------------------------------------------
+ cat /etc/apptainer/rocmliblist.conf
# ROCMLIBLIST.CONF
# This configuration file determines which ROCm libraries to search for on the
# host system when the --rocm option is invoked.  You can edit it if you have
# different libraries on your host system.  You can also add binaries and they
# will be mounted into the container when the --rocm option is passed.

# put binaries here
# In shared environments you should ensure that permissions on these files 
# exclude writing by non-privileged users.  
rocm-smi
rocminfo

# put libs here (must end in .so)
libamd_comgr.so
libcomgr.so
libCXLActivityLogger.so
libelf.so
libhc_am.so
libhipblas.so
libhip_hcc.so
libhiprand.so
libhsakmt.so
libhsa-runtime64.so
libmcwamp.so
libmcwamp_cpu.so
libmcwamp_hsa.so
libmiopengemm.so
libMIOpen.so
libdrm.so
libdrm_amdgpu.so
libnuma.so
libpci.so
librccl.so
librocblas.so
librocfft-device.so
librocfft.so
librocrand.so
librocr_debug_agent64.so

libamdcomgr64.so
libamdocl64.so
libcltrace.so
libOpenCL.so
 
--------------------------------------------------------------------------------
+ tail -n +1 /etc/apptainer/network/00_bridge.conflist /etc/apptainer/network/10_ptp.conflist /etc/apptainer/network/20_ipvlan.conflist /etc/apptainer/network/30_macvlan.conflist /etc/apptainer/network/40_fakeroot.conflist
==> /etc/apptainer/network/00_bridge.conflist <==
{
    "cniVersion": "1.0.0",
    "name": "bridge",
    "plugins": [
        {
            "type": "bridge",
            "bridge": "sbr0",
            "isGateway": true,
            "ipMasq": true,
            "ipam": {
                "type": "host-local",
                "subnet": "10.22.0.0/16",
                "routes": [
                    { "dst": "0.0.0.0/0" }
                ]
            }
        },
        {
            "type": "firewall"
        },
        {
            "type": "portmap",
            "capabilities": {"portMappings": true},
            "snat": true
        }
    ]
}

==> /etc/apptainer/network/10_ptp.conflist <==
{
    "cniVersion": "1.0.0",
    "name": "ptp",
    "plugins": [
        {
            "type": "ptp",
            "ipMasq": true,
            "ipam": {
                "type": "host-local",
                "subnet": "10.23.0.0/16",
                "routes": [
                    { "dst": "0.0.0.0/0" }
                ]
            }
        },
        {
            "type": "firewall"
        },
        {
            "type": "portmap",
            "capabilities": {"portMappings": true},
            "snat": true
        }
    ]
}

==> /etc/apptainer/network/20_ipvlan.conflist <==
{
    "cniVersion": "1.0.0",
    "name": "ipvlan",
    "plugins": [
        {
            "type": "ipvlan",
            "master": "eth0",
            "ipam": {
                "type": "static",
                "addresses": [
                    {
                        "address": "192.168.1.1/24",
                        "gateway": "192.168.1.254"
                    }
                ],
                "routes": [
                    { "dst": "0.0.0.0/0" }
                ]
            }
        }
    ]
}

==> /etc/apptainer/network/30_macvlan.conflist <==
{
    "cniVersion": "1.0.0",
    "name": "macvlan",
    "plugins": [
        {
            "type": "macvlan",
            "master": "eth0",
            "ipam": {
                "type": "static",
                "addresses": [
                    {
                        "address": "192.168.1.1/24",
                        "gateway": "192.168.1.254"
                    }
                ],
                "routes": [
                    { "dst": "0.0.0.0/0" }
                ]
            }
        }
    ]
}

==> /etc/apptainer/network/40_fakeroot.conflist <==
{
    "cniVersion": "1.0.0",
    "name": "fakeroot",
    "plugins": [
        {
            "type": "ptp",
            "ipMasq": true,
            "ipam": {
                "type": "host-local",
                "subnet": "10.23.0.0/16",
                "routes": [
                    { "dst": "0.0.0.0/0" }
                ]
            }
        },
        {
            "type": "firewall"
        },
        {
            "type": "portmap",
            "capabilities": {"portMappings": true},
            "snat": true
        }
    ]
}
--------------------------------------------------------------------------------
+ cat /etc/singularity/singularity.conf
--------------------------------------------------------------------------------
+ cat /etc/singularity/rocmliblist.conf
--------------------------------------------------------------------------------
+ tail -n +1 /etc/singularity/network/*
--------------------------------------------------------------------------------
+ rm -rf apptainer apptainer-tmp
+ curl -fL https://raw.githubusercontent.com/apptainer/apptainer/main/tools/install-unprivileged.sh | bash -s - apptainer
Extracting https://download.fedoraproject.org/pub/epel/8/Everything/x86_64/Packages/a/apptainer-1.4.2-1.el8.x86_64.rpm
Extracting https://dl.rockylinux.org/pub/rocky/8/BaseOS/x86_64/os/Packages/l/lzo-2.08-14.el8.x86_64.rpm
Extracting https://dl.rockylinux.org/pub/rocky/8/BaseOS/x86_64/os/Packages/s/squashfs-tools-4.3-21.el8.x86_64.rpm
Extracting https://dl.rockylinux.org/pub/rocky/8/BaseOS/x86_64/os/Packages/l/lz4-libs-1.8.3-5.el8_10.x86_64.rpm
Extracting https://dl.rockylinux.org/pub/rocky/8/BaseOS/x86_64/os/Packages/l/libzstd-1.4.4-1.el8.x86_64.rpm
Extracting https://dl.rockylinux.org/pub/rocky/8/BaseOS/x86_64/os/Packages/f/fuse3-libs-3.3.0-19.el8.x86_64.rpm
Extracting https://dl.rockylinux.org/pub/rocky/8/BaseOS/x86_64/os/Packages/l/libsepol-2.9-3.el8.x86_64.rpm
Extracting https://dl.rockylinux.org/pub/rocky/8/BaseOS/x86_64/os/Packages/b/bzip2-libs-1.0.6-28.el8_10.x86_64.rpm
Extracting https://dl.rockylinux.org/pub/rocky/8/BaseOS/x86_64/os/Packages/a/audit-libs-3.1.2-1.el8_10.1.x86_64.rpm
Extracting https://dl.rockylinux.org/pub/rocky/8/BaseOS/x86_64/os/Packages/l/libcap-ng-0.7.11-1.el8.x86_64.rpm
Extracting https://dl.rockylinux.org/pub/rocky/8/BaseOS/x86_64/os/Packages/l/libattr-2.4.48-3.el8.x86_64.rpm
Extracting https://dl.rockylinux.org/pub/rocky/8/BaseOS/x86_64/os/Packages/l/libacl-2.2.53-3.el8.x86_64.rpm
Extracting https://dl.rockylinux.org/pub/rocky/8/BaseOS/x86_64/os/Packages/p/pcre2-10.32-3.el8_6.x86_64.rpm
Extracting https://dl.rockylinux.org/pub/rocky/8/BaseOS/x86_64/os/Packages/l/libxcrypt-4.1.1-6.el8.x86_64.rpm
Extracting https://dl.rockylinux.org/pub/rocky/8/BaseOS/x86_64/os/Packages/l/libselinux-2.9-9.el8_10.x86_64.rpm
Extracting https://dl.rockylinux.org/pub/rocky/8/BaseOS/x86_64/os/Packages/l/libsemanage-2.9-9.el8_6.x86_64.rpm
Extracting https://dl.rockylinux.org/pub/rocky/8/BaseOS/x86_64/os/Packages/s/shadow-utils-subid-4.6-22.el8.x86_64.rpm
Extracting https://dl.rockylinux.org/pub/rocky/8/BaseOS/x86_64/os/Packages/l/libseccomp-2.5.2-1.el8.x86_64.rpm
Extracting https://download.fedoraproject.org/pub/epel/8/Everything/x86_64/Packages/f/fakeroot-libs-1.33-1.el8.x86_64.rpm
Extracting https://download.fedoraproject.org/pub/epel/8/Everything/x86_64/Packages/f/fakeroot-1.33-1.el8.x86_64.rpm
Patching fakeroot-sysv to make it relocatable
Creating bin/apptainer and bin/singularity
Installation complete in apptainer
+ mkdir -p /projappl/project_XXXXXXX/container-evaluator-tmp/apptainer-tmp
+ ./apptainer/bin/apptainer run docker://sylabsio/lolcow:latest
INFO   : A system administrator may need to enable user namespaces, install
INFO   :   apptainer-suid, or compile with ./mconfig --with-suid
--------------------------------------------------------------------------------
+ curl -fL https://get.docker.com/rootless | sh
# Installing stable version 28.4.0
# Executing docker rootless install script, commit: 5c8855edd778525564500337f5ac4ad65a0c168e
# Missing system requirements. Please run following commands to
# install the requirements and run this installer again.
# Alternatively iptables checks can be disabled with SKIP_IPTABLES=1

cat <<EOF | sudo sh -x

modprobe ip_tables
cat <<EOT > /etc/sysctl.d/51-rootless.conf
user.max_user_namespaces = 28633
EOT
sysctl --system
EOF

--------------------------------------------------------------------------------
```
</details>

## Authors

- Dennis Marttinen ([@twelho](https://github.com/twelho))

## License

[MIT](https://spdx.org/licenses/MIT.html) ([LICENSE](LICENSE))
