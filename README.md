SkullSpace Ansible Infrastructure
===============================================================================

This is the start of rebuilding some of our infrastructure with Ansible
Playbooks, so come along and learn with us! Maybe deploy a hackerspace of your
very own! :D

### Inventories

We keep the list of machines this playbooks operate on in the
"[hosts](hosts)" file. You'll see in there that there are some groupings
and variables, but most importantly there are machine names and IP addresses.
These are just placeholders and don't represent the real machines so you'll have
to go in and edit them. 

### Running Playbooks

To run a playbook, we recommend running the following:

```
ansible-playbook -bKi hosts something.yml
```

But, what does this actually do? The "-i host" uses a list of hosts to run the
playbooks on. You'll notice if you look at any of the YAML files that the hosts
fitler is "all" and so the playbook will execute on all machines listed in the
hosts file.

The "-bK" tells Ansible to "become" an elevated user with the default method
(which is to use `sudo`) and ask for the password you'd be prompted when
running it. This does *not* use the password to SSH to the other machine, by
default Ansible will SSH to each machine in the "hosts" inventory file in
parallel and do its thing.


### Getting Comfortable

The first playbook worth running is "[timezone-central.yml](timezone-central.yml)"
and will set the local timezone to Winnipeg/Central (please give it a read so
it makes some sense.

```
ansible-playbook -bKi hosts timezone-central.yml
```

You'll enter your local system password when prompted, and your SSH key password
if you're not using ssh-agent. If you're tried of putting the SSH part in do the
usual `ssh-agent` followed by `ssh-add` and your shell will remember for you.

### Getting The VM Infrastructure

This is the big effort, and it will take a long time to complete with little
feedback. It's very intel-centric and optionally blocks certain drivers from
loading so the hardware can instead be passed directly to a VM guest. Again,
please give it a read so you can feel comfortable.

```
ansible-playbook -bKi hosts vm/kvm.yml
```

### A Desktop?

It might be nice to have a desktop (we did actually install virt-manager in the
last step which is a graphical way to manage virtual machines). If the OS
install you have doesn't include one and you're on Ubuntu, you can run the
"[desktop.yml](desktop.yml)" to install a minimal version of Mate on Ubuntu.
Up to you, but installing Windows without a GUI needs more work (open VNC ports)

```
ansible-playbook -bKi hosts desktop.yml
```

### Great, Now What?

Largely, that should be it. Reboot the machine and hopefully you're greeted with
a login prompt. More steps will come as far as setting up a Windows XP VM and
other pieces but for now, feel good about how little real work you needed to
to here!

There is a build script that automatically downloads Windows 2000 and builds
a VM with a 4GB disk. You'll need to run it on the host to get a GUI unless you
want to edit the script. You can run it like so (change "Windows2000" for a
better name, but it can't have spaces):

```
build-scripts/build-windows2000.sh Windows2000
```

You'll have to wait a bit while it downloads and extracts. Also, if you cancel
the extraction you'll need to delete the partial ISO in "/tmp"

### Next Time, Faster!

Well, you've read the guide. Next time you come here just run this big blob:

```
ansible-playbook -bKi hosts \
    timezone-central.yml \
    vm/kvm.yml \
    desktop.yml
build-scripts/build-windows2000.sh Windows2000
```