sudo DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes ganglia-monitor rrdtool gmetad ganglia-webfrontend 
wait 
sudo cp /etc/ganglia-webfrontend/apache.conf /etc/apache2/sites-enabled/ganglia.conf 

sudo sed -i '0,/mcast_join = 239.2.11.71/{s/mcast_join = 239.2.11.71/host = localhost/}'  /etc/ganglia/gmond.conf 
sudo sed -i '0,/mcast_join = 239.2.11.71/{s/mcast_join = 239.2.11.71//}'  /etc/ganglia/gmond.conf 
sudo sed -i '0,/bind = 239.2.11.71/{s/bind = 239.2.11.71//}'  /etc/ganglia/gmond.conf 

sudo service ganglia-monitor restart && sudo service gmetad restart && sudo service apache2 restart 