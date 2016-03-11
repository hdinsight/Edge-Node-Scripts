sudo sed -i "/# WASB metric/a azure-file-system.sink.ganglia.servers=$1:8649" /etc/hadoop/conf/hadoop-metrics2-azure-file-system.properties 
sudo sed -i '/# WASB metric/a *.sink.ganglia.period=60' /etc/hadoop/conf/hadoop-metrics2-azure-file-system.properties 
sudo sed -i '/# WASB metric/a *.sink.ganglia.record.filter.include=azureFileSystem' /etc/hadoop/conf/hadoop-metrics2-azure-file-system.properties 
sudo sed -i '/# WASB metric/a *.sink.ganglia.class=org.apache.hadoop.metrics2.sink.ganglia.GangliaSink31' /etc/hadoop/conf/hadoop-metrics2-azure-file-system.properties 