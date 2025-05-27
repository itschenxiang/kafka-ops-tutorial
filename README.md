# 运维
## 查看集群 broker 列表
```bash
docker exec -it <kafka_cluster_zk_container_name> /bin/bash zkCli.sh
# example
# docker exec -it local-kafka-zookeeper-1 /bin/bash zkCli.sh

# in zkCli
ls /brokers/ids
```

## [分区副本重分配](https://doc.knowstreaming.com/study-kafka/6-operation#614-%E5%88%86%E5%8C%BA%E5%89%AF%E6%9C%AC%E9%87%8D%E5%88%86%E9%85%8D-kafka-reassign-partitions)

分区副本重分配应用场景：

1. 新增 broker 节点，需要将主题分区“均衡分配”；
2. 下线部分 broker 节点，需要将“下线节点”的主题分区重分配到指定剩余节点；

> Q1：如果某个 broker 因为某些原因永久故障下线，它所拥有的 follower 副本分区数据会重建吗，如果会具体是如何重建的？<br> A1：基于 zk 的 Kafka 不支持“自动重建”，参考链接 https://lxblog.com/qianwen/share?shareId=1a85e0ae-bfc6-47eb-bf3a-64e20b430d8c

### 示例
```bash
kafka_2.13-3.5.1/bin/kafka-reassign-partitions.sh --bootstrap-server localhost:19094 --topics-to-move-json-file move-json-file.json --broker-list "1001,1003,1002,1004" --generate
```

```bash
kafka_2.13-3.5.1/bin/kafka-reassign-partitions.sh --bootstrap-server localhost:19094 --reassignment-json-file reassignment-json-file.json --execute
```

```bash
# 查看主题分区分布详情
kafka_2.13-3.5.1/bin/kafka-topics.sh --describe --topic quickstart-events --bootstrap-server localhost:19094
```
