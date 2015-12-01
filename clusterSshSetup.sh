#!/bin/bash
sshUserName=$1
vmName=$2
clusterStorageAccount=$3
clusterStorageAccountKey=$4
clusterStorageContainer=$5

su $sshUserName

publicKeyName="$vmName-cluster-key.pub"
publicKeyPath="$HOME/.ssh/$publicKeyName"

if [ -f $publicKeyPath ]
then
    echo "ssh key exists at $publicKeyPath"
else
    sudo apt-get -y -qq install python-pip
    sudo pip install azure-storage

    sudo python -c "
from azure.storage.blob import BlobService
blob_service=BlobService('$clusterStorageAccount', '$clusterStorageAccountKey')
blob_service.get_blob_to_path('$clusterStorageContainer', '$publicKeyName','$publicKeyPath', max_connections=5)
"
    cat $publicKeyPath >> ~/.ssh/authorized_keys
fi

