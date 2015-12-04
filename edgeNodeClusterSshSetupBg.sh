sshUserName=$1
clusterName=$2
privateKeyName=$3
privateKeyPath=$4

clusterSshHostName="$clusterName-ssh.azurehdinsight.net"
echo "Adding cluster host to known hosts if not exist"
knownHostKey=$(ssh-keygen -H -F $clusterSshHostName 2>/dev/null)
if [ -z "$knownHostKey" ]
then
ssh-keyscan -H $sshUserName >> ~/.ssh/known_hosts
fi

sudo apt-get install autossh
autossh -i $privateKeyPath $clusterSshHostName

scp -i $privateKeyPath $privateKeyPath $clusterSshHostName:~/.ssh/$privateKeyName
