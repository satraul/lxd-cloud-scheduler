# LXD Cloud Scheduler
>LXD project by GO-SQUADS Tech Intern 2017

This is the setup for LXD team's project.

## Installing / Getting started

After cloning, run this in the root of the repo:

```bash
$ sudo apt-get install virtualbox vagrant
$ vagrant up
$ vagrant ssh master
```

```bash
ubuntu@master $ sudo apt-get install lxd zfs bridge-utils
ubuntu@master $ sudo lxd init
```

And press enter for everything. Now you're up and running. Try ```lxc list```.

## Developing

```bash
git clone https://github.com/satraul/lxd-cloud-scheduler.git
cd lxd-cloud-scheduler/
```

To-do list for automation:
1. Create box/automate provisioning for bridge-utils and zfs
2. Updating LXD to feature release (optional)
3. Pressed file for lxd init --preseed

## Licensing

The code in this project is licensed under MIT license.
