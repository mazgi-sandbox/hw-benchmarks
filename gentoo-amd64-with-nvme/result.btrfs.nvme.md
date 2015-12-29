### btrfs, rw=read, bs=4k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force
Detected a SSD, turning off metadata duplication.  Mkfs with -m dup if you want to force metadata duplication.
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Performing full device TRIM (204.47GiB) ...
Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
fs created label (null) on /dev/nvme0n1p4
	nodesize 16384 leafsize 16384 sectorsize 4096 size 204.47GiB
mount -o defaults /dev/nvme0n1p4 /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.nvme -rw=read -bs=4k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.nvme: (g=0): rw=read, bs=4K-4K/4K-4K/4K-4K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.nvme: (groupid=0, jobs=40): err= 0: pid=3090: Tue Dec 29 18:43:07 2015
  read : io=5120.0MB, bw=676850KB/s, iops=169212, runt=  7746msec
    slat (usec): min=2, max=18403, avg= 4.19, stdev=16.71
    clat (usec): min=50, max=25846, avg=7545.75, stdev=474.70
     lat (usec): min=196, max=25849, avg=7549.93, stdev=474.01
    clat percentiles (usec):
     |  1.00th=[ 6368],  5.00th=[ 6816], 10.00th=[ 7200], 20.00th=[ 7392],
     | 30.00th=[ 7520], 40.00th=[ 7584], 50.00th=[ 7648], 60.00th=[ 7648],
     | 70.00th=[ 7712], 80.00th=[ 7712], 90.00th=[ 7776], 95.00th=[ 7840],
     | 99.00th=[ 8768], 99.50th=[ 9280], 99.90th=[10816], 99.95th=[11328],
     | 99.99th=[11968]
    bw (KB  /s): min=16359, max=21373, per=2.50%, avg=16903.31, stdev=489.45
    lat (usec) : 100=0.01%, 250=0.01%, 500=0.02%, 750=0.01%, 1000=0.02%
    lat (msec) : 2=0.03%, 4=0.09%, 10=99.54%, 20=0.30%, 50=0.01%
  cpu          : usr=0.55%, sys=2.27%, ctx=1135636, majf=0, minf=1608
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=100.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=1310720/w=0/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
   READ: io=5120.0MB, aggrb=676849KB/s, minb=676849KB/s, maxb=676849KB/s, mint=7746msec, maxt=7746msec
```

### btrfs, rw=read, bs=16k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force
Detected a SSD, turning off metadata duplication.  Mkfs with -m dup if you want to force metadata duplication.
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Performing full device TRIM (204.47GiB) ...
Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
fs created label (null) on /dev/nvme0n1p4
	nodesize 16384 leafsize 16384 sectorsize 4096 size 204.47GiB
mount -o defaults /dev/nvme0n1p4 /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.nvme -rw=read -bs=16k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.nvme: (g=0): rw=read, bs=16K-16K/16K-16K/16K-16K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.nvme: (groupid=0, jobs=40): err= 0: pid=3207: Tue Dec 29 18:43:20 2015
  read : io=5120.0MB, bw=1512.6MB/s, iops=96803, runt=  3385msec
    slat (usec): min=3, max=306, avg= 6.27, stdev=14.85
    clat (usec): min=260, max=26311, avg=13162.27, stdev=1122.54
     lat (usec): min=267, max=26316, avg=13168.54, stdev=1117.13
    clat percentiles (usec):
     |  1.00th=[ 6624],  5.00th=[12736], 10.00th=[12992], 20.00th=[13120],
     | 30.00th=[13248], 40.00th=[13248], 50.00th=[13248], 60.00th=[13376],
     | 70.00th=[13504], 80.00th=[13632], 90.00th=[13632], 95.00th=[13760],
     | 99.00th=[13760], 99.50th=[13888], 99.90th=[17280], 99.95th=[19328],
     | 99.99th=[23424]
    bw (KB  /s): min=36928, max=46176, per=2.49%, avg=38636.23, stdev=1192.67
    lat (usec) : 500=0.02%, 750=0.03%, 1000=0.01%
    lat (msec) : 2=0.01%, 4=0.20%, 10=1.96%, 20=97.73%, 50=0.04%
  cpu          : usr=0.35%, sys=1.79%, ctx=295529, majf=0, minf=5466
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=100.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=327680/w=0/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
   READ: io=5120.0MB, aggrb=1512.6MB/s, minb=1512.6MB/s, maxb=1512.6MB/s, mint=3385msec, maxt=3385msec
```

### btrfs, rw=write, bs=4k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force
Detected a SSD, turning off metadata duplication.  Mkfs with -m dup if you want to force metadata duplication.
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Performing full device TRIM (204.47GiB) ...
Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
fs created label (null) on /dev/nvme0n1p4
	nodesize 16384 leafsize 16384 sectorsize 4096 size 204.47GiB
mount -o defaults /dev/nvme0n1p4 /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.nvme -rw=write -bs=4k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.nvme: (g=0): rw=write, bs=4K-4K/4K-4K/4K-4K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.nvme: (groupid=0, jobs=40): err= 0: pid=3281: Tue Dec 29 18:43:33 2015
  write: io=5120.0MB, bw=424078KB/s, iops=106019, runt= 12363msec
    slat (usec): min=7, max=463552, avg=360.49, stdev=7003.75
    clat (usec): min=1, max=499072, avg=11476.08, stdev=39910.60
     lat (usec): min=24, max=499097, avg=11836.61, stdev=40513.74
    clat percentiles (usec):
     |  1.00th=[  358],  5.00th=[  362], 10.00th=[  366], 20.00th=[  370],
     | 30.00th=[  374], 40.00th=[  374], 50.00th=[  378], 60.00th=[  382],
     | 70.00th=[  442], 80.00th=[11840], 90.00th=[38144], 95.00th=[50432],
     | 99.00th=[96768], 99.50th=[391168], 99.90th=[444416], 99.95th=[456704],
     | 99.99th=[481280]
    bw (KB  /s): min= 2795, max=58674, per=2.62%, avg=11127.26, stdev=4279.49
    lat (usec) : 2=0.01%, 4=0.01%, 10=0.01%, 20=0.01%, 50=0.01%
    lat (usec) : 100=0.01%, 250=0.04%, 500=70.16%, 750=0.70%, 1000=0.31%
    lat (msec) : 2=0.94%, 4=1.64%, 10=4.98%, 20=5.38%, 50=10.77%
    lat (msec) : 100=4.08%, 250=0.13%, 500=0.84%
  cpu          : usr=0.28%, sys=3.10%, ctx=377997, majf=0, minf=381
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=100.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=0/w=1310720/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
  WRITE: io=5120.0MB, aggrb=424078KB/s, minb=424078KB/s, maxb=424078KB/s, mint=12363msec, maxt=12363msec
```

### btrfs, rw=write, bs=16k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force
Detected a SSD, turning off metadata duplication.  Mkfs with -m dup if you want to force metadata duplication.
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Performing full device TRIM (204.47GiB) ...
Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
fs created label (null) on /dev/nvme0n1p4
	nodesize 16384 leafsize 16384 sectorsize 4096 size 204.47GiB
mount -o defaults /dev/nvme0n1p4 /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.nvme -rw=write -bs=16k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.nvme: (g=0): rw=write, bs=16K-16K/16K-16K/16K-16K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.nvme: (groupid=0, jobs=40): err= 0: pid=3358: Tue Dec 29 18:43:40 2015
  write: io=5120.0MB, bw=944153KB/s, iops=59009, runt=  5553msec
    slat (usec): min=15, max=33250, avg=164.58, stdev=993.25
    clat (usec): min=2, max=79230, avg=20726.27, stdev=13587.37
     lat (usec): min=39, max=79252, avg=20890.85, stdev=13729.43
    clat percentiles (usec):
     |  1.00th=[ 1080],  5.00th=[ 1624], 10.00th=[ 2448], 20.00th=[ 5920],
     | 30.00th=[ 9664], 40.00th=[14272], 50.00th=[21120], 60.00th=[27776],
     | 70.00th=[31616], 80.00th=[34048], 90.00th=[36608], 95.00th=[39680],
     | 99.00th=[48384], 99.50th=[52480], 99.90th=[59136], 99.95th=[62208],
     | 99.99th=[68096]
    bw (KB  /s): min=13650, max=48413, per=2.52%, avg=23795.29, stdev=4995.08
    lat (usec) : 4=0.01%, 10=0.01%, 50=0.01%, 100=0.01%, 250=0.02%
    lat (usec) : 500=0.03%, 750=0.44%, 1000=0.20%
    lat (msec) : 2=7.03%, 4=7.51%, 10=15.76%, 20=17.74%, 50=50.50%
    lat (msec) : 100=0.76%
  cpu          : usr=0.28%, sys=3.18%, ctx=112890, majf=0, minf=367
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=100.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=0/w=327680/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
  WRITE: io=5120.0MB, aggrb=944152KB/s, minb=944152KB/s, maxb=944152KB/s, mint=5553msec, maxt=5553msec
```

### btrfs, rw=randread, bs=4k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force
Detected a SSD, turning off metadata duplication.  Mkfs with -m dup if you want to force metadata duplication.
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Performing full device TRIM (204.47GiB) ...
Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
fs created label (null) on /dev/nvme0n1p4
	nodesize 16384 leafsize 16384 sectorsize 4096 size 204.47GiB
mount -o defaults /dev/nvme0n1p4 /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.nvme -rw=randread -bs=4k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.nvme: (g=0): rw=randread, bs=4K-4K/4K-4K/4K-4K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.nvme: (groupid=0, jobs=40): err= 0: pid=3432: Tue Dec 29 18:43:59 2015
  read : io=5120.0MB, bw=639454KB/s, iops=159863, runt=  8199msec
    slat (usec): min=2, max=208, avg= 4.58, stdev= 4.98
    clat (usec): min=7, max=23128, avg=7980.95, stdev=574.54
     lat (usec): min=90, max=23307, avg=7985.54, stdev=573.73
    clat percentiles (usec):
     |  1.00th=[ 6496],  5.00th=[ 7136], 10.00th=[ 7392], 20.00th=[ 7648],
     | 30.00th=[ 7904], 40.00th=[ 8160], 50.00th=[ 8256], 60.00th=[ 8256],
     | 70.00th=[ 8256], 80.00th=[ 8256], 90.00th=[ 8256], 95.00th=[ 8384],
     | 99.00th=[ 8512], 99.50th=[ 8640], 99.90th=[ 9408], 99.95th=[10048],
     | 99.99th=[12352]
    bw (KB  /s): min=15392, max=22632, per=2.50%, avg=15974.05, stdev=793.11
    lat (usec) : 10=0.01%, 20=0.01%, 50=0.01%, 100=0.01%, 250=0.01%
    lat (usec) : 500=0.10%, 750=0.05%, 1000=0.03%
    lat (msec) : 2=0.03%, 4=0.06%, 10=99.66%, 20=0.05%, 50=0.01%
  cpu          : usr=0.64%, sys=2.32%, ctx=1205667, majf=0, minf=1609
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=100.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=1310720/w=0/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
   READ: io=5120.0MB, aggrb=639453KB/s, minb=639453KB/s, maxb=639453KB/s, mint=8199msec, maxt=8199msec
```

### btrfs, rw=randread, bs=16k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force
Detected a SSD, turning off metadata duplication.  Mkfs with -m dup if you want to force metadata duplication.
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Performing full device TRIM (204.47GiB) ...
Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
fs created label (null) on /dev/nvme0n1p4
	nodesize 16384 leafsize 16384 sectorsize 4096 size 204.47GiB
mount -o defaults /dev/nvme0n1p4 /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.nvme -rw=randread -bs=16k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.nvme: (g=0): rw=randread, bs=16K-16K/16K-16K/16K-16K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.nvme: (groupid=0, jobs=40): err= 0: pid=3506: Tue Dec 29 18:44:12 2015
  read : io=5120.0MB, bw=1427.4MB/s, iops=91352, runt=  3587msec
    slat (usec): min=3, max=274, avg= 6.69, stdev=15.03
    clat (usec): min=29, max=27836, avg=13889.32, stdev=1280.32
     lat (usec): min=125, max=27843, avg=13896.01, stdev=1276.88
    clat percentiles (usec):
     |  1.00th=[ 8160],  5.00th=[13120], 10.00th=[13888], 20.00th=[13888],
     | 30.00th=[14016], 40.00th=[14016], 50.00th=[14144], 60.00th=[14144],
     | 70.00th=[14144], 80.00th=[14272], 90.00th=[14272], 95.00th=[14400],
     | 99.00th=[14528], 99.50th=[14656], 99.90th=[15680], 99.95th=[17024],
     | 99.99th=[24960]
    bw (KB  /s): min=35168, max=58240, per=2.50%, avg=36609.44, stdev=1999.08
    lat (usec) : 50=0.01%, 100=0.01%, 250=0.05%, 500=0.08%, 750=0.03%
    lat (usec) : 1000=0.01%
    lat (msec) : 2=0.18%, 4=0.44%, 10=0.43%, 20=98.76%, 50=0.02%
  cpu          : usr=0.39%, sys=1.81%, ctx=313894, majf=0, minf=5411
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=100.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=327680/w=0/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
   READ: io=5120.0MB, aggrb=1427.4MB/s, minb=1427.4MB/s, maxb=1427.4MB/s, mint=3587msec, maxt=3587msec
```

### btrfs, rw=randwrite, bs=4k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force
Detected a SSD, turning off metadata duplication.  Mkfs with -m dup if you want to force metadata duplication.
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Performing full device TRIM (204.47GiB) ...
Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
fs created label (null) on /dev/nvme0n1p4
	nodesize 16384 leafsize 16384 sectorsize 4096 size 204.47GiB
mount -o defaults /dev/nvme0n1p4 /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.nvme -rw=randwrite -bs=4k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.nvme: (g=0): rw=randwrite, bs=4K-4K/4K-4K/4K-4K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.nvme: (groupid=0, jobs=40): err= 0: pid=3580: Tue Dec 29 18:44:36 2015
  write: io=5120.0MB, bw=234172KB/s, iops=58543, runt= 22389msec
    slat (usec): min=8, max=1044.1K, avg=330.29, stdev=15925.29
    clat (usec): min=2, max=1058.8K, avg=20650.45, stdev=88151.33
     lat (usec): min=29, max=1058.8K, avg=20980.74, stdev=89529.35
    clat percentiles (usec):
     |  1.00th=[  442],  5.00th=[ 1912], 10.00th=[ 5152], 20.00th=[ 7840],
     | 30.00th=[ 9664], 40.00th=[11072], 50.00th=[12224], 60.00th=[13248],
     | 70.00th=[14528], 80.00th=[16512], 90.00th=[19840], 95.00th=[21888],
     | 99.00th=[52480], 99.50th=[913408], 99.90th=[1036288], 99.95th=[1044480],
     | 99.99th=[1056768]
    bw (KB  /s): min=  109, max=29960, per=3.21%, avg=7517.50, stdev=4852.47
    lat (usec) : 4=0.01%, 10=0.01%, 20=0.01%, 50=0.01%, 100=0.01%
    lat (usec) : 250=0.01%, 500=3.20%, 750=0.27%, 1000=0.21%
    lat (msec) : 2=1.44%, 4=2.58%, 10=24.92%, 20=58.04%, 50=8.30%
    lat (msec) : 100=0.10%, 250=0.01%, 1000=0.68%, 2000=0.24%
  cpu          : usr=0.22%, sys=2.50%, ctx=397091, majf=0, minf=340
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=100.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=0/w=1310720/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
  WRITE: io=5120.0MB, aggrb=234172KB/s, minb=234172KB/s, maxb=234172KB/s, mint=22389msec, maxt=22389msec
```

### btrfs, rw=randwrite, bs=16k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force
Detected a SSD, turning off metadata duplication.  Mkfs with -m dup if you want to force metadata duplication.
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Performing full device TRIM (204.47GiB) ...
Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
fs created label (null) on /dev/nvme0n1p4
	nodesize 16384 leafsize 16384 sectorsize 4096 size 204.47GiB
mount -o defaults /dev/nvme0n1p4 /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.nvme -rw=randwrite -bs=16k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.nvme: (g=0): rw=randwrite, bs=16K-16K/16K-16K/16K-16K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.nvme: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.nvme: (groupid=0, jobs=40): err= 0: pid=3656: Tue Dec 29 18:44:44 2015
  write: io=5120.0MB, bw=810964KB/s, iops=50685, runt=  6465msec
    slat (usec): min=16, max=811212, avg=202.99, stdev=8684.43
    clat (usec): min=3, max=855525, avg=23030.73, stdev=49374.96
     lat (usec): min=53, max=855550, avg=23233.72, stdev=50141.89
    clat percentiles (usec):
     |  1.00th=[  708],  5.00th=[ 3280], 10.00th=[ 5344], 20.00th=[ 8512],
     | 30.00th=[12608], 40.00th=[15680], 50.00th=[18304], 60.00th=[22656],
     | 70.00th=[26752], 80.00th=[33536], 90.00th=[36096], 95.00th=[38656],
     | 99.00th=[45824], 99.50th=[52480], 99.90th=[823296], 99.95th=[831488],
     | 99.99th=[839680]
    bw (KB  /s): min=   19, max=77385, per=2.73%, avg=22146.91, stdev=12652.98
    lat (usec) : 4=0.01%, 10=0.01%, 50=0.01%, 100=0.01%, 250=0.03%
    lat (usec) : 500=0.04%, 750=1.60%, 1000=0.21%
    lat (msec) : 2=0.90%, 4=3.53%, 10=17.51%, 20=30.18%, 50=45.42%
    lat (msec) : 100=0.21%, 1000=0.37%
  cpu          : usr=0.28%, sys=3.38%, ctx=97037, majf=0, minf=334
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=100.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=0/w=327680/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
  WRITE: io=5120.0MB, aggrb=810963KB/s, minb=810963KB/s, maxb=810963KB/s, mint=6465msec, maxt=6465msec
```

