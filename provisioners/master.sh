echo "Running provisions for master"

echo "Creating certificate and key"

#Creating the lxc config folder
sudo mkdir /home/ubuntu/.config
sudo mkdir /home/ubuntu/.config/lxc

#Generating certificate and key quietly with (.. > /dev/null 2>&1)
sudo openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout /home/ubuntu/.config/lxc/client.key -out /home/ubuntu/.config/lxc/client.crt -batch > /dev/null 2>&1

#Copying certficate and key to root"
sudo cp /home/ubuntu/.config/lxc/client.key /vagrant/
sudo cp /home/ubuntu/.config/lxc/client.crt /vagrant/
