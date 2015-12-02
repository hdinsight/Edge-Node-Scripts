#!/bin/bash
sshUserName=$1
vmName=$2
clusterStorageAccount=$3
clusterStorageAccountKey=$4
clusterStorageContainer=$5

privateKeyName="cluster-key"
eval privateKeyPath=~$sshUserName/.ssh/$privateKeyName

echo "generating ssh key at $privateKeyPath"

if [ -f $privateKeyPath ]
then
	echo "ssh key exists at $privateKeyPath"
else
	su $sshUserName -c "ssh-keygen -t rsa -f $privateKeyPath -N ''" 
fi
publicKeyName="$privateKeyName.pub"
publicKeyPath="$privateKeyPath.pub"

sudo apt-get -y -qq install python-pip
sudo pip install azure-storage

python -c "
from azure.storage.blob import BlobService
blob_service=BlobService('$clusterStorageAccount', '$clusterStorageAccountKey')
blob_service.create_container('$clusterStorageContainer')
blob_service.put_block_blob_from_path('$clusterStorageContainer', '$vmName-$publicKeyName','$publicKeyPath', max_connections=5)
"
