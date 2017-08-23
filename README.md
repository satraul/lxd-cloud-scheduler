# LXD Cloud Scheduler
>LXD project by GO-SQUADS Tech Intern 2017

This is the setup for LXD team's project.
The Vagrantfile is configured to make a ```web-interface``` VM (if ```ENABLE_WEB_INTERFACE``` is true) and a number of nodes (according to ```NODE_COUNT```) in a DHCP private network.

The ```web-interface``` is provisioned with chef-solo to setup [lxd-web-interface](https://github.com/rimara/lxd-web-interface).
The nodes are provisioned to setup and initialize LXD (feature branch) using ```lxd init --preseed```.
See [Vagrantfile](Vagrantfile) and [preseed.yaml](preseed.yaml) for more details.

It isn't fully automated yet, requiring manual configuration for:
1. Fetching and adding node VM IP to the Ip_Addresses table of lxdwebinterface psql db.
2. Certificate authentication for LXD API (https://NODE_IP:8443/1.0/certificates).
3. Creating a default container image.

## Installing / Getting started

Prerequesites are VirtualBox and Vagrant. To install, please run:
```bash
$ brew cask install virtualbox vagrant
```
If you're on Mac, you need an updated curl with a newer version of OpenSSL to authenticate a certificate to the LXD API.
Please run:
```bash
$ brew install curl --with-nghttp2
$ brew link curl --force
$ echo 'export PATH="/usr/local/opt/curl/bin:$PATH"' >> ~/.zshrc
```
And restart your terminal.

After cloning, run this in the root of the repo:
```bash
$ vagrant up
```

Done! To go into the web-interface VM, run ```vagrant ssh web-interface```. ```exit``` to get out.
You can access the LXD API through through ```https://NODE_IP:8443/```.

To authenticate certificates for LXD API, you need to:
1. Retreive the node IP using ```ifconfig``` (inside the node VM).
2. Gerenerate an SSL certificate, or just use one from the root of [lxd-web-interface](https://github.com/rimara/lxd-web-interface).
3. Post the certificate with ```curl -k --cert client.crt --key client.key https://NODE_IP:8443/1.0/certificates -X POST -d '{"type": "client", "password": "admin"}'```
4. Now you're fully authenticated. Try ```curl -k --cert client.crt --key client.key https://NODE_IP:8443/1.0 -X GET```.

## Developing

```bash
$ git clone https://github.com/satraul/lxd-cloud-scheduler.git
$ cd lxd-cloud-scheduler/
```

## Licensing

The code in this project is licensed under MIT license.
