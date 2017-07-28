echo "Hello from $HOSTNAME"

#Surpressing stderr
echo "Installing ZFS"
sudo apt-get install -qq -y zfs 2> /dev/null

echo "Installing LXD feature branch (2.X)"
sudo apt install -qq -y -t xenial-backports lxd lxd-client 2> /dev/null

#Intialize lxd if it hasn't been initialized
if ["$(sudo lxc config get core.trust_password 2> /dev/null)" = ""] ; then
    echo "Running lxd init with --preseed"
    cat /vagrant/preseed.yaml | lxd init --preseed
else
    echo "LXD already initialized"
fi
