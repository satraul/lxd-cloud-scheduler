# LXD Cloud Scheduler
>LXD project by GO-SQUADS Tech Intern 2017

This is the setup for LXD team's project.
The Vagrantfile is configured to make 3 VMs (master + 2 nodes) in a dhcp private network.
In each VM, LXD is initialized automatically using ```lxd init --preseed```.
See [Vagrantfile](Vagrantfile) and [preseed.yaml](preseed.yaml) for more details.
As of now, the LXDs aren't connected yet.

## Installing / Getting started

Prerequesites are VirtualBox and Vagrant. To install, please run:
```bash
sudo brew cask install virtualbox vagrant
```
If you're on Mac, you need an updated curl with a newer version of OpenSSL to access the API.
Please run:
```bash
brew install curl --with-nghttp2
brew link curl --force
echo 'export PATH="/usr/local/opt/curl/bin:$PATH"' >> ~/.zshrc
```
And restart your terminal.

After cloning, run this in the root of the repo:
```bash
vagrant up
```
Done! To go into the master VM, run ```vagrant ssh master```. ```exit``` to get out.
To try to access the API from outside, run ```curl -k --http2 --cert client.crt --key client.key https://172.28.128.3:8443/1.0 -X GET```.
Replace the IP with the correct one from ```ifconfig``` (inside the VM).

## Developing

```bash
git clone https://github.com/satraul/lxd-cloud-scheduler.git
cd lxd-cloud-scheduler/
```

To-do list for automation:
1. Configure LXD bridge and tunneling between LXD hosts

## Licensing

The code in this project is licensed under MIT license.
