bin/zookeeper-server-start.sh config/zookeeper.properties
bin/kafka-server-start.sh config/server.properties

bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic kafka-demo
bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic offset.storage.topic
bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic config.storage.topic
bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic status.storage.topic

bin/connect-distributed.sh -daemon config/connect-distributed.properties

curl -X POST -H "Content-Type: application/json" -d '{"name":"test-splunk-sink","config":{"connector.class":"com.github.jcustenborder.kafka.connect.splunk.SplunkHttpSinkConnector","splunk.ssl.enabled":"true","splunk.remote.host":"<SPLUNK_HOST>","tasks.max":"5","topics":"test_topic","splunk.remote.port":"8088","splunk.ssl.validate.certs":"false","splunk.auth.token":"<HEC_TOKEN>"}}' localhost:8083/connectors