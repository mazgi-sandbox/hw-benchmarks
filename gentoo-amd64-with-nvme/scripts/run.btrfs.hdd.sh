#!/bin/bash

set -e

readonly JOB_PREFIX="btrfs.hdd"
readonly -a DEVICES=("/dev/sda" "/dev/sdb")
readonly MOUNT_POINT="/mnt/btrfs"
readonly -a RAID_OPTS=(
"-m raid0 -d raid0"
"-m raid0 -d raid1"
"-m raid1 -d raid0"
"-m raid1 -d raid1"
)
readonly -a RWS=("read" "write" "randread" "randwrite")
readonly -a BSS=("4k" "16k")

function prepare() {
  echo '* Make and mount filesystem'
  echo ''
  echo '```'
  echo umount -f "${MOUNT_POINT}"
  umount -f "${MOUNT_POINT}" 2> /dev/null || true
  mkdir -p "${MOUNT_POINT}"
  echo mkfs.btrfs --force ${1} "${DEVICES[@]}"
  mkfs.btrfs --force ${1} "${DEVICES[@]}"
  MOUNT_OPT="defaults"
  for dev in "${DEVICES[@]}"
  do
    MOUNT_OPT="${MOUNT_OPT},device=${dev}"
  done
  echo mount -o "${MOUNT_OPT}" "${DEVICES[0]}" "${MOUNT_POINT}"
  mount -o "${MOUNT_OPT}" "${DEVICES[0]}" "${MOUNT_POINT}"
  echo '```'
      echo ''
}

for raid_opt in "${RAID_OPTS[@]}"
do
  for rw in "${RWS[@]}"
  do
    for bs in "${BSS[@]}"
    do
      prepare "${raid_opt}"
      echo "### btrfs raid ${raid_opt}, rw=${rw}, bs=${bs}"
      echo ''
      echo '* Run fio benchmark'
      echo ''
      echo '```'
      echo fio -directory="${MOUNT_POINT}" -name="${JOB_PREFIX}" -rw="${rw}" -bs="${bs}" -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
      fio -directory="${MOUNT_POINT}" -name="${JOB_PREFIX}" -rw="${rw}" -bs="${bs}" -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
      echo '```'
      echo ''
    done
  done
done
