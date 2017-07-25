# LXD Cloud Scheduler
>LXD project by GO-SQUADS Tech Intern 2017

This is the setup for LXD team's project.
The Vagrantfile is configured to make 3 VMs (master + 2 nodes) in a dhcp private network.
In each VM, LXD is initialized automatically using ```lxd init --preseed```
See [Vagrantfile](Vagrantfile) and [preseed.yaml](preseed.yaml) for more details.
As of now, the LXDs aren't connected yet.

## Installing / Getting started

Prerequesites are VirtualBox and Vagrant. To install, please run:
```bash
sudo apt-get install virtualbox vagrant
```
After cloning, run this in the root of the repo:
```bash
vagrant up
vagrant ssh master
```
Done! To go into the master VM, run ```vagrant ssh master```
Try  ```lxc list```

## Developing

```bash
git clone https://github.com/satraul/lxd-cloud-scheduler.git
cd lxd-cloud-scheduler/
```

To-do list for automation:
1. Configure LXD bridge and tunneling between LXD hosts

## Licensing

The code in this project is licensed under MIT license.
