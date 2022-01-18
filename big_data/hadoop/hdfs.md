## HDFS

### HDFS 配置
```hadoop-env.sh
hadoop_secondarynamenode_opts -server -XX:ParallelGCThreads=8 -XX:+UseConcMarkSweepGC -XX:NewRatio=3 -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=5 -XX:GCLogFileSize=100M -XX:CMSInitiatingOccupancyFraction=80 -XX:+UseCMSInitiatingOccupancyOnly -XX:+DisableExplicitGC

yarn_nodemanager_heapsize 1536

hadoop_namenode_heapsize 1792

yarn_resourcemanager_heapsize 2304

hadoop_datanode_opts -Dhadoop.security.logger=ERROR,RFAS $HADOOP_DATANODE_OPTS

hadoop_secondary_namenode_heapsize 1024

hadoop_namenode_opts -server -XX:ParallelGCThreads=8 -XX:+UseConcMarkSweepGC -XX:NewRatio=3 -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=5 -XX:GCLogFileSize=100M -XX:CMSInitiatingOccupancyFraction=80 -XX:+UseCMSInitiatingOccupancyOnly -XX:+DisableExplicitGC

hadoop_datanode_heapsize 1152
```

```hdfs-site.xml
dfs.balancer.address 0.0.0.0:0
dfs.balancer.block-move.timeout 600000
dfs.balancer.kerberos.principal
dfs.balancer.keytab.enabled false
dfs.balancer.keytab.file
dfs.balancer.max-iteration-time 1200000
dfs.balancer.max-no-move-interval 60000

dfs.block.local-path-access.user
dfs.block.scanner.volume.bytes.per.second 1048576
dfs.blockreport.initialDelay 0
dfs.blockreport.intervalMsec 21600000
dfs.blockreport.split.threshold 1000000
dfs.blocksize 134217728

dfs.bytes-per-checksum 512

dfs.cachereport.intervalMsec 10000

dfs.client-write-packet-size 65536
dfs.client.block.write.locateFollowingBlock.initial.delay.ms 400
dfs.client.block.write.locateFollowingBlock.retries 8
dfs.client.block.write.replace-datanode-on-failure.best-effort false
dfs.client.block.write.replace-datanode-on-failure.enable true
dfs.client.block.write.replace-datanode-on-failure.min-replication 0
dfs.client.block.write.replace-datanode-on-failure.policy DEFAULT
dfs.client.block.write.retries 3
dfs.client.cache.drop.behind.reads
dfs.client.cache.drop.behind.writes
dfs.client.cache.readahead
dfs.client.context default
dfs.client.datanode-restart.timeout 30
dfs.client.domain.socket.data.traffic false
dfs.client.failover.connection.retries 0
dfs.client.failover.connection.retries.on.timeouts 0
dfs.client.failover.max.attempts 15
dfs.client.failover.sleep.base.millis 500
dfs.client.failover.sleep.max.millis 15000
dfs.client.file-block-storage-locations.num-threads 10
dfs.client.file-block-storage-locations.timeout.millis 60000
dfs.client.local.interfaces
dfs.client.mmap.cache.size 256
dfs.client.mmap.cache.timeout.ms 3600000
dfs.client.mmap.enabled true
dfs.client.mmap.retry.timeout.ms 300000
dfs.client.read.shortcircuit true
dfs.client.read.shortcircuit.skip.checksum false
dfs.client.read.shortcircuit.streams.cache.expiry.ms 300000
dfs.client.read.shortcircuit.streams.cache.size 256
dfs.client.server-defaults.validity.period.ms 3600000
dfs.client.short.circuit.replica.stale.threshold.ms 1800000
dfs.client.slow.io.warning.threshold.ms 30000
dfs.client.socket.send.buffer.size 0
dfs.client.use.datanode.hostname false
dfs.client.use.legacy.blockreader.local false
dfs.client.write.exclude.nodes.cache.expiry.interval.millis 600000

dfs.data.transfer.protection
dfs.data.transfer.saslproperties.resolver.class

dfs.datanode.available-space-volume-choosing-policy.balanced-space-preference-fraction 0.75f
dfs.datanode.available-space-volume-choosing-policy.balanced-space-threshold 10737418240
dfs.datanode.balance.bandwidthPerSec 104857600
dfs.datanode.balance.max.concurrent.moves 20
dfs.datanode.block-pinning.enabled false
dfs.datanode.block.id.layout.upgrade.threads 12
dfs.datanode.bp-ready.timeout 20
dfs.datanode.cache.revocation.polling.ms 500
dfs.datanode.cache.revocation.timeout.ms 900000

dfs.datanode.data.dir {% set comma = joiner(',') %}{% for idx in range(diskCnt) -%}{% if idx+1 not in faulty -%}{{ comma() }}file:///mnt/disk{{ idx + 1 }}/hdfs{% endif %}{% endfor %}

dfs.datanode.data.dir.perm 755
dfs.datanode.directoryscan.interval 21600
dfs.datanode.directoryscan.threads 1
dfs.datanode.directoryscan.throttle.limit.ms.per.sec 1000
dfs.datanode.drop.cache.behind.reads false
dfs.datanode.drop.cache.behind.writes false
dfs.datanode.du.reserved 8589934592
dfs.datanode.failed.volumes.tolerated 0
dfs.datanode.fsdatasetcache.max.threads.per.volume 4
dfs.datanode.handler.count 30
dfs.datanode.hdfs-blocks-metadata.enabled true
dfs.datanode.imbalance.threshold 10
dfs.datanode.kerberos.principal
dfs.datanode.lifeline.interval.seconds
dfs.datanode.max.locked.memory 0
dfs.datanode.max.transfer.threads 4096
dfs.datanode.metrics.logger.period.seconds 600
dfs.datanode.plugins
dfs.datanode.readahead.bytes 4194304
dfs.datanode.scan.period.hours 504
dfs.datanode.shared.file.descriptor.paths /dev/shm,/tmp
dfs.datanode.slow.io.warning.threshold.ms 300
dfs.datanode.sync.behind.writes false
dfs.datanode.transfer.socket.recv.buffer.size 0
dfs.datanode.transfer.socket.send.buffer.size 0
dfs.datanode.use.datanode.hostname false

dfs.domain.socket.path /var/lib/hadoop-hdfs/dn_socket

dfs.encrypt.data.transfer false
dfs.encrypt.data.transfer.algorithm
dfs.encrypt.data.transfer.cipher.key.bitlength 128
dfs.encrypt.data.transfer.cipher.suites

dfs.ha.automatic-failover.enabled false
dfs.ha.log-roll.period 120
dfs.ha.namenode.id
dfs.ha.namenodes.EXAMPLENAMESERVICE
dfs.ha.tail-edits.period 60
dfs.ha.zkfc.nn.http.timeout.ms 20000

dfs.heartbeat.interval 3

dfs.hosts
dfs.hosts.exclude /etc/ecm/hadoop-conf/dfs.exclude

dfs.http.address 0.0.0.0:50070
dfs.http.client.failover.max.attempts 15
dfs.http.client.failover.sleep.base.millis 500
dfs.http.client.failover.sleep.max.millis 15000
dfs.http.client.retry.max.attempts 10
dfs.http.client.retry.policy.enabled false
dfs.http.client.retry.policy.spec 10000,6,60000,10

dfs.image.compress false
dfs.image.compression.codec org.apache.hadoop.io.compress.DefaultCodec
dfs.image.transfer-bootstrap-standby.bandwidthPerSec 0
dfs.image.transfer.bandwidthPerSec 0
dfs.image.transfer.chunksize 65536
dfs.image.transfer.timeout 60000

dfs.internal.nameservices

dfs.journalnode.kerberos.internal.spnego.principal
dfs.journalnode.kerberos.principal
dfs.journalnode.keytab.file

dfs.lock.suppress.warning.interval 10s

dfs.metrics.percentiles.intervals

dfs.mover.max-no-move-interval 60000

dfs.namenode.accesstime.precision 3600000
dfs.namenode.acls.enabled false
dfs.namenode.audit.log.debug.cmdlist
dfs.namenode.audit.loggers default
dfs.namenode.avoid.read.stale.datanode false
dfs.namenode.avoid.write.stale.datanode false
dfs.namenode.balancer.request.standby true
dfs.namenode.block-placement-policy.default.prefer-local-node true
dfs.namenode.blocks.per.postponedblocks.rescan 10000
dfs.namenode.checkpoint.check.period 60
dfs.namenode.checkpoint.dir file:///mnt/disk1/hdfs/namesecondary
dfs.namenode.checkpoint.edits.dir ${dfs.namenode.checkpoint.dir}
dfs.namenode.checkpoint.max-retries 3
dfs.namenode.checkpoint.period 3600
dfs.namenode.checkpoint.txns 1000000
dfs.namenode.datanode.registration.ip-hostname-check false
dfs.namenode.decommission.blocks.per.interval 500000
dfs.namenode.decommission.interval 30
dfs.namenode.decommission.max.concurrent.tracked.nodes 100
dfs.namenode.delegation.key.update-interval 86400000
dfs.namenode.delegation.token.max-lifetime 604800000
dfs.namenode.delegation.token.renew-interval 86400000
dfs.namenode.edekcacheloader.initial.delay.ms 3000
dfs.namenode.edekcacheloader.interval.ms 1000
dfs.namenode.edit.log.autoroll.check.interval.ms 300000
dfs.namenode.edit.log.autoroll.multiplier.threshold 2.0
dfs.namenode.edits.asynclogging true
dfs.namenode.edits.dir file:///mnt/disk1/hdfs/edits
dfs.namenode.edits.noeditlogchannelflush false
dfs.namenode.enable.retrycache true
dfs.namenode.fs-limits.max-xattr-size 16384
dfs.namenode.fs-limits.max-xattrs-per-inode 32
dfs.namenode.fslock.fair true
dfs.namenode.full.block.report.lease.length.ms 300000
dfs.namenode.handler.count 50
dfs.namenode.hosts.provider.classname org.apache.hadoop.hdfs.server.blockmanagement.HostFileManager
dfs.namenode.http-address 50070
dfs.namenode.http-bind-host 0.0.0.0
dfs.namenode.https-bind-host 0.0.0.0
dfs.namenode.inotify.max.events.per.rpc 1000
dfs.namenode.invalidate.work.pct.per.iteration 0.32f
dfs.namenode.kerberos.internal.spnego.principal ${dfs.web.authentication.kerberos.principal}
dfs.namenode.kerberos.principal
dfs.namenode.kerberos.principal.pattern *
dfs.namenode.keytab.file
dfs.namenode.lease-recheck-interval-ms 2000
dfs.namenode.legacy-oiv-image.dir
dfs.namenode.lifeline.handler.count
dfs.namenode.lifeline.handler.ratio 0.10
dfs.namenode.list.cache.directives.num.responses 100
dfs.namenode.list.cache.pools.num.responses 100
dfs.namenode.list.encryption.zones.num.responses 100
dfs.namenode.list.openfiles.num.responses 1000
dfs.namenode.lock.detailed-metrics.enabled false
dfs.namenode.max-lock-hold-to-release-lease-ms 25
dfs.namenode.max.extra.edits.segments.retained 10000
dfs.namenode.max.full.block.report.leases 6
dfs.namenode.max.objects 0
dfs.namenode.metrics.logger.period.seconds 600
dfs.namenode.name.dir file:///mnt/disk1/hdfs/name
dfs.namenode.num.checkpoints.retained 2
dfs.namenode.num.extra.edits.retained 1000000
dfs.namenode.path.based.cache.block.map.allocation.percent 0.25
dfs.namenode.path.based.cache.refresh.interval.ms 30000
dfs.namenode.path.based.cache.retry.interval.ms 30000
dfs.namenode.plugins
dfs.namenode.quota.init-threads 4
dfs.namenode.read-lock-reporting-threshold-ms 5000
dfs.namenode.reject-unresolved-dn-topology-mapping false
dfs.namenode.replication.interval 3
dfs.namenode.replication.max-streams 100
dfs.namenode.replication.max-streams-hard-limit 100
dfs.namenode.replication.min 1
dfs.namenode.replication.work.multiplier.per.iteration 100
dfs.namenode.resource.check.interval 5000
dfs.namenode.resource.checked.volumes dfs.datanode.keytab.file
dfs.namenode.resource.checked.volumes.minimum 1
dfs.namenode.resource.du.reserved 1073741824
dfs.namenode.retrycache.expirytime.millis 600000
dfs.namenode.retrycache.heap.percent 0.03f
dfs.namenode.rpc-bind-host 0.0.0.0
dfs.namenode.safemode.extension 30000
dfs.namenode.safemode.min.datanodes 0
dfs.namenode.safemode.replication.min
dfs.namenode.safemode.threshold-pct 0.999f
dfs.namenode.service.handler.count 30
dfs.namenode.servicerpc-bind-host 0.0.0.0
dfs.namenode.stale.datanode.interval 30000
dfs.namenode.startup.delay.block.deletion.sec 0
dfs.namenode.support.allow.format true
dfs.namenode.top.enabled true
dfs.namenode.top.num.users 10
dfs.namenode.top.window.num.buckets 10
dfs.namenode.top.windows.minutes 1,5,25
dfs.namenode.upgrade.domain.factor ${dfs.replication}
dfs.namenode.write-lock-reporting-threshold-ms 5000
dfs.namenode.write.stale.datanode.ratio 0.5f
dfs.namenode.xattrs.enabled true

dfs.nameservice.id
dfs.nameservices

dfs.permissions.enabled false
dfs.permissions.superusergroup hadoop

dfs.reformat.disabled false

dfs.replication 2
dfs.replication.max 512

dfs.secondary.namenode.kerberos.internal.spnego.principal ${dfs.web.authentication.kerberos.principal}

dfs.short.circuit.shared.memory.watcher.interrupt.check.ms 60000

dfs.storage.policy.enabled true

dfs.stream-buffer-size 4096

dfs.support.append true

dfs.trustedchannel.resolver.class

dfs.user.home.dir.prefix /user

dfs.web.authentication.kerberos.keytab
dfs.web.authentication.kerberos.principal

dfs.webhdfs.enabled false
dfs.webhdfs.rest-csrf.browser-useragents-regex ^Mozilla.*,^Opera.*
dfs.webhdfs.rest-csrf.custom-header X-XSRF-HEADER
dfs.webhdfs.rest-csrf.enabled false
dfs.webhdfs.rest-csrf.methods-to-ignore GET,OPTIONS,HEAD,TRACE
dfs.webhdfs.socket.connect-timeout 60s
dfs.webhdfs.socket.read-timeout 60s
dfs.webhdfs.ugi.expire.after.access 600000
dfs.webhdfs.use.ipc.callq true
dfs.webhdfs.user.provider.user.pattern ^[A-Za-z_][A-Za-z0-9._-]*[$]?$

dfs.xframe.enabled true
dfs.xframe.value SAMEORIGIN

fs.oss.buffer.dirs {% set comma = joiner(',') %}{% for idx in range(diskCnt) -%}{% if idx+1 not in faulty -%}{{ comma() }}file:///mnt/disk{{ idx + 1 }}/data{% endif %}{% endfor %}

hadoop.fuse.connection.timeout 300
hadoop.fuse.timer.period 5

hadoop.hdfs.configuration.version 1

hadoop.user.group.metrics.percentiles.intervals

httpfs.buffer.size 4096

mapreduce.job.acl-view-job *

nfs.allow.insecure.ports true
nfs.dump.dir /tmp/.hdfs-nfs
nfs.kerberos.principal
nfs.keytab.file
nfs.mountd.port 4242
nfs.rtmax 1048576
nfs.server.port 2049
nfs.wtmax 1048576
```

```core-site.xml
file.blocksize 67108864
file.replication 1

fs.defaultFS hdfs://emr-header-1.cluster-245192:9000
fs.df.interval 60000
fs.du.interval 600000
fs.permissions.umask-mode 026
fs.trash.checkpoint.interval 30
fs.trash.interval 1440

ha.failover-controller.new-active.rpc-timeout.ms 60000
ha.health-monitor.check-interval.ms 1000
ha.zookeeper.parent-znode /hadoop-ha
ha.zookeeper.session-timeout.ms 60000

hadoop.caller.context.enabled false
hadoop.home /usr/lib/hadoop
hadoop.http.authentication.simple.anonymous.allowed false

hadoop.proxyuser.flowagent.groups *
hadoop.proxyuser.flowagent.hosts *
hadoop.proxyuser.hadoop.groups *
hadoop.proxyuser.hadoop.hosts *
hadoop.proxyuser.hbase.groups *
hadoop.proxyuser.hbase.hosts *
hadoop.proxyuser.hdfs.groups *
hadoop.proxyuser.hdfs.hosts *
hadoop.proxyuser.hue.groups *
hadoop.proxyuser.hue.hosts *
hadoop.proxyuser.knox.groups *
hadoop.proxyuser.knox.hosts *
hadoop.proxyuser.livy.groups *
hadoop.proxyuser.livy.hosts *
hadoop.proxyuser.oozie.groups *
hadoop.proxyuser.oozie.hosts *
hadoop.proxyuser.presto.groups *
hadoop.proxyuser.presto.hosts *

hadoop.registry.zk.connection.timeout.ms 15000
hadoop.registry.zk.quorum localhost:2181
hadoop.registry.zk.session.timeout.ms 60000

hadoop.security.auth_to_local RULE:[1:$1] RULE:[2:$1] DEFAULT
hadoop.security.authentication.use.has false

hadoop.tmp.dir /mnt/disk1/hadoop/tmp
hadoop.util.hash.type murmur

io.bytes.per.checksum 512

io.compression.codec.lzo.class com.hadoop.compression.lzo.LzoCodec

io.compression.codecs com.hadoop.compression.lzo.LzoCodec,com.hadoop.compression.lzo.LzopCodec,org.apache.hadoop.io.compress.DefaultCodec,org.apache.hadoop.io.compress.GzipCodec,org.apache.hadoop.io.compress.BZip2Codec,org.apache.hadoop.io.compress.DeflateCodec,org.apache.hadoop.io.compress.SnappyCodec,org.apache.hadoop.io.compress.Lz4Codec

io.file.buffer.size 4096

io.mapfile.bloom.size 1048576
io.seqfile.compress.blocksize 1000000
io.seqfile.local.dir ${hadoop.tmp.dir}/io/local

io.serializations org.apache.hadoop.io.serializer.WritableSerialization,org.apache.hadoop.io.serializer.avro.AvroSpecificSerialization,org.apache.hadoop.io.serializer.avro.AvroReflectSerialization

ipc.client.connect.max.retries 10
ipc.client.connect.max.retries.on.timeouts 45
ipc.client.connect.retry.interval 1000
ipc.client.connect.timeout 20000
ipc.client.connection.maxidletime 10000
ipc.client.idlethreshold 4000
ipc.client.kill.max 10
```


### HDFS CLI

```bash
hadoop namenode --format
hadoop-daemon.sh start namenode
hadoop-daemon.sh start datanode
hadoop-daemon.sh stop namenode
hadoop-daemon.sh stop datanode

hadoop fs -ls /
hadoop jar ./share/hadoop/mapreduce/hadoop-mapreduce-examples-2.10.1.jar wordcount input out

hdfs dfs -ls /
hdfs fsck /

mr-jobhistory-daemon.sh start historyserver
```

```
Usage: hadoop [--config confdir] [COMMAND | CLASSNAME]
  CLASSNAME            run the class named CLASSNAME
 or
  where COMMAND is one of:
  fs                   run a generic filesystem user client
  version              print the version
  jar <jar>            run a jar file
                       note: please use "yarn jar" to launch
                             YARN applications, not this command.
  checknative [-a|-h]  check native hadoop and compression libraries availability
  distcp <srcurl> <desturl> copy file or directories recursively
  archive -archiveName NAME -p <parent path> <src>* <dest> create a hadoop archive
  classpath            prints the class path needed to get the
                       Hadoop jar and the required libraries
  credential           interact with credential providers
  daemonlog            get/set the log level for each daemon
  trace                view and modify Hadoop tracing settings

Most commands print help when invoked w/o parameters.


Usage: hadoop fs [generic options]
        [-appendToFile <localsrc> ... <dst>]
        [-cat [-ignoreCrc] <src> ...]
        [-checksum <src> ...]
        [-chgrp [-R] GROUP PATH...]
        [-chmod [-R] <MODE[,MODE]... | OCTALMODE> PATH...]
        [-chown [-R] [OWNER][:[GROUP]] PATH...]
        [-copyFromLocal [-f] [-p] [-l] [-d] <localsrc> ... <dst>]
        [-copyToLocal [-f] [-p] [-ignoreCrc] [-crc] <src> ... <localdst>]
        [-count [-q] [-h] [-v] [-t [<storage type>]] [-u] [-x] <path> ...]
        [-cp [-f] [-p | -p[topax]] [-d] <src> ... <dst>]
        [-createSnapshot <snapshotDir> [<snapshotName>]]
        [-deleteSnapshot <snapshotDir> <snapshotName>]
        [-df [-h] [<path> ...]]
        [-du [-s] [-h] [-x] <path> ...]
        [-expunge]
        [-find <path> ... <expression> ...]
        [-get [-f] [-p] [-ignoreCrc] [-crc] <src> ... <localdst>]
        [-getfacl [-R] <path>]
        [-getfattr [-R] {-n name | -d} [-e en] <path>]
        [-getmerge [-nl] [-skip-empty-file] <src> <localdst>]
        [-help [cmd ...]]
        [-ls [-C] [-d] [-h] [-q] [-R] [-t] [-S] [-r] [-u] [-e] [<path> ...]]
        [-ls2 [-C] [-d] [-h] [-q] [-R] [-t] [-S] [-r] [-u] [-e] [<path> ...]]
        [-mkdir [-p] <path> ...]
        [-moveFromLocal <localsrc> ... <dst>]
        [-moveToLocal <src> <localdst>]
        [-mv <src> ... <dst>]
        [-put [-f] [-p] [-l] [-d] <localsrc> ... <dst>]
        [-renameSnapshot <snapshotDir> <oldName> <newName>]
        [-rm [-f] [-r|-R] [-skipTrash] [-safely] <src> ...]
        [-rm2 [-f] [-r|-R] [-skipTrash] [-safely] <src> ...]
        [-rmdir [--ignore-fail-on-non-empty] <dir> ...]
        [-setfacl [-R] [{-b|-k} {-m|-x <acl_spec>} <path>]|[--set <acl_spec> <path>]]
        [-setfattr {-n name [-v value] | -x name} <path>]
        [-setrep [-R] [-w] <rep> <path> ...]
        [-stat [format] <path> ...]
        [-tail [-f] <file>]
        [-test -[defsz] <path>]
        [-text [-ignoreCrc] <src> ...]
        [-touchz <path> ...]
        [-truncate [-w] <length> <path> ...]
        [-usage [cmd ...]]

Generic options supported are
-conf <configuration file>     specify an application configuration file
-D <property=value>            use value for given property
-fs <file:///|hdfs://namenode:port> specify default filesystem URL to use, overrides 'fs.defaultFS' property from configurations.
-jt <local|resourcemanager:port>    specify a ResourceManager
-files <comma separated list of files>    specify comma separated files to be copied to the map reduce cluster
-libjars <comma separated list of jars>    specify comma separated jar files to include in the classpath.
-archives <comma separated list of archives>    specify comma separated archives to be unarchived on the compute machines.

The general command line syntax is
command [genericOptions] [commandOptions]


Usage: hdfs [--config confdir] [--loglevel loglevel] COMMAND
       where COMMAND is one of:
  dfs                  run a filesystem command on the file systems supported in Hadoop.
  classpath            prints the classpath
  namenode -format     format the DFS filesystem
  secondarynamenode    run the DFS secondary namenode
  namenode             run the DFS namenode
  journalnode          run the DFS journalnode
  zkfc                 run the ZK Failover Controller daemon
  datanode             run a DFS datanode
  debug                run a Debug Admin to execute HDFS debug commands
  dfsadmin             run a DFS admin client
  haadmin              run a DFS HA admin client
  fsck                 run a DFS filesystem checking utility
  balancer             run a cluster balancing utility
  jmxget               get JMX exported values from NameNode or DataNode.
  mover                run a utility to move block replicas across
                       storage types
  oiv                  apply the offline fsimage viewer to an fsimage
  oiv_legacy           apply the offline fsimage viewer to an legacy fsimage
  oev                  apply the offline edits viewer to an edits file
  fetchdt              fetch a delegation token from the NameNode
  getconf              get config values from configuration
  groups               get the groups which users belong to
  snapshotDiff         diff two snapshots of a directory or diff the
                       current directory contents with a snapshot
  lsSnapshottableDir   list all snapshottable dirs owned by the current user
                                                Use -help to see options
  portmap              run a portmap service
  nfs3                 run an NFS version 3 gateway
  cacheadmin           configure the HDFS cache
  crypto               configure HDFS encryption zones
  storagepolicies      list/get/set block storage policies
  version              print the version

Most commands print help when invoked w/o parameters.
```

### HDFS 高阶使用

##### HDFS 权限认证

Hadoop提供了以下两种用于决定用户身份的操作模式：

- 简单模式（Simple）：用户的身份由与HDFS建立链接的客户端操作系统决定。在类Unix系统中，等同于whoami命令。
- Kerberos集群模式：客户端的身份由他自己的Kerberos证书决定。

HDFS开启了权限控制后，用户访问HDFS需要有合法的权限才能正常操作HDFS，如读取数据和创建文件夹等。

对于Kerberos安全集群，已经默认设置了HDFS的权限（umask 设置为 027），无需配置和重启服务。

对于非Kerberos安全集群需要添加配置并重启服务。

**添加配置**

HDFS权限相关的配置如下：

- dfs.permissions.enabled 默认值为false。
    + 即使该值为false， chmod/chgrp/chown/setfacl操作还是会进行权限检查。
    + 开启权限检查，修改为true。
- dfs.datanode.data.dir.perm 默认值为755。datanode使用的本地文件夹路径的权限。
- fs.permissions.umask-mode 权限掩码，在新建文件/文件夹的时候的默认权限设置。
    + 简单模式：默认值为022，对应新建文件权限为644（0666&^022=644），新建文件夹权限为755（0777&^022=755）。
    + 值为026，对应新建文件权限为640（0666&^026=640），新建文件夹权限为751（0777&^026=751）。
    + 值为037，对应新建文件权限为630（0666&^037=630），新建文件夹权限为740（0777&^037=740）。
    + Kerberos集群模式：默认值为027，对应新建文件权限为640，新建文件夹权限为750。
    + 新建文件：0666 & ^umask。
    + 新建文件夹：0777 & ^umask。
    + 默认umask值为022，即新建文件权限为644（666&^022=644），新建文件夹权限为755（777&^022=755）。
    + EMR 的 Kerberos 安全集群默认设置为027，对应新建文件权限为640，新建文件夹权限为750。
- dfs.namenode.acls.enabled 默认值为false。
    + 打开 ACL 控制，打开后除了可以对owner/group进行权限控制外，还可以对其它用户进行设置。
    + 设置 ACL 相关命令：
    ```bash
    hadoop fs -getfacl [-R] <path>
    hadoop fs -setfacl [-R] [-b |-k -m |-x <acl_spec> <path>] |[--set <acl_spec>   <path>]

    # 如：
    su test
    # test用户创建文件夹
    hadoop fs -mkdir /tmp/test
    # 查看创建的文件夹的权限
    hadoop fs -ls /tmp
    drwxr-x---   - test   hadoop          0 2017-11-26 21:18 /tmp/test
    # 设置acl，授权给foo用户rwx
    hadoop fs -setfacl -m user:foo:rwx /tmp/test
    # 查看文件权限(+号表示设置了ACL)
    hadoop fs -ls  /tmp/
    drwxrwx---+  - test   hadoop          0 2017-11-26 21:18 /tmp/test
    # 查看acl
    hadoop fs -getfacl  /tmp/test
    # file: /tmp/test
    # owner: test
    # group: hadoop
    user::rwx
    user:foo:rwx
    group::r-x
    mask::rwx
    other::---
    ```
- dfs.permissions.superusergroup 默认值为hadoop。超级用户组，属于该组的用户都具有超级用户的权限。

**其他**

- umask值可以根据需求自行修改。
- HDFS是一个基础的服务，Hive/HBase等都是基于HDFS，所以在配置其它上层服务时，需要提前配置好HDFS的权限控制。
- 在HDFS开启权限后，需要设置好服务的日志路径（如Spark 的 /spark-history、YARN 的 /tmp/$user/ 等）。
- sticky bit
    针对文件夹可设置sticky bit，可以防止除了superuser/file owner/dir owner之外的其它用户删除该文件夹中的文件/文件夹（即使其它用户对该文件夹有rwx 权限）。
    ```bash
    # 即在第一位添加数字1
    hadoop fs -chmod 1777 /tmp
    hadoop fs -chmod 1777 /spark-history
    hadoop fs -chmod 1777 /user/hive/warehouse
    ```

##### 配额（Quotas）

HDFS允许管理员可以对所使用的名称数量和单个目录使用的空间量设置配额，名称配额与空间配额分别独立运作，但是两种配额的管理和实现方式非常相似。

**名称配额（Name Quotas）**

名称配额是对当前目录树中的文件和目录名称数量的硬性限制。创建文件或目录时，如果超出配额，则文件和目录创建失败。配额是一个目录的属性，不仅在创建时会检查配额，在重命名时也会检查配额。如果一个目录已经设置了配额，则该目录执行重命名操作后，该目录的配额亦然生效。

即使目录违反了新的配额，对目录设置新的配额仍然可以成功。新建的目录初始状态是没有设置配额的。最大配额值为Long.Max_Value。例如，设置配额为1会使得一个目录为空，因为目录本身占用一个额度。

**空间配额（Space Quotas）**

空间配额是对当前目录树中的文件所使用的字节数量的硬性限制。如果额度不允许写入一个完整的块，则块分配会失败。一个块的所有副本都会计入额度中。例如，一个文件大小为N，有三个副本，则占用的额度为3N。配额是一个目录的属性，不仅在创建时会检查配额，在重命名时也会检查配额。对于重命名的目录，配额不变。如果重命名操作与设置的配置冲突，则重命名操作失败。

即使目录违反了新的配额，对目录设置新的配额仍然可以成功。新建的目录初始状态是没有设置配额的。最大配额值为Long.Max_Value。当配额为0时仍然允许创建文件，但是不能向该文件中写内容。目录不占用磁盘空间，因此不计入空间配额中。

管理员可以通过以下命令来管理额度：

```bash
# 设置目录的名称配额为N。
hdfs dfsadmin -setQuota <N> <directory>...<directory>
# 当N是非正数、目录不存在或目录马上超过新配额时设置失败。

# 删除目录的名称配额。
hdfs dfsadmin -clrQuota <directory>...<directory>
# 设置目录的空间配额为N字节。
hdfs dfsadmin -setSpaceQuota <N> <directory>...<directory>
# 删除目录的空间配额。
hdfs dfsadmin -clrSpaceQuota <directory>...<directory>

# 报告配额值和当前使用的名称总数以及总的字节数。
hadoop fs -count -q [-h] [-v] [-t [comma-separated list of storagetypes]] <directory>...<directory>
```

##### 快照（Snapshots）

HDFS快照（Snapshots）是文件系统在某一时刻的只读副本。快照可以在文件系统的一个分支或者整个文件系统上生成。快照常用来备份数据，防止错误性的操作。

HDFS快照的特征如下：

- 快照的创建是瞬时的：时间复杂度为O(1)，不包括INode查找时间。
- 仅当修改快照相关的数据时才会使用额外的内存：内存使用复杂度为O(M)，其中M是修改的文件或目录的数量。
- DataNode中的数据块不会被复制：快照文件仅记录块列表和文件大小，不涉及数据复制。
- 快照不会对常规的HDFS操作造成不利影响：修改操作按照时间倒序记录，以便可以直接访问当前最新的数据。快照数据是通过当前数据减去修改的部分计算得到的。

**快照目录**

当目录被设置为可被快照时才会生成快照。一个快照目录可以同时容纳65536个快照。快照目录的数量是没有限制的。管理员可以将任何目录设置为快照。如果一个目录中有快照，则在删除所有快照之前，既不能删除也不能重命名该目录。

不允许及联的快照目录。如果一个目录的父目录或者子目录是快照目录，则不能将该目录设置为快照。

**快照路径**

对于一个快照目录，访问时需要添加/.snapshot后缀。例如，如果/foo是一个快照目录，/foo/bar是/foo下的文件或者目录，/foo有一个快照s0，则/foo/.snapshot/s0/bar是/foo/bar的快照副本。常用的API和CLI可以通过在.snapshot目录下完成，操作快照的命令示例如下：

```bash
# 列出快照目录下的所有快照
hdfs dfs -ls /foo/.snapshot
# 列出快照s0中的所有文件
hdfs dfs -ls /foo/.snapshot/s0
# 从快照s0中复制文件
hdfs dfs -cp -ptopax /foo/.snapshot/s0/bar /tmp
# 说明 该示例使用-ptopax参数来保留时间戳、所有权、权限、ACL和XAttrs。
```

**快照操作**

管理员操作需要超级用户权限。

```bash
# 允许创建目录的快照。如果操作成功完成，该目录将变为可快照目录。
hdfs dfsadmin -allowSnapshot <path>
# 禁止创建目录的快照。在禁止快照之前，必须删除该目录的所有快照。
hdfs dfsadmin -disallowSnapshot <path>
```

HDFS超级用户可以执行以下所有操作。
```bash
# 创建快照目录的快照。该操作需要快照目录的所有者权限。
hdfs dfs -createSnapshot <path> [snapshotName]
# 说明 本文代码示例中的[snapshotName]表示快照名称，是一个可选参数。当其省略时，默认的名称是使用时间戳syyyyMMdd-HHmmss.SSSS的格式表示，例如，s20130412-151029.033。

# 从快照目录中删除快照。该操作需要快照目录的所有者权限。
hdfs dfs -deleteSnapshot <path> <snapshotName>

# 重命名一个快照。该操作需要快照目录的所有者权限。
hdfs dfs -renameSnapshot <path> <oldName> <newName>
# 说明 本文代码示例中的<oldName>表示原快照名称，<newName>表示新快照名称。

# 获取当前用户拥有快照权限的所有快照目录。
hdfs lsSnapshottableDir
# 获取两个快照之间的区别。该操作需要快照内所有文件或目录的读权限。
hdfs snapshotDiff <path> <fromSnapshot> <toSnapshot>
# 说明 本文代码示例中的<fromSnapshot>表示原快照，<toSnapshot>表示待对比的快照。
```

##### Balancer

Balancer工具可以用来分析块的分布情况，并且可以重新分配DataNode中的数据。本文通过为您介绍如何使用Balancer工具以及Balancer的主要调优参数。

```bash
hdfs balancer
[-threshold <threshold>]
[-policy <policy>]
[-exclude [-f <hosts-file> | <comma-separated list of hosts>]]
[-include [-f <hosts-file> | <comma-separated list of hosts>]]
[-source [-f <hosts-file> | <comma-separated list of hosts>]]
[-blockpools <comma-separated list of blockpool ids>]
[-idleiterations <idleiterations>]
```

Balancer主要参数如下表。

| 参数          | 说明                                                         |
| ------------- | ------------------------------------------------------------ |
| threshold     | 磁盘容量的百分数。<br/>默认值为10%，表示上下浮动10%。<br/>当集群总使用率较高时，需要调小Threshold，避免阈值过高。<br/>当集群新增节点较多时，您可以适当增加Threshold，使数据从高使用率节点移向低使用率节点。 |
| policy        | 平衡策略。支持以下策略：<br/>datanode（默认）：当每一个DataNode是平衡的时候，集群就是平衡的。<br/>blockpool：当每一个DataNode中的blockpool是平衡的，集群就是平衡的。 |
| exclude       | Balancer排除特定的DataNode。                                 |
| include       | Balancer仅对特定的DataNode进行平衡操作。                     |
| source        | 仅选择特定的DataNode作为源节点。                             |
| blockpools    | Balancer仅在指定的blockpools中运行。                         |
| idleterations | 最多允许的空闲循环次数，否则退出。覆盖默认的5次。            |

```bash
# 切换到hdfs用户并执行Balancer参数。
/usr/lib/hadoop-current/sbin/start-balancer.sh -threshold 10
# 执行以下命令，进入hadoop-hdfs目录。
cd /var/log/hadoop-hdfs
# 执行ll命令，查看Balancer日志。
ll

# 执行以下命令，查看Balancer运行情况。
tailf /var/log/hadoop-hdfs/hadoop-hdfs-balancer-emr-header-xx.cluster-xxx.log

# 当提示信息包含Successfully字样时，表示执行成功。
# 说明 代码中的hadoop-hdfs-balancer-emr-header-xx.cluster-xxx.log为步骤4获取到的日志名称。
```

**Balancer调优参数**

执行Balancer会占用一定的系统资源，建议在业务空闲期执行。默认情况下，不需要对Balancer参数进行额外调整。当需要时，可以对客户端和DataNode两类配置进行调整。

1. 客户端配置，入口在HDFS服务的hdfs-site，添加以下参数，配置完成后重新执行Balancer即可生效。

| 参数                           | 描述                                                         |
| ------------------------------ | ------------------------------------------------------------ |
| dfs.balancer.dispatcherThreads | Balancer在移动Block之前，每次迭代时查询出一个Block列表，分发给Mover线程使用。<br/>_说明_ dispatcherThreads是该分发线程的个数，默认为200。 |
| dfs.balancer.rpc.per.sec       | 默认值为20，即每秒发送的RPC数量为20。<br>因为分发线程调用大量getBlocks的RPC查询，所以为了避免NameNode由于分发线程压力过大，需要控制分发线程RPC的发送速度。<br>例如，您可以在负载高的集群调整参数值，减小10或者5，对整体移动进度不会产生特别大的影响。 |
| dfs.balancer.getBlocks.size    | Balancer会在移动Block前，每次迭代时查询出一个Block列表，给Mover线程使用，默认Block列表中Block的大小为2 GB。因为getBlocks过程会对RPC进行加锁，所以您可以根据NameNode压力进行调整。 |
| dfs.balancer.moverThreads      | 默认值为1000。<br>Balancer处理移动Block的线程数，每个Block移动时会使用一个线程。 |

2. DataNode配置，入口在HDFS服务的hdfs-site，添加以下参数，配置完成后重启DataNode，再次执行Balancer即可生效。

| 参数                                      | 描述                                                         |
| ----------------------------------------- | ------------------------------------------------------------ |
| dfs.datanode.balance.bandwidthPerSec      | 指定DataNode用于Balancer的带宽，通常推荐设置为100 MB/s，您也可以通过dfsadmin -setBalancerBandwidth 参数进行适当调整，无需重启DataNode。<br>例如，在负载低时，增加Balancer的带宽。在负载高时，减少Balancer的带宽。 |
| dfs.datanode.balance.max.concurrent.moves | 默认值为5。<br>指定DataNode节点并发移动的最大个数。通常考虑和磁盘数匹配，推荐在DataNode端设置为4 * 磁盘数作为上限，可以使用Balancer的值进行调节。<br>例如：一个DataNode有28块盘，在Balancer端设置为28，DataNode端设置为28 * 4。具体使用时根据集群负载适当调整。在负载较低时，增加concurrent数；在负载较高时，减少concurrent数。 |

##### HaAdmin

集群启动高可用特性后，可以使用HaAdmin工具来管理HDFS集群。

在Hadoop 2.0.0之前，NameNode在HDFS集群中都是以单节点的形式存在。每个集群只有一个NameNode，如果此NameNode不可用，整个集群都会变成不可用的状态，直到NameNode重新与集群建立连接。

单一NameNode主要从两个方面影响HDFS集群的可用性：

- 当发生一个计划之外的事件，例如机器宕机，集群将会处于不可用状态，直到手动重启NameNode。
- 有计划的维护事件，例如软件或硬件升级，也会使得集群存在一个不可用的窗口期。

HDFS高可用特性解决了上述问题，通过提供了两个冗余的NameNode以主动或被动的方式用于热备，使得集群既可以从机器宕机中快速恢复，也可以优雅的在有计划的维护时快速恢复。

```bash
# 查看所有NameNode的状态。
hdfs haadmin -getAllServiceState
# 检查指定NameNode的健康情况。
hdfs haadmin -checkHealth <serviceId>
# 在两个NameNode中初始化一个故障转移操作。
hdfs haadmin -failover [--forcefence] [--forceactive] <serviceId>
# 获取serviceId的状态，判断指定的NameNode是Active或者Standby。
hdfs haadmin -getServiceStat <serviceId>
# 将指定的NameNode状态转换成Active。
hdfs haadmin -transitionToActive <serviceId> [--forceactive]
# 将指定的NameNode状态转换成Standby。
hdfs haadmin -transitionToStandby <serviceId>
```


### HDFS 使用优化

##### JVM 内存调优

调整NameNode JVM和DataNode JVM内存大小，以便优化HDFS的稳定性。

在HDFS中，每个文件对象都需要在NameNode中记录元数据信息，并占用一定的内存空间。默认的JVM配置可以满足部分普通的HDFS使用。部分Workload会向HDFS中写入更多地文件，或者随着一段时间的积累HDFS保存的文件数不断增加，当增加的文件数超过默认的内存空间配置时，则默认的内存空间无法存储相应的信息，需要修改内存大小的设置。

在HDFS中，每个文件Block对象都需要在DataNode中记录Block元数据信息，并占用一定的内存空间。默认的JVM配置可以满足部分简单的、压力不大的作业需求。而部分作业会向HDFS写入更多的文件，或者随着一段时间的积累HDFS保存的文件数不断增加。当文件数增加，DataNode上的Block数也会增加，而默认的内存空间无法存储相应的信息时，则需要修改内存大小的设置。

**调整NameNode JVM内存大小**

修改方式如下：

- HA集群 HDFS服务的配置参数hadoop_namenode_heapsize，参数值根据实际需求进行调整。
- 非HA集群 HDFS服务的配置参数hadoop_namenode_heapsize和hadoop_secondary_namenode_heapsize，参数值根据实际需求进行调整。

*说明* 配置完成后，需要重启相应的NameNode或SecondaryNamenode服务，使得配置生效。

建议值=( 文件数（以百万为单位）+块数（以百万为单位）)×512 MB

当大多数文件不超过1个Block时，建议值如下。
文件数量    建议值（MB）
10,000,000  10240
20,000,000  20480
50,000,000  51200
100,000,000 102400

**调整DataNode JVM内存大小**

HDFS服务的配置参数hadoop_datanode_heapsize，参数值根据实际需求进行调整。

建议值=单个DataNode副本数Replicas（百万单位）×2048 MB

集群中每个DataNode实例平均保存的副本数Replicas=文件块数Blocks×3÷DataNode节点数

*说明* 配置完成后，需重启DataNode服务，使配置生效。

例如，大数据机型为3副本，Core节点数量为6，如果您有1000万个文件且都是中小文件，Blocks数量也为1000万，则单个DataNode副本数Replicas为 500万（1000万×3÷6）， 内存大小建议值为10240 MB（5×2048 MB）。

当您的大多数文件不超过1个Block时，建议值如下。

单个DataNode实例平均Replicas数量    建议值（MB）
1,000,000   2048
2,000,000   4096
5,000,000   10240

说明 该建议值已为JVM内核预留了部分空间，以及为作业高峰压力预留了部分空间，因此通常情况下可以直接换算使用。

##### 其他优化

- 配置回收站机制
- 控制小文件个数
- 配置HDFS单目录文件数量
- 在网络不稳定的情况下，降低客户端运行异常概率
- 配置可容忍的磁盘坏卷
- 防止目录被误删
- 使用Balancer进行容量均衡

**配置回收站机制**

在HDFS中，删除的文件将被移动到回收站（trash）中，以便在误操作的情况下恢复被删除的数据。
您可以设置文件保留在回收站中的时间阈值，一旦文件保存时间超过此阈值，系统将自动从回收站中永久地删除该文件。您也可以手动删除回收站里面的文件。

fs.trash.interval   1440 以分钟为单位的垃圾回收时间，垃圾站中数据超过此时间会被删除。如果设置为0，表示禁用回收站机制。

说明 建议您使用默认值，以便于在误操作的情况下恢复被删除的文件。不建议您将此参数设置过大，避免回收站中过多的文件占用集群的可用空间。

**控制小文件个数**

HDFS NameNode将所有文件元数据加载在内存中，在集群磁盘容量一定的情况下，如果小文件个数过多，则会造成NameNode的内存容量瓶颈。

建议：尽量控制小文件的个数。对于存量的小文件，建议合并为大文件。

**配置HDFS单目录文件数量**

当集群运行时，不同组件（例如Spark和YARN）或客户端可能会向同一个HDFS目录不断写入文件。但HDFS系统支持的单目录文件数目是有上限的，因此需要您提前做好规划，防止单个目录下的文件数目超过阈值，导致任务出错。

建议：可以在HDFS服务的配置hdfs-site，新增参数dfs.namenode.fs-limits.max-directory-items，以设置单个目录下可以存储的文件数目，最后保存配置。添加参数详情，请参见添加组件参数。

说明 您需要将数据做好存储规划，可以按时间、业务类型等分类，不要单个目录下直属的文件过多，建议单个目录下约100万条。

**在网络不稳定的情况下，降低客户端运行异常概率**

在网络不稳定的情况下，调整ipc.client.connect.max.retries.on.timeouts和ipc.client.connect.timeout参数，适当提高客户端的重试次数和超时时间，可以降低客户端运行异常的概率。

建议：您可以在HDFS服务的配置，搜索参数ipc.client.connect.max.retries.on.timeouts，您可以增大该参数值，增加连接的最大重试次数。搜索参数ipc.client.connect.timeout，您可以增大该参数值，增加建立连接的超时时间。

ipc.client.connect.max.retries.on.timeouts  客户端同服务端建立Socket连接时，客户端的最大重试次数。  45
ipc.client.connect.timeout  客户端与服务端建立Socket连接的超时时间。单位：毫秒。 20000

**配置可容忍的磁盘坏卷**

如果为DataNode配置多个数据存放卷，默认情况下其中一个卷损坏，则DataNode将不再提供服务。

建议：您可以在EMR控制台HDFS服务的配置，搜索参数dfs.datanode.failed.volumes.tolerated，您可以修改此参数，指定失败的个数，小于该个数，DataNode可以继续提供服务。

dfs.datanode.failed.volumes.tolerated   DataNode停止提供服务前允许失败的卷数。默认情况下，必须至少有一个有效卷。    0

说明 当DataNode存在坏盘，而又没有其他足够的节点可以提供服务时，可以临时将该值调大，先将DataNode启动起来。

**防止目录被误删**

HDFS允许将一些目录配置为受保护的，避免这些目录被误删除，但是依然可以将目录挪到回收站。

建议：您可以在HDFS服务的配置core-site，新增参数fs.protected.directories，参数值为您待保护的目录，多个目录时使用逗号（,）分隔，并保存配置。

**使用Balancer进行容量均衡**

HDFS集群可能出现DataNode节点间磁盘利用率不平衡的情况，例如集群中添加新DataNode的场景。如果HDFS出现数据不平衡的状况，则可能导致个别DataNode压力过大。

建议：您可以使用Balancer操作进行容量均衡。

说明 执行Balancer操作时会占用DataNode的网络带宽资源，请根据业务需求在业务空闲时期执行Balancer任务。

```bash
# 登录Master节点

# 可选：执行以下命令，修改Balancer的最大带宽。
hdfs dfsadmin -setBalancerBandwidth <bandwidth in bytes per second>
# 说明 代码示例中的<bandwidth in bytes per second>为设置的最大带宽，例如，如果需要设置带宽控制为20 MB/s，对应值为20971520，则完整代码示例为hdfs dfsadmin -setBalancerBandwidth 20971520。如果集群负载较高，可以改为209715200（200 MB/s）；如果集群空闲，可以改为1073741824（1 GB/s）。

# 执行以下命令，切换到hdfs用户并执行Balancer参数。
su hdfs
/usr/lib/hadoop-current/sbin/start-balancer.sh -threshold 10
# 执行以下命令，进入hadoop-hdfs目录。
cd /var/log/hadoop-hdfs
# 执行ll命令，查看Balancer日志。
ll

#执行以下命令，查看Balancer运行情况。
tailf /var/log/hadoop-hdfs/hadoop-hdfs-balancer-emr-header-xx.cluster-xxx.log
# 当提示信息包含Successfully字样时，表示执行成功。
# 说明 代码中的hadoop-hdfs-balancer-emr-header-xx.cluster-xxx.log为前面步骤中获取到的日志名称。
```


### FAQ

1. hdfs fsck / 报Target Replicas is 10 but found 4 replica(s).

原因分析

> 集群4个节点，mapred-site.xml 没有设置mapreduce.client.submit.file.replication，该参数默认值为10， 因此客户端提交的Job默认都要求10 replication，但集群总节点数才4个，每个节点副本，总数为4，因此集群会有提示信息。
>
> PS：该信息不影响集群状态

处理办法

> 在mapred-site.xml上增加 mapreduce.client.submit.file.replication设置

```xml
<property>
    <name>mapreduce.client.submit.file.replication</name>
    <value>4</value>
</property>
```

2. 为什么NameNode重启特别慢？

问题现象：NameNode原先正常，重启NameNode过程中非常慢，并且NameNode重启未完成，十几分钟后自动重启了。观察日志时发现正在加载FsImage和EditsLog。

问题原因：因为NameNode启动过程中加载FsImage和EditsLog会消耗较多的内存。

解决方法：建议调大NameNode HeapSize，调整NameNode JVM内存大小。

3. 为什么NameNode无法响应？

问题现象：NameNode节点长时间满负载，所在节点CPU达到100%，NameNode无法响应。

问题原因：因为NameNode的内存容量已经无法承担太多的文件，进程在频繁发生FULL GC。

解决方法：建议调大NameNode HeapSize，调整NameNode JVM内存大小。

4. 为什么会有大量的Editslog文件？

问题现象：NameNode节点数据目录占用磁盘空间大，发现有大量的Editslog文件。

问题原因：查看Secondary NameNode（非HA集群）或Standby NameNode（HA集群）的健康状态，发现Secondary NameNode或Standby NameNode服务不正常，导致了Editslog文件没有及时合并。服务不正常很可能是内存不够导致的。

解决方法：适当调节NameNode的HeapSize，使其正常启动，调整NameNode JVM内存大小。

5. 为什么有大量的Under Replicated Blocks？

问题现象：使用fsck命令查看，发现有大量Under Replicated Blocks。

问题原因：由于Decommission或节点（磁盘）异常下线后，副本数恢复较慢。

解决方法：需要恢复副本数，您可以在HDFS服务的配置搜索下表参数并调大参数值。

| 参数                                                   | 描述                                                         |
| ------------------------------------------------------ | ------------------------------------------------------------ |
| dfs.namenode.replication.work.multiplier.per.iteration | 默认值100。建议调大为200，但不超过500。<br>该参数影响NameNode下发给每个DataNode进行副本复制作业任务的并发度，即任务调度速度。<br>该参数是系数值，实际下发任务数为该系数值乘以集群节点个数。 |
| dfs.namenode.replication.max-streams                   | 建议设置为100。<br>该参数负责调节低优先级的块的复制任务的执行并发度。 |
| dfs.namenode.replication.max-streams-hard-limit        | 默认值100。建议调大为200，但不超过500。<br>该参数负责调节所有优先级的块的复制任务的执行并发度，包含最高优先级的块。 |

6. 如何处理Missing Blocks或Corrupted Blocks问题？

问题现象：使用fsck命令查看，提示Missing Blocks或Corrupted Blocks。

问题原因：可能是DataNode停止了服务，或者是磁盘损坏或异常操作导致数据丢失。

解决方法：如果之前DataNode停止了服务，请将DataNode重新启动下。 如果是磁盘损坏或异常操作导致数据丢失，需要人工恢复，您可以通过hdfs fsck / -files命令扫描损坏的文件，导出文件列表，删除后重新上传。

7. 如何处理EditsLog不连续导致NameNode启动失败的问题？

问题现象：在JournalNode节点断电，数据目录磁盘占满，网络异常时，重启NameNode失败。

问题原因：可能是JournalNode上的EditsLog不连续。

解决方法：某台NameNode EditsLog损坏的情况下，需要手工恢复。

操作方法如下：
- 备份NameNode节点元数据的整个目录/mnt/disk1/hdfs，以防误操作的风险。
- 观察NameNode启动日志，记录加载失败的EditsLog的txid。
- 登录另外一台NameNode节点，找到并复制相同txid的EditsLog文件，覆盖本节点的同名文件。
- 重启NameNode，观察是否成功。
