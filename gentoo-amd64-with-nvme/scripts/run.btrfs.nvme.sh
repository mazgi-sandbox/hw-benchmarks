#!/bin/bash

set -e

readonly JOB_PREFIX="btrfs.nvme"
readonly DEVICE="/dev/nvme0n1p4"
readonly MOUNT_POINT="/mnt/btrfs"
readonly -a RWS=("read" "write" "randread" "randwrite")
readonly -a BSS=("4k" "16k")

function prepare() {
  echo '* Make and mount filesystem'
  echo ''
  echo '```'
  echo umount -f "${MOUNT_POINT}"
  umount -f "${MOUNT_POINT}" 2> /dev/null || true
  mkdir -p "${MOUNT_POINT}"
  echo mkfs.btrfs --force "${DEVICES[@]}"
  mkfs.btrfs --force "${DEVICE}"
  MOUNT_OPT="defaults"
  echo mount -o "${MOUNT_OPT}" "${DEVICE}" "${MOUNT_POINT}"
  mount -o "${MOUNT_OPT}" "${DEVICE}" "${MOUNT_POINT}"
  echo '```'
  echo ''
}

for rw in "${RWS[@]}"
do
  for bs in "${BSS[@]}"
  do
    echo "### btrfs, rw=${rw}, bs=${bs}"
    echo ''
    prepare
    echo '* Run fio benchmark'
    echo ''
    echo '```'
    echo fio -directory="${MOUNT_POINT}" -name="${JOB_PREFIX}" -rw="${rw}" -bs="${bs}" -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
    fio -directory="${MOUNT_POINT}" -name="${JOB_PREFIX}" -rw="${rw}" -bs="${bs}" -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
    echo '```'
    echo ''
  done
done
