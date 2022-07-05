SkullSpace Ansible Infrastructure
===============================================================================

This is the start of rebuilding some of our infrastructure with Ansible
Playbooks, so come along and learn with us! Maybe deploy a hackerspace of your
very own! :D

## Inventories

We keep the list of machines this playbooks operate on in the
"[hosts](hosts)" file. You'll see in there that there are some groupings
and variables, but most importantly there are machine names and IP addresses.
These are just placeholders and don't represent the real machines so you'll have
to go in and edit them. 

## Running Playbooks

To run a playbook, we recommend running the following:

```
ansible-playbook -bKi hosts <something.yml>
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


## Getting Comfortable

The first playbook worth running is "[timezone.yml](timezone.yml)"
and will set the local timezone to Winnipeg/Central based off a variable
defined in the "hosts" inventory file (please give it a read).

```
ansible-playbook -bKi hosts timezone.yml
```

You'll enter your local system password when prompted, and your SSH key password
if you're not using ssh-agent. If you're tried of putting the SSH part in do the
usual `ssh-agent` followed by `ssh-add` and your shell will remember for you.

## Installing The VM Infrastructure

This is a big effort, and it will take several minutes to complete with little
feedback. It's very intel-centric and optionally blocks certain drivers from
loading so the hardware can instead be passed directly to a VM guest. Again,
please give it a read so you can feel comfortable about what it's doing.

```
ansible-playbook -bKi hosts vm/kvm.yml
```

## A Desktop?

It might be nice to have a desktop (we did actually install virt-manager in the
last step which is a graphical way to manage virtual machines). If the OS
install you have doesn't include one and you're on Ubuntu, you can run the
"[desktop.yml](desktop.yml)" to install a minimal version of Mate.

```
ansible-playbook -bKi hosts desktop.yml
```

## Great, Now What?

Largely, that should be it. Reboot the machine and hopefully you're greeted with
a login prompt. Feel good about how little real work that was needed to get here!

When you're ready, move onto [building VMs](build-scripts/README.md).

If you have other scripts to contribute, please open a pull request!

## Next Time, Faster!

Well, you've read the guide now. Next time you come here just run this big blob:

```
ansible-playbook -bKi hosts \
    timezone.yml \
    vm/kvm.yml \
    desktop.yml
```