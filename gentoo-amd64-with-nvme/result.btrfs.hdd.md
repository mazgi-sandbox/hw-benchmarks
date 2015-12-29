### btrfs raid -m raid0 -d raid0, rw=read, bs=4k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force -m raid0 -d raid0 /dev/sda /dev/sdb
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
adding device /dev/sdb id 2
fs created label (null) on /dev/sda
	nodesize 16384 leafsize 16384 sectorsize 4096 size 7.28TiB
mount -o defaults,device=/dev/sda,device=/dev/sdb /dev/sda /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.hdd -rw=read -bs=4k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.hdd: (g=0): rw=read, bs=4K-4K/4K-4K/4K-4K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.hdd: (groupid=0, jobs=40): err= 0: pid=6617: Tue Dec 29 18:00:07 2015
  read : io=1398.4MB, bw=23547KB/s, iops=5886, runt= 60809msec
    slat (usec): min=2, max=252, avg= 5.45, stdev= 9.16
    clat (usec): min=53, max=2724.4K, avg=215455.56, stdev=243992.68
     lat (usec): min=63, max=2724.6K, avg=215461.01, stdev=243993.53
    clat percentiles (usec):
     |  1.00th=[  129],  5.00th=[  253], 10.00th=[  390], 20.00th=[  524],
     | 30.00th=[  676], 40.00th=[17280], 50.00th=[119296], 60.00th=[199680],
     | 70.00th=[407552], 80.00th=[497664], 90.00th=[593920], 95.00th=[667648],
     | 99.00th=[724992], 99.50th=[741376], 99.90th=[790528], 99.95th=[806912],
     | 99.99th=[823296]
    bw (KB  /s): min=    6, max= 7287, per=2.52%, avg=594.13, stdev=279.44
    lat (usec) : 100=0.33%, 250=4.52%, 500=13.22%, 750=14.44%, 1000=1.43%
    lat (msec) : 2=2.18%, 4=0.27%, 10=0.78%, 20=3.76%, 50=4.78%
    lat (msec) : 100=2.66%, 250=17.40%, 500=14.41%, 750=19.50%, 1000=0.32%
    lat (msec) : >=2000=0.01%
  cpu          : usr=0.02%, sys=0.10%, ctx=58229, majf=0, minf=1614
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=100.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=357968/w=0/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
   READ: io=1398.4MB, aggrb=23547KB/s, minb=23547KB/s, maxb=23547KB/s, mint=60809msec, maxt=60809msec
```

### btrfs raid -m raid0 -d raid0, rw=read, bs=16k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force -m raid0 -d raid0 /dev/sda /dev/sdb
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
adding device /dev/sdb id 2
fs created label (null) on /dev/sda
	nodesize 16384 leafsize 16384 sectorsize 4096 size 7.28TiB
mount -o defaults,device=/dev/sda,device=/dev/sdb /dev/sda /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.hdd -rw=read -bs=16k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.hdd: (g=0): rw=read, bs=16K-16K/16K-16K/16K-16K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.hdd: (groupid=0, jobs=40): err= 0: pid=6871: Tue Dec 29 18:01:29 2015
  read : io=5120.0MB, bw=89513KB/s, iops=5594, runt= 58571msec
    slat (usec): min=3, max=318, avg= 8.59, stdev=14.49
    clat (usec): min=89, max=2635.6K, avg=226716.54, stdev=247330.02
     lat (usec): min=96, max=2635.3K, avg=226725.14, stdev=247330.67
    clat percentiles (usec):
     |  1.00th=[  193],  5.00th=[  278], 10.00th=[  350], 20.00th=[  604],
     | 30.00th=[  892], 40.00th=[ 1224], 50.00th=[191488], 60.00th=[284672],
     | 70.00th=[358400], 80.00th=[528384], 90.00th=[593920], 95.00th=[626688],
     | 99.00th=[692224], 99.50th=[716800], 99.90th=[905216], 99.95th=[1695744],
     | 99.99th=[2375680]
    bw (KB  /s): min=   22, max= 6614, per=2.51%, avg=2247.66, stdev=299.92
    lat (usec) : 100=0.01%, 250=2.90%, 500=13.58%, 750=8.77%, 1000=8.29%
    lat (msec) : 2=10.51%, 4=2.50%, 10=0.13%, 20=0.18%, 50=0.64%
    lat (msec) : 100=0.30%, 250=7.84%, 500=21.05%, 750=23.07%, 1000=0.17%
    lat (msec) : 2000=0.04%, >=2000=0.03%
  cpu          : usr=0.03%, sys=0.16%, ctx=151769, majf=0, minf=5455
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=100.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=327680/w=0/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
   READ: io=5120.0MB, aggrb=89513KB/s, minb=89513KB/s, maxb=89513KB/s, mint=58571msec, maxt=58571msec
```

### btrfs raid -m raid0 -d raid0, rw=write, bs=4k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force -m raid0 -d raid0 /dev/sda /dev/sdb
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
adding device /dev/sdb id 2
fs created label (null) on /dev/sda
	nodesize 16384 leafsize 16384 sectorsize 4096 size 7.28TiB
mount -o defaults,device=/dev/sda,device=/dev/sdb /dev/sda /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.hdd -rw=write -bs=4k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.hdd: (g=0): rw=write, bs=4K-4K/4K-4K/4K-4K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.hdd: (groupid=0, jobs=40): err= 0: pid=7025: Tue Dec 29 18:02:30 2015
  write: io=2507.6MB, bw=42653KB/s, iops=10663, runt= 60199msec
    slat (usec): min=7, max=216807, avg=28.66, stdev=1147.61
    clat (usec): min=35, max=1967.3K, avg=119786.02, stdev=109026.02
     lat (usec): min=48, max=1972.8K, avg=119814.68, stdev=109064.05
    clat percentiles (usec):
     |  1.00th=[  153],  5.00th=[  205], 10.00th=[  266], 20.00th=[  318],
     | 30.00th=[  438], 40.00th=[129536], 50.00th=[160768], 60.00th=[175104],
     | 70.00th=[187392], 80.00th=[199680], 90.00th=[211968], 95.00th=[222208],
     | 99.00th=[276480], 99.50th=[333824], 99.90th=[1318912], 99.95th=[1400832],
     | 99.99th=[1695744]
    bw (KB  /s): min=    3, max=15066, per=2.53%, avg=1077.00, stdev=561.11
    lat (usec) : 50=0.01%, 100=0.03%, 250=8.16%, 500=22.90%, 750=1.01%
    lat (usec) : 1000=0.34%
    lat (msec) : 2=3.05%, 4=0.10%, 10=0.34%, 20=0.23%, 50=0.34%
    lat (msec) : 100=1.17%, 250=60.43%, 500=1.60%, 750=0.06%, 1000=0.05%
    lat (msec) : 2000=0.19%
  cpu          : usr=0.03%, sys=0.34%, ctx=161811, majf=0, minf=373
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=100.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=0/w=641920/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
  WRITE: io=2507.6MB, aggrb=42653KB/s, minb=42653KB/s, maxb=42653KB/s, mint=60199msec, maxt=60199msec
```

### btrfs raid -m raid0 -d raid0, rw=write, bs=16k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force -m raid0 -d raid0 /dev/sda /dev/sdb
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
adding device /dev/sdb id 2
fs created label (null) on /dev/sda
	nodesize 16384 leafsize 16384 sectorsize 4096 size 7.28TiB
mount -o defaults,device=/dev/sda,device=/dev/sdb /dev/sda /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.hdd -rw=write -bs=16k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.hdd: (g=0): rw=write, bs=16K-16K/16K-16K/16K-16K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.hdd: (groupid=0, jobs=40): err= 0: pid=7107: Tue Dec 29 18:03:05 2015
  write: io=5120.0MB, bw=157472KB/s, iops=9842, runt= 33294msec
    slat (usec): min=15, max=208066, avg=45.21, stdev=1438.32
    clat (usec): min=75, max=2058.2K, avg=124926.70, stdev=163125.39
     lat (usec): min=118, max=2058.2K, avg=124971.91, stdev=163155.02
    clat percentiles (usec):
     |  1.00th=[  223],  5.00th=[  302], 10.00th=[  406], 20.00th=[  498],
     | 30.00th=[  596], 40.00th=[  756], 50.00th=[12224], 60.00th=[171008],
     | 70.00th=[214016], 80.00th=[264192], 90.00th=[309248], 95.00th=[354304],
     | 99.00th=[544768], 99.50th=[757760], 99.90th=[1695744], 99.95th=[1859584],
     | 99.99th=[1974272]
    bw (KB  /s): min=   62, max=30865, per=2.61%, avg=4105.09, stdev=1828.95
    lat (usec) : 100=0.01%, 250=1.96%, 500=18.48%, 750=19.38%, 1000=3.00%
    lat (msec) : 2=4.35%, 4=0.96%, 10=1.00%, 20=1.81%, 50=1.58%
    lat (msec) : 100=1.98%, 250=23.14%, 500=21.07%, 750=0.79%, 1000=0.13%
    lat (msec) : 2000=0.37%, >=2000=0.01%
  cpu          : usr=0.04%, sys=0.53%, ctx=107046, majf=0, minf=374
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=100.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=0/w=327680/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
  WRITE: io=5120.0MB, aggrb=157472KB/s, minb=157472KB/s, maxb=157472KB/s, mint=33294msec, maxt=33294msec
```

### btrfs raid -m raid0 -d raid0, rw=randread, bs=4k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force -m raid0 -d raid0 /dev/sda /dev/sdb
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
adding device /dev/sdb id 2
fs created label (null) on /dev/sda
	nodesize 16384 leafsize 16384 sectorsize 4096 size 7.28TiB
mount -o defaults,device=/dev/sda,device=/dev/sdb /dev/sda /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.hdd -rw=randread -bs=4k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.hdd: (g=0): rw=randread, bs=4K-4K/4K-4K/4K-4K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.hdd: (groupid=0, jobs=40): err= 0: pid=7301: Tue Dec 29 18:04:30 2015
  read : io=154552KB, bw=2554.9KB/s, iops=638, runt= 60495msec
    slat (usec): min=3, max=2678.6K, avg=87638.05, stdev=399424.36
    clat (usec): min=112, max=3212.2K, avg=1911114.55, stdev=555710.98
     lat (usec): min=116, max=4962.8K, avg=1998752.60, stdev=690405.84
    clat percentiles (msec):
     |  1.00th=[    5],  5.00th=[   16], 10.00th=[ 1713], 20.00th=[ 1942],
     | 30.00th=[ 1991], 40.00th=[ 2024], 50.00th=[ 2057], 60.00th=[ 2089],
     | 70.00th=[ 2114], 80.00th=[ 2147], 90.00th=[ 2212], 95.00th=[ 2245],
     | 99.00th=[ 2802], 99.50th=[ 2900], 99.90th=[ 2999], 99.95th=[ 2999],
     | 99.99th=[ 3195]
    bw (KB  /s): min=    1, max=  456, per=2.49%, avg=63.51, stdev=25.99
    lat (usec) : 250=0.01%, 750=0.01%, 1000=0.01%
    lat (msec) : 2=0.01%, 4=0.92%, 10=2.92%, 20=1.48%, 50=0.23%
    lat (msec) : 100=0.16%, 250=0.37%, 500=0.87%, 750=0.62%, 1000=0.95%
    lat (msec) : 2000=24.84%, >=2000=66.61%
  cpu          : usr=0.00%, sys=0.01%, ctx=3778, majf=0, minf=1578
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=98.1%, >=64=0.0%
     submit    : 0=0.0%, 4=99.9%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.9%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=38638/w=0/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
   READ: io=154552KB, aggrb=2554KB/s, minb=2554KB/s, maxb=2554KB/s, mint=60495msec, maxt=60495msec
```

### btrfs raid -m raid0 -d raid0, rw=randread, bs=16k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force -m raid0 -d raid0 /dev/sda /dev/sdb
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
adding device /dev/sdb id 2
fs created label (null) on /dev/sda
	nodesize 16384 leafsize 16384 sectorsize 4096 size 7.28TiB
mount -o defaults,device=/dev/sda,device=/dev/sdb /dev/sda /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.hdd -rw=randread -bs=16k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.hdd: (g=0): rw=randread, bs=16K-16K/16K-16K/16K-16K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.hdd: (groupid=0, jobs=40): err= 0: pid=7396: Tue Dec 29 18:05:54 2015
  read : io=574160KB, bw=9477.1KB/s, iops=592, runt= 60584msec
    slat (usec): min=4, max=3350.4K, avg=92875.84, stdev=420861.44
    clat (usec): min=647, max=4174.6K, avg=2062064.76, stdev=616747.03
     lat (usec): min=655, max=5854.9K, avg=2154940.61, stdev=751353.91
    clat percentiles (msec):
     |  1.00th=[    4],  5.00th=[  119], 10.00th=[ 1221], 20.00th=[ 2114],
     | 30.00th=[ 2180], 40.00th=[ 2212], 50.00th=[ 2245], 60.00th=[ 2245],
     | 70.00th=[ 2278], 80.00th=[ 2311], 90.00th=[ 2409], 95.00th=[ 2507],
     | 99.00th=[ 3097], 99.50th=[ 3359], 99.90th=[ 3589], 99.95th=[ 3785],
     | 99.99th=[ 4178]
    bw (KB  /s): min=    4, max= 1560, per=2.57%, avg=243.13, stdev=130.17
    lat (usec) : 750=0.01%, 1000=0.01%
    lat (msec) : 2=0.01%, 4=0.99%, 10=2.36%, 20=1.16%, 50=0.25%
    lat (msec) : 100=0.17%, 250=0.65%, 500=0.78%, 750=1.30%, 1000=0.59%
    lat (msec) : 2000=5.37%, >=2000=86.36%
  cpu          : usr=0.00%, sys=0.01%, ctx=3436, majf=0, minf=5459
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=97.9%, >=64=0.0%
     submit    : 0=0.0%, 4=99.9%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.9%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=35885/w=0/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
   READ: io=574160KB, aggrb=9477KB/s, minb=9477KB/s, maxb=9477KB/s, mint=60584msec, maxt=60584msec
```

### btrfs raid -m raid0 -d raid0, rw=randwrite, bs=4k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force -m raid0 -d raid0 /dev/sda /dev/sdb
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
adding device /dev/sdb id 2
fs created label (null) on /dev/sda
	nodesize 16384 leafsize 16384 sectorsize 4096 size 7.28TiB
mount -o defaults,device=/dev/sda,device=/dev/sdb /dev/sda /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.hdd -rw=randwrite -bs=4k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.hdd: (g=0): rw=randwrite, bs=4K-4K/4K-4K/4K-4K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.hdd: (groupid=0, jobs=40): err= 0: pid=7478: Tue Dec 29 18:06:56 2015
  write: io=139060KB, bw=2290.7KB/s, iops=572, runt= 60707msec
    slat (usec): min=8, max=5395.3K, avg=105525.93, stdev=481314.78
    clat (usec): min=4, max=5102.6K, avg=2123476.13, stdev=699012.15
     lat (usec): min=216, max=6245.1K, avg=2229002.07, stdev=834260.29
    clat percentiles (usec):
     |  1.00th=[  350],  5.00th=[ 2192], 10.00th=[1105920], 20.00th=[2072576],
     | 30.00th=[2211840], 40.00th=[2244608], 50.00th=[2310144], 60.00th=[2342912],
     | 70.00th=[2408448], 80.00th=[2473984], 90.00th=[2539520], 95.00th=[2703360],
     | 99.00th=[3424256], 99.50th=[3817472], 99.90th=[3948544], 99.95th=[4046848],
     | 99.99th=[5079040]
    bw (KB  /s): min=    0, max=  357, per=2.59%, avg=59.21, stdev=36.26
    lat (usec) : 10=0.01%, 50=0.01%, 100=0.02%, 250=0.11%, 500=3.27%
    lat (usec) : 750=0.36%, 1000=0.36%
    lat (msec) : 2=0.79%, 4=0.19%, 10=0.26%, 20=0.13%, 50=0.24%
    lat (msec) : 100=0.15%, 250=0.45%, 500=0.66%, 750=1.03%, 1000=1.39%
    lat (msec) : 2000=6.95%, >=2000=83.62%
  cpu          : usr=0.00%, sys=0.02%, ctx=3988, majf=0, minf=331
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=97.7%, >=64=0.0%
     submit    : 0=0.0%, 4=99.9%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.9%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=0/w=34765/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
  WRITE: io=139060KB, aggrb=2290KB/s, minb=2290KB/s, maxb=2290KB/s, mint=60707msec, maxt=60707msec
```

### btrfs raid -m raid0 -d raid0, rw=randwrite, bs=16k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force -m raid0 -d raid0 /dev/sda /dev/sdb
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
adding device /dev/sdb id 2
fs created label (null) on /dev/sda
	nodesize 16384 leafsize 16384 sectorsize 4096 size 7.28TiB
mount -o defaults,device=/dev/sda,device=/dev/sdb /dev/sda /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.hdd -rw=randwrite -bs=16k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.hdd: (g=0): rw=randwrite, bs=16K-16K/16K-16K/16K-16K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.hdd: (groupid=0, jobs=40): err= 0: pid=7560: Tue Dec 29 18:07:58 2015
  write: io=530224KB, bw=8776.4KB/s, iops=548, runt= 60415msec
    slat (usec): min=16, max=3572.8K, avg=114980.11, stdev=507787.28
    clat (usec): min=4, max=5860.4K, avg=2215077.55, stdev=731332.68
     lat (usec): min=129, max=7456.9K, avg=2330057.67, stdev=859276.31
    clat percentiles (usec):
     |  1.00th=[  516],  5.00th=[ 1032], 10.00th=[1253376], 20.00th=[2244608],
     | 30.00th=[2310144], 40.00th=[2375680], 50.00th=[2408448], 60.00th=[2441216],
     | 70.00th=[2473984], 80.00th=[2539520], 90.00th=[2605056], 95.00th=[2703360],
     | 99.00th=[3751936], 99.50th=[4177920], 99.90th=[5341184], 99.95th=[5341184],
     | 99.99th=[5865472]
    bw (KB  /s): min=    4, max= 1286, per=2.55%, avg=223.86, stdev=120.33
    lat (usec) : 10=0.02%, 50=0.03%, 100=0.03%, 250=0.17%, 500=0.63%
    lat (usec) : 750=3.76%, 1000=0.33%
    lat (msec) : 2=0.78%, 4=0.24%, 10=0.15%, 20=0.15%, 50=0.13%
    lat (msec) : 100=0.18%, 250=0.53%, 500=0.53%, 750=0.91%, 1000=0.55%
    lat (msec) : 2000=3.50%, >=2000=87.37%
  cpu          : usr=0.00%, sys=0.03%, ctx=3561, majf=0, minf=330
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=98.2%, >=64=0.0%
     submit    : 0=0.0%, 4=99.9%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.9%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=0/w=33139/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
  WRITE: io=530224KB, aggrb=8776KB/s, minb=8776KB/s, maxb=8776KB/s, mint=60415msec, maxt=60415msec
```

### btrfs raid -m raid0 -d raid1, rw=read, bs=4k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force -m raid0 -d raid1 /dev/sda /dev/sdb
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
adding device /dev/sdb id 2
fs created label (null) on /dev/sda
	nodesize 16384 leafsize 16384 sectorsize 4096 size 7.28TiB
mount -o defaults,device=/dev/sda,device=/dev/sdb /dev/sda /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.hdd -rw=read -bs=4k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.hdd: (g=0): rw=read, bs=4K-4K/4K-4K/4K-4K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.hdd: (groupid=0, jobs=40): err= 0: pid=7649: Tue Dec 29 18:09:10 2015
  read : io=5120.0MB, bw=186573KB/s, iops=46643, runt= 28101msec
    slat (usec): min=2, max=250, avg= 3.37, stdev= 4.50
    clat (usec): min=94, max=719690, avg=25749.19, stdev=99594.45
     lat (usec): min=101, max=719695, avg=25752.55, stdev=99594.66
    clat percentiles (usec):
     |  1.00th=[  314],  5.00th=[  418], 10.00th=[  450], 20.00th=[  506],
     | 30.00th=[  692], 40.00th=[  724], 50.00th=[  740], 60.00th=[  748],
     | 70.00th=[  780], 80.00th=[  820], 90.00th=[ 1976], 95.00th=[382976],
     | 99.00th=[456704], 99.50th=[468992], 99.90th=[501760], 99.95th=[509952],
     | 99.99th=[602112]
    bw (KB  /s): min=   24, max=10872, per=2.61%, avg=4869.06, stdev=1345.97
    lat (usec) : 100=0.01%, 250=0.64%, 500=18.99%, 750=39.86%, 1000=27.30%
    lat (msec) : 2=3.72%, 4=1.37%, 10=0.84%, 20=1.11%, 50=0.28%
    lat (msec) : 100=0.02%, 250=0.05%, 500=5.70%, 750=0.12%
  cpu          : usr=0.09%, sys=0.47%, ctx=250020, majf=0, minf=1653
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=100.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=1310720/w=0/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
   READ: io=5120.0MB, aggrb=186572KB/s, minb=186572KB/s, maxb=186572KB/s, mint=28101msec, maxt=28101msec
```

### btrfs raid -m raid0 -d raid1, rw=read, bs=16k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force -m raid0 -d raid1 /dev/sda /dev/sdb
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
adding device /dev/sdb id 2
fs created label (null) on /dev/sda
	nodesize 16384 leafsize 16384 sectorsize 4096 size 7.28TiB
mount -o defaults,device=/dev/sda,device=/dev/sdb /dev/sda /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.hdd -rw=read -bs=16k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.hdd: (g=0): rw=read, bs=16K-16K/16K-16K/16K-16K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.hdd: (groupid=0, jobs=40): err= 0: pid=7730: Tue Dec 29 18:10:15 2015
  read : io=5120.0MB, bw=219827KB/s, iops=13739, runt= 23850msec
    slat (usec): min=3, max=326, avg= 7.22, stdev=14.07
    clat (usec): min=132, max=861869, avg=89240.02, stdev=199448.42
     lat (usec): min=143, max=861874, avg=89247.25, stdev=199448.97
    clat percentiles (usec):
     |  1.00th=[  342],  5.00th=[ 1304], 10.00th=[ 2192], 20.00th=[ 2800],
     | 30.00th=[ 2928], 40.00th=[ 3024], 50.00th=[ 3120], 60.00th=[ 3344],
     | 70.00th=[ 4128], 80.00th=[ 4448], 90.00th=[544768], 95.00th=[561152],
     | 99.00th=[585728], 99.50th=[602112], 99.90th=[675840], 99.95th=[765952],
     | 99.99th=[839680]
    bw (KB  /s): min=   28, max=11232, per=2.55%, avg=5610.88, stdev=639.03
    lat (usec) : 250=0.07%, 500=1.89%, 750=0.32%, 1000=0.87%
    lat (msec) : 2=5.18%, 4=58.69%, 10=17.02%, 20=0.07%, 50=0.02%
    lat (msec) : 100=0.05%, 250=0.14%, 500=0.48%, 750=15.17%, 1000=0.06%
  cpu          : usr=0.07%, sys=0.31%, ctx=140670, majf=0, minf=5455
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=100.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=327680/w=0/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
   READ: io=5120.0MB, aggrb=219827KB/s, minb=219827KB/s, maxb=219827KB/s, mint=23850msec, maxt=23850msec
```

### btrfs raid -m raid0 -d raid1, rw=write, bs=4k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force -m raid0 -d raid1 /dev/sda /dev/sdb
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
adding device /dev/sdb id 2
fs created label (null) on /dev/sda
	nodesize 16384 leafsize 16384 sectorsize 4096 size 7.28TiB
mount -o defaults,device=/dev/sda,device=/dev/sdb /dev/sda /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.hdd -rw=write -bs=4k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.hdd: (g=0): rw=write, bs=4K-4K/4K-4K/4K-4K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.hdd: (groupid=0, jobs=40): err= 0: pid=7824: Tue Dec 29 18:11:17 2015
  write: io=1719.7MB, bw=29251KB/s, iops=7312, runt= 60201msec
    slat (usec): min=7, max=262687, avg=32.45, stdev=1642.15
    clat (usec): min=294, max=2416.5K, avg=174657.03, stdev=129096.56
     lat (usec): min=303, max=2425.7K, avg=174689.48, stdev=129155.58
    clat percentiles (usec):
     |  1.00th=[  482],  5.00th=[  556], 10.00th=[ 9792], 20.00th=[80384],
     | 30.00th=[92672], 40.00th=[117248], 50.00th=[173056], 60.00th=[211968],
     | 70.00th=[259072], 80.00th=[280576], 90.00th=[296960], 95.00th=[313344],
     | 99.00th=[387072], 99.50th=[602112], 99.90th=[1941504], 99.95th=[2179072],
     | 99.99th=[2310144]
    bw (KB  /s): min=    1, max=26682, per=2.51%, avg=735.39, stdev=692.74
    lat (usec) : 500=1.45%, 750=5.94%, 1000=0.34%
    lat (msec) : 2=0.92%, 4=0.26%, 10=1.26%, 20=0.91%, 50=2.22%
    lat (msec) : 100=21.36%, 250=32.13%, 500=32.54%, 750=0.36%, 1000=0.17%
    lat (msec) : 2000=0.04%, >=2000=0.09%
  cpu          : usr=0.02%, sys=0.26%, ctx=70096, majf=0, minf=376
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=99.9%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=0/w=440238/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
  WRITE: io=1719.7MB, aggrb=29251KB/s, minb=29251KB/s, maxb=29251KB/s, mint=60201msec, maxt=60201msec
```

### btrfs raid -m raid0 -d raid1, rw=write, bs=16k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force -m raid0 -d raid1 /dev/sda /dev/sdb
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
adding device /dev/sdb id 2
fs created label (null) on /dev/sda
	nodesize 16384 leafsize 16384 sectorsize 4096 size 7.28TiB
mount -o defaults,device=/dev/sda,device=/dev/sdb /dev/sda /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.hdd -rw=write -bs=16k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.hdd: (g=0): rw=write, bs=16K-16K/16K-16K/16K-16K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.hdd: (groupid=0, jobs=40): err= 0: pid=7905: Tue Dec 29 18:12:11 2015
  write: io=5120.0MB, bw=98235KB/s, iops=6139, runt= 53371msec
    slat (usec): min=15, max=217447, avg=41.32, stdev=1491.47
    clat (usec): min=577, max=3987.2K, avg=187453.71, stdev=194520.02
     lat (usec): min=603, max=3987.2K, avg=187495.03, stdev=194533.17
    clat percentiles (usec):
     |  1.00th=[ 1576],  5.00th=[11584], 10.00th=[40192], 20.00th=[102912],
     | 30.00th=[128512], 40.00th=[144384], 50.00th=[158720], 60.00th=[173056],
     | 70.00th=[191488], 80.00th=[222208], 90.00th=[305152], 95.00th=[436224],
     | 99.00th=[888832], 99.50th=[1286144], 99.90th=[2277376], 99.95th=[2932736],
     | 99.99th=[3981312]
    bw (KB  /s): min=    8, max=33588, per=2.94%, avg=2892.81, stdev=1778.93
    lat (usec) : 750=0.17%, 1000=0.24%
    lat (msec) : 2=0.93%, 4=1.93%, 10=1.38%, 20=2.40%, 50=4.48%
    lat (msec) : 100=7.53%, 250=66.19%, 500=10.77%, 750=2.41%, 1000=0.83%
    lat (msec) : 2000=0.49%, >=2000=0.24%
  cpu          : usr=0.03%, sys=0.36%, ctx=30338, majf=0, minf=368
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=100.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=0/w=327680/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
  WRITE: io=5120.0MB, aggrb=98234KB/s, minb=98234KB/s, maxb=98234KB/s, mint=53371msec, maxt=53371msec
```

### btrfs raid -m raid0 -d raid1, rw=randread, bs=4k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force -m raid0 -d raid1 /dev/sda /dev/sdb
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
adding device /dev/sdb id 2
fs created label (null) on /dev/sda
	nodesize 16384 leafsize 16384 sectorsize 4096 size 7.28TiB
mount -o defaults,device=/dev/sda,device=/dev/sdb /dev/sda /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.hdd -rw=randread -bs=4k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.hdd: (g=0): rw=randread, bs=4K-4K/4K-4K/4K-4K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.hdd: (groupid=0, jobs=40): err= 0: pid=7987: Tue Dec 29 18:13:55 2015
  read : io=147912KB, bw=2444.5KB/s, iops=611, runt= 60509msec
    slat (usec): min=3, max=2205.6K, avg=78354.95, stdev=352072.02
    clat (usec): min=649, max=2418.6K, avg=2008835.12, stdev=379242.84
     lat (usec): min=850, max=4322.9K, avg=2087190.08, stdev=469044.85
    clat percentiles (msec):
     |  1.00th=[  190],  5.00th=[ 1385], 10.00th=[ 1958], 20.00th=[ 2008],
     | 30.00th=[ 2040], 40.00th=[ 2057], 50.00th=[ 2089], 60.00th=[ 2114],
     | 70.00th=[ 2147], 80.00th=[ 2180], 90.00th=[ 2212], 95.00th=[ 2245],
     | 99.00th=[ 2343], 99.50th=[ 2343], 99.90th=[ 2409], 99.95th=[ 2409],
     | 99.99th=[ 2409]
    bw (KB  /s): min=    2, max=  251, per=2.44%, avg=59.69, stdev=21.37
    lat (usec) : 750=0.01%
    lat (msec) : 4=0.01%, 10=0.01%, 20=0.01%, 50=0.06%, 100=0.14%
    lat (msec) : 250=2.16%, 500=0.96%, 750=0.43%, 1000=0.50%, 2000=12.93%
    lat (msec) : >=2000=82.80%
  cpu          : usr=0.00%, sys=0.01%, ctx=2684, majf=0, minf=1577
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=99.9%, >=64=0.0%
     submit    : 0=0.0%, 4=99.9%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.9%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=36978/w=0/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
   READ: io=147912KB, aggrb=2444KB/s, minb=2444KB/s, maxb=2444KB/s, mint=60509msec, maxt=60509msec
```

### btrfs raid -m raid0 -d raid1, rw=randread, bs=16k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force -m raid0 -d raid1 /dev/sda /dev/sdb
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
adding device /dev/sdb id 2
fs created label (null) on /dev/sda
	nodesize 16384 leafsize 16384 sectorsize 4096 size 7.28TiB
mount -o defaults,device=/dev/sda,device=/dev/sdb /dev/sda /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.hdd -rw=randread -bs=16k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.hdd: (g=0): rw=randread, bs=16K-16K/16K-16K/16K-16K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.hdd: (groupid=0, jobs=40): err= 0: pid=8068: Tue Dec 29 18:15:37 2015
  read : io=575200KB, bw=9499.3KB/s, iops=593, runt= 60552msec
    slat (usec): min=3, max=2283.1K, avg=80191.86, stdev=360422.26
    clat (msec): min=3, max=2477, avg=2067.12, stdev=393.37
     lat (msec): min=4, max=4619, avg=2147.31, stdev=486.41
    clat percentiles (msec):
     |  1.00th=[  196],  5.00th=[ 1467], 10.00th=[ 2008], 20.00th=[ 2073],
     | 30.00th=[ 2089], 40.00th=[ 2114], 50.00th=[ 2147], 60.00th=[ 2180],
     | 70.00th=[ 2180], 80.00th=[ 2245], 90.00th=[ 2278], 95.00th=[ 2343],
     | 99.00th=[ 2442], 99.50th=[ 2474], 99.90th=[ 2474], 99.95th=[ 2474],
     | 99.99th=[ 2474]
    bw (KB  /s): min=    7, max=  919, per=2.46%, avg=233.47, stdev=84.46
    lat (msec) : 4=0.01%, 10=0.01%, 20=0.01%, 50=0.06%, 100=0.13%
    lat (msec) : 250=2.11%, 500=0.94%, 750=0.52%, 1000=0.51%, 2000=5.11%
    lat (msec) : >=2000=90.59%
  cpu          : usr=0.00%, sys=0.01%, ctx=2615, majf=0, minf=5420
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=99.9%, >=64=0.0%
     submit    : 0=0.0%, 4=99.9%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.9%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=35950/w=0/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
   READ: io=575200KB, aggrb=9499KB/s, minb=9499KB/s, maxb=9499KB/s, mint=60552msec, maxt=60552msec
```

### btrfs raid -m raid0 -d raid1, rw=randwrite, bs=4k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force -m raid0 -d raid1 /dev/sda /dev/sdb
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
adding device /dev/sdb id 2
fs created label (null) on /dev/sda
	nodesize 16384 leafsize 16384 sectorsize 4096 size 7.28TiB
mount -o defaults,device=/dev/sda,device=/dev/sdb /dev/sda /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.hdd -rw=randwrite -bs=4k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.hdd: (g=0): rw=randwrite, bs=4K-4K/4K-4K/4K-4K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.hdd: (groupid=0, jobs=40): err= 0: pid=8150: Tue Dec 29 18:16:39 2015
  write: io=71896KB, bw=1185.6KB/s, iops=296, runt= 60646msec
    slat (usec): min=9, max=4728.7K, avg=340997.91, stdev=983850.35
    clat (usec): min=3, max=7481.2K, avg=3966170.93, stdev=957487.85
     lat (msec): min=1, max=9286, avg=4307.17, stdev=1063.34
    clat percentiles (msec):
     |  1.00th=[  644],  5.00th=[ 2024], 10.00th=[ 2212], 20.00th=[ 3982],
     | 30.00th=[ 4113], 40.00th=[ 4178], 50.00th=[ 4293], 60.00th=[ 4359],
     | 70.00th=[ 4424], 80.00th=[ 4424], 90.00th=[ 4555], 95.00th=[ 4621],
     | 99.00th=[ 6128], 99.50th=[ 6521], 99.90th=[ 6915], 99.95th=[ 7439],
     | 99.99th=[ 7504]
    bw (KB  /s): min=    0, max=  188, per=2.48%, avg=29.34, stdev=14.69
    lat (usec) : 4=0.02%, 10=0.18%, 1000=0.06%
    lat (msec) : 2=0.02%, 4=0.11%, 10=0.01%, 50=0.01%, 100=0.01%
    lat (msec) : 250=0.12%, 500=0.23%, 750=0.65%, 1000=0.29%, 2000=3.01%
    lat (msec) : >=2000=95.29%
  cpu          : usr=0.00%, sys=0.01%, ctx=1504, majf=0, minf=379
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=97.7%, >=64=0.0%
     submit    : 0=0.0%, 4=99.8%, 8=0.0%, 16=0.0%, 32=0.2%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.8%, 8=0.0%, 16=0.0%, 32=0.2%, 64=0.0%, >=64=0.0%
     issued    : total=r=0/w=17974/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
  WRITE: io=71896KB, aggrb=1185KB/s, minb=1185KB/s, maxb=1185KB/s, mint=60646msec, maxt=60646msec
```

### btrfs raid -m raid0 -d raid1, rw=randwrite, bs=16k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force -m raid0 -d raid1 /dev/sda /dev/sdb
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
adding device /dev/sdb id 2
fs created label (null) on /dev/sda
	nodesize 16384 leafsize 16384 sectorsize 4096 size 7.28TiB
mount -o defaults,device=/dev/sda,device=/dev/sdb /dev/sda /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.hdd -rw=randwrite -bs=16k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.hdd: (g=0): rw=randwrite, bs=16K-16K/16K-16K/16K-16K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.hdd: (groupid=0, jobs=40): err= 0: pid=8233: Tue Dec 29 18:17:41 2015
  write: io=291456KB, bw=4811.1KB/s, iops=300, runt= 60580msec
    slat (usec): min=17, max=4437.8K, avg=328751.43, stdev=949418.26
    clat (usec): min=3, max=7467.6K, avg=3922157.45, stdev=944772.20
     lat (usec): min=678, max=8557.4K, avg=4250908.88, stdev=985803.42
    clat percentiles (msec):
     |  1.00th=[  586],  5.00th=[ 1975], 10.00th=[ 2147], 20.00th=[ 3949],
     | 30.00th=[ 4080], 40.00th=[ 4146], 50.00th=[ 4228], 60.00th=[ 4293],
     | 70.00th=[ 4293], 80.00th=[ 4424], 90.00th=[ 4555], 95.00th=[ 4686],
     | 99.00th=[ 5866], 99.50th=[ 6063], 99.90th=[ 6783], 99.95th=[ 6915],
     | 99.99th=[ 7439]
    bw (KB  /s): min=    3, max=  506, per=2.48%, avg=119.22, stdev=55.97
    lat (usec) : 4=0.04%, 10=0.14%, 20=0.01%, 50=0.01%, 250=0.02%
    lat (usec) : 500=0.02%, 750=0.03%
    lat (msec) : 2=0.04%, 10=0.09%, 50=0.01%, 100=0.01%, 250=0.04%
    lat (msec) : 500=0.33%, 750=0.57%, 1000=0.48%, 2000=3.79%, >=2000=94.36%
  cpu          : usr=0.00%, sys=0.02%, ctx=1507, majf=0, minf=337
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=97.0%, >=64=0.0%
     submit    : 0=0.0%, 4=99.8%, 8=0.0%, 16=0.0%, 32=0.2%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.8%, 8=0.0%, 16=0.0%, 32=0.2%, 64=0.0%, >=64=0.0%
     issued    : total=r=0/w=18216/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
  WRITE: io=291456KB, aggrb=4811KB/s, minb=4811KB/s, maxb=4811KB/s, mint=60580msec, maxt=60580msec
```

### btrfs raid -m raid1 -d raid0, rw=read, bs=4k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force -m raid1 -d raid0 /dev/sda /dev/sdb
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
adding device /dev/sdb id 2
fs created label (null) on /dev/sda
	nodesize 16384 leafsize 16384 sectorsize 4096 size 7.28TiB
mount -o defaults,device=/dev/sda,device=/dev/sdb /dev/sda /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.hdd -rw=read -bs=4k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.hdd: (g=0): rw=read, bs=4K-4K/4K-4K/4K-4K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.hdd: (groupid=0, jobs=40): err= 0: pid=8314: Tue Dec 29 18:19:07 2015
  read : io=1413.6MB, bw=23944KB/s, iops=5985, runt= 60451msec
    slat (usec): min=2, max=228, avg= 5.02, stdev= 8.53
    clat (usec): min=57, max=2619.4K, avg=212919.24, stdev=276565.88
     lat (usec): min=65, max=2619.5K, avg=212924.26, stdev=276566.54
    clat percentiles (usec):
     |  1.00th=[  116],  5.00th=[  243], 10.00th=[  374], 20.00th=[  490],
     | 30.00th=[  660], 40.00th=[13120], 50.00th=[31360], 60.00th=[93696],
     | 70.00th=[477184], 80.00th=[585728], 90.00th=[643072], 95.00th=[675840],
     | 99.00th=[724992], 99.50th=[749568], 99.90th=[798720], 99.95th=[897024],
     | 99.99th=[1646592]
    bw (KB  /s): min=    4, max= 4892, per=2.51%, avg=600.07, stdev=288.46
    lat (usec) : 100=0.50%, 250=4.89%, 500=15.54%, 750=12.28%, 1000=1.44%
    lat (msec) : 2=1.93%, 4=0.20%, 10=0.90%, 20=5.97%, 50=10.98%
    lat (msec) : 100=6.00%, 250=7.44%, 500=2.90%, 750=28.54%, 1000=0.45%
    lat (msec) : 2000=0.03%, >=2000=0.01%
  cpu          : usr=0.02%, sys=0.09%, ctx=69519, majf=0, minf=1616
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=99.9%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=361856/w=0/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
   READ: io=1413.6MB, aggrb=23943KB/s, minb=23943KB/s, maxb=23943KB/s, mint=60451msec, maxt=60451msec
```

### btrfs raid -m raid1 -d raid0, rw=read, bs=16k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force -m raid1 -d raid0 /dev/sda /dev/sdb
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
adding device /dev/sdb id 2
fs created label (null) on /dev/sda
	nodesize 16384 leafsize 16384 sectorsize 4096 size 7.28TiB
mount -o defaults,device=/dev/sda,device=/dev/sdb /dev/sda /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.hdd -rw=read -bs=16k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.hdd: (g=0): rw=read, bs=16K-16K/16K-16K/16K-16K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.hdd: (groupid=0, jobs=40): err= 0: pid=8396: Tue Dec 29 18:20:28 2015
  read : io=5120.0MB, bw=90781KB/s, iops=5673, runt= 57753msec
    slat (usec): min=3, max=434, avg= 8.30, stdev=14.19
    clat (usec): min=84, max=2335.1K, avg=222448.01, stdev=284573.21
     lat (usec): min=91, max=2336.2K, avg=222456.31, stdev=284573.80
    clat percentiles (usec):
     |  1.00th=[  175],  5.00th=[  274], 10.00th=[  346], 20.00th=[  588],
     | 30.00th=[  876], 40.00th=[ 1208], 50.00th=[17280], 60.00th=[232448],
     | 70.00th=[387072], 80.00th=[489472], 90.00th=[651264], 95.00th=[806912],
     | 99.00th=[905216], 99.50th=[921600], 99.90th=[1204224], 99.95th=[1433600],
     | 99.99th=[2179072]
    bw (KB  /s): min=   13, max=15395, per=2.49%, avg=2258.91, stdev=524.84
    lat (usec) : 100=0.02%, 250=3.27%, 500=13.67%, 750=8.90%, 1000=8.24%
    lat (msec) : 2=10.63%, 4=3.04%, 10=0.73%, 20=2.23%, 50=3.17%
    lat (msec) : 100=1.95%, 250=5.69%, 500=18.96%, 750=12.12%, 1000=7.13%
    lat (msec) : 2000=0.22%, >=2000=0.02%
  cpu          : usr=0.03%, sys=0.16%, ctx=163055, majf=0, minf=5457
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=100.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=327680/w=0/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
   READ: io=5120.0MB, aggrb=90781KB/s, minb=90781KB/s, maxb=90781KB/s, mint=57753msec, maxt=57753msec
```

### btrfs raid -m raid1 -d raid0, rw=write, bs=4k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force -m raid1 -d raid0 /dev/sda /dev/sdb
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
adding device /dev/sdb id 2
fs created label (null) on /dev/sda
	nodesize 16384 leafsize 16384 sectorsize 4096 size 7.28TiB
mount -o defaults,device=/dev/sda,device=/dev/sdb /dev/sda /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.hdd -rw=write -bs=4k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.hdd: (g=0): rw=write, bs=4K-4K/4K-4K/4K-4K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.hdd: (groupid=0, jobs=40): err= 0: pid=8490: Tue Dec 29 18:21:30 2015
  write: io=2515.4MB, bw=42756KB/s, iops=10689, runt= 60241msec
    slat (usec): min=7, max=235829, avg=32.60, stdev=1249.80
    clat (usec): min=36, max=2485.6K, avg=119433.29, stdev=123132.42
     lat (usec): min=50, max=2485.7K, avg=119465.89, stdev=123192.19
    clat percentiles (usec):
     |  1.00th=[  155],  5.00th=[  207], 10.00th=[  266], 20.00th=[  322],
     | 30.00th=[  430], 40.00th=[59136], 50.00th=[102912], 60.00th=[156672],
     | 70.00th=[199680], 80.00th=[220160], 90.00th=[276480], 95.00th=[296960],
     | 99.00th=[333824], 99.50th=[374784], 99.90th=[1384448], 99.95th=[1548288],
     | 99.99th=[2113536]
    bw (KB  /s): min=    2, max=16718, per=2.53%, avg=1080.85, stdev=571.03
    lat (usec) : 50=0.01%, 100=0.03%, 250=8.21%, 500=23.19%, 750=1.07%
    lat (usec) : 1000=0.34%
    lat (msec) : 2=2.87%, 4=0.08%, 10=0.78%, 20=0.66%, 50=1.19%
    lat (msec) : 100=10.68%, 250=34.54%, 500=16.09%, 750=0.10%, 1000=0.03%
    lat (msec) : 2000=0.12%, >=2000=0.01%
  cpu          : usr=0.03%, sys=0.34%, ctx=153698, majf=0, minf=372
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=99.9%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=0/w=643920/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
  WRITE: io=2515.4MB, aggrb=42756KB/s, minb=42756KB/s, maxb=42756KB/s, mint=60241msec, maxt=60241msec
```

### btrfs raid -m raid1 -d raid0, rw=write, bs=16k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force -m raid1 -d raid0 /dev/sda /dev/sdb
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
adding device /dev/sdb id 2
fs created label (null) on /dev/sda
	nodesize 16384 leafsize 16384 sectorsize 4096 size 7.28TiB
mount -o defaults,device=/dev/sda,device=/dev/sdb /dev/sda /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.hdd -rw=write -bs=16k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.hdd: (g=0): rw=write, bs=16K-16K/16K-16K/16K-16K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.hdd: (groupid=0, jobs=40): err= 0: pid=8572: Tue Dec 29 18:22:04 2015
  write: io=5120.0MB, bw=158247KB/s, iops=9890, runt= 33131msec
    slat (usec): min=15, max=157945, avg=34.45, stdev=971.31
    clat (usec): min=53, max=2177.2K, avg=125213.39, stdev=149349.25
     lat (usec): min=119, max=2177.3K, avg=125247.84, stdev=149364.18
    clat percentiles (usec):
     |  1.00th=[  223],  5.00th=[  302], 10.00th=[  406], 20.00th=[  498],
     | 30.00th=[  596], 40.00th=[  764], 50.00th=[22400], 60.00th=[171008],
     | 70.00th=[218112], 80.00th=[264192], 90.00th=[313344], 95.00th=[354304],
     | 99.00th=[481280], 99.50th=[585728], 99.90th=[1204224], 99.95th=[1499136],
     | 99.99th=[1941504]
    bw (KB  /s): min=   18, max=17150, per=2.55%, avg=4040.78, stdev=1225.04
    lat (usec) : 100=0.01%, 250=1.97%, 500=18.49%, 750=19.31%, 1000=2.49%
    lat (msec) : 2=4.40%, 4=1.14%, 10=0.74%, 20=1.35%, 50=0.76%
    lat (msec) : 100=1.66%, 250=24.41%, 500=22.37%, 750=0.61%, 1000=0.13%
    lat (msec) : 2000=0.16%, >=2000=0.01%
  cpu          : usr=0.04%, sys=0.53%, ctx=107781, majf=0, minf=374
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=100.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=0/w=327680/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
  WRITE: io=5120.0MB, aggrb=158246KB/s, minb=158246KB/s, maxb=158246KB/s, mint=33131msec, maxt=33131msec
```

### btrfs raid -m raid1 -d raid0, rw=randread, bs=4k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force -m raid1 -d raid0 /dev/sda /dev/sdb
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
adding device /dev/sdb id 2
fs created label (null) on /dev/sda
	nodesize 16384 leafsize 16384 sectorsize 4096 size 7.28TiB
mount -o defaults,device=/dev/sda,device=/dev/sdb /dev/sda /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.hdd -rw=randread -bs=4k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.hdd: (g=0): rw=randread, bs=4K-4K/4K-4K/4K-4K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.hdd: (groupid=0, jobs=40): err= 0: pid=8655: Tue Dec 29 18:23:29 2015
  read : io=153652KB, bw=2540.5KB/s, iops=635, runt= 60482msec
    slat (usec): min=3, max=3002.6K, avg=87566.84, stdev=403824.01
    clat (usec): min=127, max=3375.5K, avg=1923001.62, stdev=566332.81
     lat (usec): min=132, max=5152.3K, avg=2010568.46, stdev=699437.33
    clat percentiles (msec):
     |  1.00th=[    5],  5.00th=[   18], 10.00th=[ 1516], 20.00th=[ 1991],
     | 30.00th=[ 2024], 40.00th=[ 2057], 50.00th=[ 2073], 60.00th=[ 2089],
     | 70.00th=[ 2114], 80.00th=[ 2147], 90.00th=[ 2180], 95.00th=[ 2245],
     | 99.00th=[ 3097], 99.50th=[ 3130], 99.90th=[ 3195], 99.95th=[ 3228],
     | 99.99th=[ 3228]
    bw (KB  /s): min=    1, max=  299, per=2.51%, avg=63.71, stdev=28.93
    lat (usec) : 250=0.01%, 750=0.01%, 1000=0.01%
    lat (msec) : 2=0.01%, 4=0.84%, 10=2.79%, 20=1.52%, 50=0.37%
    lat (msec) : 100=0.07%, 250=0.44%, 500=0.61%, 750=1.04%, 1000=1.12%
    lat (msec) : 2000=14.27%, >=2000=76.91%
  cpu          : usr=0.00%, sys=0.01%, ctx=3785, majf=0, minf=1580
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=98.2%, >=64=0.0%
     submit    : 0=0.0%, 4=99.9%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.9%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=38413/w=0/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
   READ: io=153652KB, aggrb=2540KB/s, minb=2540KB/s, maxb=2540KB/s, mint=60482msec, maxt=60482msec
```

### btrfs raid -m raid1 -d raid0, rw=randread, bs=16k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force -m raid1 -d raid0 /dev/sda /dev/sdb
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
adding device /dev/sdb id 2
fs created label (null) on /dev/sda
	nodesize 16384 leafsize 16384 sectorsize 4096 size 7.28TiB
mount -o defaults,device=/dev/sda,device=/dev/sdb /dev/sda /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.hdd -rw=randread -bs=16k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.hdd: (g=0): rw=randread, bs=16K-16K/16K-16K/16K-16K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.hdd: (groupid=0, jobs=40): err= 0: pid=8736: Tue Dec 29 18:24:54 2015
  read : io=575696KB, bw=9502.7KB/s, iops=593, runt= 60583msec
    slat (usec): min=4, max=2827.6K, avg=95996.09, stdev=435174.60
    clat (usec): min=3, max=4074.5K, avg=2054267.68, stdev=605120.60
     lat (usec): min=132, max=5121.7K, avg=2150263.78, stdev=743354.49
    clat percentiles (msec):
     |  1.00th=[    4],  5.00th=[   16], 10.00th=[ 1450], 20.00th=[ 2114],
     | 30.00th=[ 2180], 40.00th=[ 2180], 50.00th=[ 2212], 60.00th=[ 2245],
     | 70.00th=[ 2278], 80.00th=[ 2311], 90.00th=[ 2376], 95.00th=[ 2474],
     | 99.00th=[ 2868], 99.50th=[ 2933], 99.90th=[ 3130], 99.95th=[ 3392],
     | 99.99th=[ 3458]
    bw (KB  /s): min=    5, max= 1516, per=2.54%, avg=241.55, stdev=123.66
    lat (usec) : 4=0.01%, 10=0.01%, 20=0.01%, 250=0.01%, 750=0.01%
    lat (usec) : 1000=0.01%
    lat (msec) : 2=0.01%, 4=1.13%, 10=2.83%, 20=1.25%, 50=0.27%
    lat (msec) : 100=0.13%, 250=0.40%, 500=0.61%, 750=0.86%, 1000=1.36%
    lat (msec) : 2000=2.95%, >=2000=88.20%
  cpu          : usr=0.00%, sys=0.01%, ctx=3524, majf=0, minf=5418
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=98.0%, >=64=0.0%
     submit    : 0=0.0%, 4=99.9%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.9%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=35981/w=0/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
   READ: io=575696KB, aggrb=9502KB/s, minb=9502KB/s, maxb=9502KB/s, mint=60583msec, maxt=60583msec
```

### btrfs raid -m raid1 -d raid0, rw=randwrite, bs=4k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force -m raid1 -d raid0 /dev/sda /dev/sdb
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
adding device /dev/sdb id 2
fs created label (null) on /dev/sda
	nodesize 16384 leafsize 16384 sectorsize 4096 size 7.28TiB
mount -o defaults,device=/dev/sda,device=/dev/sdb /dev/sda /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.hdd -rw=randwrite -bs=4k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.hdd: (g=0): rw=randwrite, bs=4K-4K/4K-4K/4K-4K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.hdd: (groupid=0, jobs=40): err= 0: pid=8817: Tue Dec 29 18:25:56 2015
  write: io=140832KB, bw=2325.6KB/s, iops=581, runt= 60559msec
    slat (usec): min=8, max=3341.5K, avg=106377.88, stdev=468875.88
    clat (usec): min=5, max=5188.7K, avg=2088177.31, stdev=654387.13
     lat (usec): min=175, max=6474.5K, avg=2194555.19, stdev=813192.12
    clat percentiles (usec):
     |  1.00th=[  342],  5.00th=[  932], 10.00th=[1433600], 20.00th=[2088960],
     | 30.00th=[2146304], 40.00th=[2179072], 50.00th=[2277376], 60.00th=[2310144],
     | 70.00th=[2342912], 80.00th=[2408448], 90.00th=[2473984], 95.00th=[2539520],
     | 99.00th=[3063808], 99.50th=[3325952], 99.90th=[4079616], 99.95th=[4079616],
     | 99.99th=[5210112]
    bw (KB  /s): min=    1, max=  302, per=2.55%, avg=59.33, stdev=31.50
    lat (usec) : 10=0.01%, 50=0.01%, 100=0.01%, 250=0.10%, 500=4.04%
    lat (usec) : 750=0.42%, 1000=0.50%
    lat (msec) : 2=0.87%, 4=0.20%, 10=0.08%, 20=0.07%, 50=0.22%
    lat (msec) : 100=0.08%, 250=0.10%, 500=0.37%, 750=1.11%, 1000=0.66%
    lat (msec) : 2000=5.03%, >=2000=86.11%
  cpu          : usr=0.00%, sys=0.02%, ctx=4194, majf=0, minf=333
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=98.1%, >=64=0.0%
     submit    : 0=0.0%, 4=99.9%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.9%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=0/w=35208/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
  WRITE: io=140832KB, aggrb=2325KB/s, minb=2325KB/s, maxb=2325KB/s, mint=60559msec, maxt=60559msec
```

### btrfs raid -m raid1 -d raid0, rw=randwrite, bs=16k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force -m raid1 -d raid0 /dev/sda /dev/sdb
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
adding device /dev/sdb id 2
fs created label (null) on /dev/sda
	nodesize 16384 leafsize 16384 sectorsize 4096 size 7.28TiB
mount -o defaults,device=/dev/sda,device=/dev/sdb /dev/sda /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.hdd -rw=randwrite -bs=16k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.hdd: (g=0): rw=randwrite, bs=16K-16K/16K-16K/16K-16K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.hdd: (groupid=0, jobs=40): err= 0: pid=8899: Tue Dec 29 18:26:58 2015
  write: io=545312KB, bw=8993.6KB/s, iops=562, runt= 60634msec
    slat (usec): min=16, max=4279.4K, avg=105164.07, stdev=476344.53
    clat (usec): min=3, max=5083.2K, avg=2168187.51, stdev=745770.05
     lat (usec): min=131, max=7456.4K, avg=2273351.59, stdev=859917.68
    clat percentiles (usec):
     |  1.00th=[  580],  5.00th=[83456], 10.00th=[1056768], 20.00th=[2113536],
     | 30.00th=[2244608], 40.00th=[2310144], 50.00th=[2375680], 60.00th=[2408448],
     | 70.00th=[2473984], 80.00th=[2539520], 90.00th=[2605056], 95.00th=[2736128],
     | 99.00th=[3981312], 99.50th=[4358144], 99.90th=[4751360], 99.95th=[4882432],
     | 99.99th=[5079040]
    bw (KB  /s): min=    3, max= 2055, per=2.73%, avg=245.42, stdev=193.71
    lat (usec) : 4=0.01%, 10=0.03%, 20=0.01%, 50=0.04%, 100=0.02%
    lat (usec) : 250=0.09%, 500=0.22%, 750=1.54%, 1000=0.11%
    lat (msec) : 2=0.62%, 4=0.28%, 10=0.14%, 20=0.28%, 50=0.84%
    lat (msec) : 100=0.99%, 250=1.10%, 500=1.46%, 750=1.18%, 1000=0.68%
    lat (msec) : 2000=8.57%, >=2000=81.80%
  cpu          : usr=0.00%, sys=0.03%, ctx=3981, majf=0, minf=334
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=98.1%, >=64=0.0%
     submit    : 0=0.0%, 4=99.9%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.9%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=0/w=34082/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
  WRITE: io=545312KB, aggrb=8993KB/s, minb=8993KB/s, maxb=8993KB/s, mint=60634msec, maxt=60634msec
```

### btrfs raid -m raid1 -d raid1, rw=read, bs=4k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force -m raid1 -d raid1 /dev/sda /dev/sdb
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
adding device /dev/sdb id 2
fs created label (null) on /dev/sda
	nodesize 16384 leafsize 16384 sectorsize 4096 size 7.28TiB
mount -o defaults,device=/dev/sda,device=/dev/sdb /dev/sda /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.hdd -rw=read -bs=4k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.hdd: (g=0): rw=read, bs=4K-4K/4K-4K/4K-4K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.hdd: (groupid=0, jobs=40): err= 0: pid=8985: Tue Dec 29 18:28:09 2015
  read : io=5120.0MB, bw=187125KB/s, iops=46781, runt= 28018msec
    slat (usec): min=2, max=245, avg= 3.36, stdev= 4.35
    clat (usec): min=94, max=843686, avg=25867.52, stdev=101677.72
     lat (usec): min=99, max=843689, avg=25870.87, stdev=101677.93
    clat percentiles (usec):
     |  1.00th=[  322],  5.00th=[  426], 10.00th=[  454], 20.00th=[  588],
     | 30.00th=[  700], 40.00th=[  724], 50.00th=[  740], 60.00th=[  756],
     | 70.00th=[  780], 80.00th=[  820], 90.00th=[ 1960], 95.00th=[399360],
     | 99.00th=[468992], 99.50th=[485376], 99.90th=[514048], 99.95th=[514048],
     | 99.99th=[684032]
    bw (KB  /s): min=    7, max=19250, per=2.63%, avg=4915.49, stdev=1585.22
    lat (usec) : 100=0.01%, 250=0.61%, 500=16.13%, 750=41.74%, 1000=28.61%
    lat (msec) : 2=3.82%, 4=1.47%, 10=0.71%, 20=0.92%, 50=0.25%
    lat (msec) : 100=0.01%, 250=0.08%, 500=5.40%, 750=0.23%, 1000=0.01%
  cpu          : usr=0.09%, sys=0.47%, ctx=245395, majf=0, minf=1615
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=100.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=1310720/w=0/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
   READ: io=5120.0MB, aggrb=187125KB/s, minb=187125KB/s, maxb=187125KB/s, mint=28018msec, maxt=28018msec
```

### btrfs raid -m raid1 -d raid1, rw=read, bs=16k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force -m raid1 -d raid1 /dev/sda /dev/sdb
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
adding device /dev/sdb id 2
fs created label (null) on /dev/sda
	nodesize 16384 leafsize 16384 sectorsize 4096 size 7.28TiB
mount -o defaults,device=/dev/sda,device=/dev/sdb /dev/sda /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.hdd -rw=read -bs=16k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.hdd: (g=0): rw=read, bs=16K-16K/16K-16K/16K-16K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.hdd: (groupid=0, jobs=40): err= 0: pid=9067: Tue Dec 29 18:29:14 2015
  read : io=5120.0MB, bw=224949KB/s, iops=14059, runt= 23307msec
    slat (usec): min=3, max=340, avg= 7.31, stdev=14.24
    clat (usec): min=132, max=817377, avg=88967.00, stdev=198671.57
     lat (usec): min=140, max=817381, avg=88974.31, stdev=198672.09
    clat percentiles (usec):
     |  1.00th=[  346],  5.00th=[ 1336], 10.00th=[ 2224], 20.00th=[ 2800],
     | 30.00th=[ 2896], 40.00th=[ 2992], 50.00th=[ 3120], 60.00th=[ 3280],
     | 70.00th=[ 4128], 80.00th=[ 4384], 90.00th=[544768], 95.00th=[561152],
     | 99.00th=[577536], 99.50th=[593920], 99.90th=[618496], 99.95th=[716800],
     | 99.99th=[774144]
    bw (KB  /s): min=   29, max=11401, per=2.51%, avg=5645.43, stdev=653.34
    lat (usec) : 250=0.07%, 500=1.88%, 750=0.29%, 1000=0.83%
    lat (msec) : 2=5.19%, 4=58.66%, 10=17.08%, 20=0.05%, 50=0.05%
    lat (msec) : 100=0.03%, 250=0.14%, 500=0.65%, 750=15.04%, 1000=0.04%
  cpu          : usr=0.06%, sys=0.32%, ctx=142280, majf=0, minf=5455
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=100.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=327680/w=0/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
   READ: io=5120.0MB, aggrb=224948KB/s, minb=224948KB/s, maxb=224948KB/s, mint=23307msec, maxt=23307msec
```

### btrfs raid -m raid1 -d raid1, rw=write, bs=4k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force -m raid1 -d raid1 /dev/sda /dev/sdb
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
adding device /dev/sdb id 2
fs created label (null) on /dev/sda
	nodesize 16384 leafsize 16384 sectorsize 4096 size 7.28TiB
mount -o defaults,device=/dev/sda,device=/dev/sdb /dev/sda /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.hdd -rw=write -bs=4k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.hdd: (g=0): rw=write, bs=4K-4K/4K-4K/4K-4K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.hdd: (groupid=0, jobs=40): err= 0: pid=9149: Tue Dec 29 18:30:16 2015
  write: io=1661.7MB, bw=28252KB/s, iops=7063, runt= 60225msec
    slat (usec): min=7, max=177795, avg=27.31, stdev=1024.28
    clat (usec): min=290, max=2432.2K, avg=180790.67, stdev=112998.09
     lat (usec): min=302, max=2471.4K, avg=180817.98, stdev=113059.67
    clat percentiles (usec):
     |  1.00th=[  516],  5.00th=[ 7904], 10.00th=[66048], 20.00th=[96768],
     | 30.00th=[129536], 40.00th=[150528], 50.00th=[179200], 60.00th=[207872],
     | 70.00th=[232448], 80.00th=[254976], 90.00th=[288768], 95.00th=[305152],
     | 99.00th=[366592], 99.50th=[561152], 99.90th=[1613824], 99.95th=[1957888],
     | 99.99th=[2277376]
    bw (KB  /s): min=    1, max=11240, per=2.54%, avg=716.71, stdev=442.66
    lat (usec) : 500=0.65%, 750=3.29%, 1000=0.22%
    lat (msec) : 2=0.52%, 4=0.16%, 10=0.67%, 20=0.81%, 50=2.07%
    lat (msec) : 100=12.47%, 250=56.82%, 500=21.73%, 750=0.32%, 1000=0.05%
    lat (msec) : 2000=0.17%, >=2000=0.05%
  cpu          : usr=0.02%, sys=0.25%, ctx=62035, majf=0, minf=377
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=99.9%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=0/w=425373/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
  WRITE: io=1661.7MB, aggrb=28252KB/s, minb=28252KB/s, maxb=28252KB/s, mint=60225msec, maxt=60225msec
```

### btrfs raid -m raid1 -d raid1, rw=write, bs=16k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force -m raid1 -d raid1 /dev/sda /dev/sdb
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
adding device /dev/sdb id 2
fs created label (null) on /dev/sda
	nodesize 16384 leafsize 16384 sectorsize 4096 size 7.28TiB
mount -o defaults,device=/dev/sda,device=/dev/sdb /dev/sda /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.hdd -rw=write -bs=16k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.hdd: (g=0): rw=write, bs=16K-16K/16K-16K/16K-16K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.hdd: (groupid=0, jobs=40): err= 0: pid=9243: Tue Dec 29 18:31:12 2015
  write: io=5120.0MB, bw=95764KB/s, iops=5985, runt= 54748msec
    slat (usec): min=15, max=165319, avg=33.42, stdev=902.20
    clat (usec): min=586, max=3309.5K, avg=186107.01, stdev=229228.76
     lat (usec): min=603, max=3309.5K, avg=186140.44, stdev=229231.57
    clat percentiles (usec):
     |  1.00th=[ 1448],  5.00th=[ 9280], 10.00th=[22912], 20.00th=[71168],
     | 30.00th=[100864], 40.00th=[124416], 50.00th=[144384], 60.00th=[164864],
     | 70.00th=[193536], 80.00th=[228352], 90.00th=[305152], 95.00th=[514048],
     | 99.00th=[1269760], 99.50th=[1515520], 99.90th=[2801664], 99.95th=[2899968],
     | 99.99th=[3194880]
    bw (KB  /s): min=    8, max=26984, per=3.15%, avg=3018.43, stdev=1806.84
    lat (usec) : 750=0.18%, 1000=0.35%
    lat (msec) : 2=1.09%, 4=2.04%, 10=1.57%, 20=3.74%, 50=6.84%
    lat (msec) : 100=13.86%, 250=55.12%, 500=10.02%, 750=2.42%, 1000=1.13%
    lat (msec) : 2000=1.36%, >=2000=0.26%
  cpu          : usr=0.03%, sys=0.36%, ctx=32444, majf=0, minf=423
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=100.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=0/w=327680/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
  WRITE: io=5120.0MB, aggrb=95763KB/s, minb=95763KB/s, maxb=95763KB/s, mint=54748msec, maxt=54748msec
```

### btrfs raid -m raid1 -d raid1, rw=randread, bs=4k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force -m raid1 -d raid1 /dev/sda /dev/sdb
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
adding device /dev/sdb id 2
fs created label (null) on /dev/sda
	nodesize 16384 leafsize 16384 sectorsize 4096 size 7.28TiB
mount -o defaults,device=/dev/sda,device=/dev/sdb /dev/sda /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.hdd -rw=randread -bs=4k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.hdd: (g=0): rw=randread, bs=4K-4K/4K-4K/4K-4K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.hdd: (groupid=0, jobs=40): err= 0: pid=9325: Tue Dec 29 18:32:55 2015
  read : io=148120KB, bw=2446.1KB/s, iops=611, runt= 60532msec
    slat (usec): min=3, max=2209.3K, avg=78177.46, stdev=352518.45
    clat (usec): min=370, max=2542.6K, avg=2006308.85, stdev=381817.13
     lat (usec): min=563, max=4561.3K, avg=2084486.31, stdev=475088.10
    clat percentiles (msec):
     |  1.00th=[  192],  5.00th=[ 1336], 10.00th=[ 1958], 20.00th=[ 2008],
     | 30.00th=[ 2040], 40.00th=[ 2057], 50.00th=[ 2089], 60.00th=[ 2114],
     | 70.00th=[ 2114], 80.00th=[ 2147], 90.00th=[ 2212], 95.00th=[ 2245],
     | 99.00th=[ 2376], 99.50th=[ 2442], 99.90th=[ 2474], 99.95th=[ 2540],
     | 99.99th=[ 2540]
    bw (KB  /s): min=    1, max=  247, per=2.45%, avg=60.00, stdev=22.22
    lat (usec) : 500=0.01%
    lat (msec) : 4=0.01%, 10=0.01%, 20=0.02%, 50=0.05%, 100=0.15%
    lat (msec) : 250=2.22%, 500=0.86%, 750=0.67%, 1000=0.42%, 2000=13.76%
    lat (msec) : >=2000=81.83%
  cpu          : usr=0.00%, sys=0.01%, ctx=2684, majf=0, minf=1632
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=99.9%, >=64=0.0%
     submit    : 0=0.0%, 4=99.9%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.9%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=37030/w=0/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
   READ: io=148120KB, aggrb=2446KB/s, minb=2446KB/s, maxb=2446KB/s, mint=60532msec, maxt=60532msec
```

### btrfs raid -m raid1 -d raid1, rw=randread, bs=16k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force -m raid1 -d raid1 /dev/sda /dev/sdb
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
adding device /dev/sdb id 2
fs created label (null) on /dev/sda
	nodesize 16384 leafsize 16384 sectorsize 4096 size 7.28TiB
mount -o defaults,device=/dev/sda,device=/dev/sdb /dev/sda /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.hdd -rw=randread -bs=16k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.hdd: (g=0): rw=randread, bs=16K-16K/16K-16K/16K-16K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.hdd: (groupid=0, jobs=40): err= 0: pid=9407: Tue Dec 29 18:34:37 2015
  read : io=572608KB, bw=9459.5KB/s, iops=591, runt= 60533msec
    slat (usec): min=3, max=2289.4K, avg=83922.73, stdev=370339.22
    clat (msec): min=3, max=2522, avg=2071.55, stdev=401.01
     lat (msec): min=3, max=4669, avg=2155.47, stdev=502.62
    clat percentiles (msec):
     |  1.00th=[  192],  5.00th=[ 1352], 10.00th=[ 1975], 20.00th=[ 2089],
     | 30.00th=[ 2114], 40.00th=[ 2147], 50.00th=[ 2147], 60.00th=[ 2180],
     | 70.00th=[ 2212], 80.00th=[ 2212], 90.00th=[ 2278], 95.00th=[ 2343],
     | 99.00th=[ 2442], 99.50th=[ 2474], 99.90th=[ 2507], 99.95th=[ 2507],
     | 99.99th=[ 2507]
    bw (KB  /s): min=    7, max= 1000, per=2.46%, avg=232.40, stdev=82.75
    lat (msec) : 4=0.01%, 10=0.01%, 20=0.01%, 50=0.08%, 100=0.25%
    lat (msec) : 250=2.03%, 500=1.05%, 750=0.53%, 1000=0.52%, 2000=6.42%
    lat (msec) : >=2000=89.11%
  cpu          : usr=0.00%, sys=0.01%, ctx=2597, majf=0, minf=5417
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=99.8%, >=64=0.0%
     submit    : 0=0.0%, 4=99.9%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.9%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, >=64=0.0%
     issued    : total=r=35788/w=0/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
   READ: io=572608KB, aggrb=9459KB/s, minb=9459KB/s, maxb=9459KB/s, mint=60533msec, maxt=60533msec
```

### btrfs raid -m raid1 -d raid1, rw=randwrite, bs=4k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force -m raid1 -d raid1 /dev/sda /dev/sdb
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
adding device /dev/sdb id 2
fs created label (null) on /dev/sda
	nodesize 16384 leafsize 16384 sectorsize 4096 size 7.28TiB
mount -o defaults,device=/dev/sda,device=/dev/sdb /dev/sda /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.hdd -rw=randwrite -bs=4k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.hdd: (g=0): rw=randwrite, bs=4K-4K/4K-4K/4K-4K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.hdd: (groupid=0, jobs=40): err= 0: pid=9488: Tue Dec 29 18:35:39 2015
  write: io=74372KB, bw=1229.6KB/s, iops=307, runt= 60488msec
    slat (usec): min=9, max=4552.4K, avg=329585.36, stdev=955445.61
    clat (usec): min=3, max=6502.4K, avg=3825728.44, stdev=967508.38
     lat (msec): min=1, max=8875, avg=4155.31, stdev=1056.47
    clat percentiles (msec):
     |  1.00th=[  449],  5.00th=[ 1860], 10.00th=[ 2089], 20.00th=[ 3851],
     | 30.00th=[ 3982], 40.00th=[ 4080], 50.00th=[ 4146], 60.00th=[ 4178],
     | 70.00th=[ 4293], 80.00th=[ 4359], 90.00th=[ 4424], 95.00th=[ 4686],
     | 99.00th=[ 5211], 99.50th=[ 5997], 99.90th=[ 6128], 99.95th=[ 6128],
     | 99.99th=[ 6521]
    bw (KB  /s): min=    0, max=  339, per=2.50%, avg=30.72, stdev=19.33
    lat (usec) : 4=0.02%, 10=0.16%, 750=0.02%, 1000=0.04%
    lat (msec) : 2=0.06%, 4=0.02%, 10=0.12%, 20=0.01%, 50=0.01%
    lat (msec) : 100=0.02%, 250=0.22%, 500=0.36%, 750=0.91%, 1000=0.51%
    lat (msec) : 2000=5.14%, >=2000=92.38%
  cpu          : usr=0.00%, sys=0.01%, ctx=1620, majf=0, minf=338
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=98.6%, >=64=0.0%
     submit    : 0=0.0%, 4=99.8%, 8=0.0%, 16=0.0%, 32=0.2%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.8%, 8=0.0%, 16=0.0%, 32=0.2%, 64=0.0%, >=64=0.0%
     issued    : total=r=0/w=18593/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
  WRITE: io=74372KB, aggrb=1229KB/s, minb=1229KB/s, maxb=1229KB/s, mint=60488msec, maxt=60488msec
```

### btrfs raid -m raid1 -d raid1, rw=randwrite, bs=16k

* Make and mount filesystem

```
umount -f /mnt/btrfs
mkfs.btrfs --force -m raid1 -d raid1 /dev/sda /dev/sdb
btrfs-progs v4.0.1
See http://btrfs.wiki.kernel.org for more information.

Turning ON incompat feature 'extref': increased hardlink limit per file to 65536
Turning ON incompat feature 'skinny-metadata': reduced-size metadata extent refs
adding device /dev/sdb id 2
fs created label (null) on /dev/sda
	nodesize 16384 leafsize 16384 sectorsize 4096 size 7.28TiB
mount -o defaults,device=/dev/sda,device=/dev/sdb /dev/sda /mnt/btrfs
```

* Run fio benchmark

```
fio -directory=/mnt/btrfs -name=btrfs.hdd -rw=randwrite -bs=16k -size=128m -numjobs=40 -runtime=60 -direct=1 -invalidate=1 -ioengine=libaio -iodepth=32 -iodepth_batch=32 -group_reporting
btrfs.hdd: (g=0): rw=randwrite, bs=16K-16K/16K-16K/16K-16K, ioengine=libaio, iodepth=32
...
fio-2.2.9
Starting 40 processes
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)
btrfs.hdd: Laying out IO file(s) (1 file(s) / 128MB)

btrfs.hdd: (groupid=0, jobs=40): err= 0: pid=9569: Tue Dec 29 18:36:42 2015
  write: io=276112KB, bw=4559.2KB/s, iops=284, runt= 60562msec
    slat (usec): min=17, max=4698.5K, avg=364099.12, stdev=1024088.91
    clat (usec): min=3, max=7071.8K, avg=4115550.04, stdev=1026901.18
     lat (usec): min=558, max=9197.1K, avg=4479649.17, stdev=1101933.38
    clat percentiles (msec):
     |  1.00th=[  510],  5.00th=[ 2089], 10.00th=[ 2278], 20.00th=[ 4113],
     | 30.00th=[ 4293], 40.00th=[ 4359], 50.00th=[ 4490], 60.00th=[ 4555],
     | 70.00th=[ 4621], 80.00th=[ 4686], 90.00th=[ 4752], 95.00th=[ 4817],
     | 99.00th=[ 6128], 99.50th=[ 6521], 99.90th=[ 6915], 99.95th=[ 7046],
     | 99.99th=[ 7046]
    bw (KB  /s): min=    3, max=  738, per=2.51%, avg=114.35, stdev=62.48
    lat (usec) : 4=0.02%, 10=0.18%, 20=0.01%, 50=0.02%, 100=0.01%
    lat (usec) : 250=0.02%, 500=0.02%, 750=0.03%, 1000=0.03%
    lat (msec) : 2=0.09%, 4=0.02%, 10=0.01%, 100=0.02%, 250=0.13%
    lat (msec) : 500=0.31%, 750=0.83%, 1000=0.46%, 2000=1.80%, >=2000=95.98%
  cpu          : usr=0.00%, sys=0.02%, ctx=1453, majf=0, minf=341
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=97.7%, >=64=0.0%
     submit    : 0=0.0%, 4=99.8%, 8=0.0%, 16=0.0%, 32=0.2%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.8%, 8=0.0%, 16=0.0%, 32=0.2%, 64=0.0%, >=64=0.0%
     issued    : total=r=0/w=17257/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
  WRITE: io=276112KB, aggrb=4559KB/s, minb=4559KB/s, maxb=4559KB/s, mint=60562msec, maxt=60562msec
```

