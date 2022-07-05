Build Scripts
===============================================================================

This is a collection of scripts that might not *quite* fit into Ansible but are
useful for getting our infrastructure up and running.

### Building Windows 2000

Because Windows 2000 SP4 is officially abandonware, if you want to build a
fully working desktop with one script just run [build-windows2000.sh](build-windows2000.sh).

There's no balloon driver, so it'll use the full 128 MB. Also, because there
don't seem to be *any* virtio drivers this will run at about 15% CPU at idle
during testing while Windows XP Pro SP2 used only 10%. I'm sure disk/graphic
intensive workloads will also suffer, but hey it's free!

You'll find some hints in the script like where to find the CD key

### Building Windows XP

This by default expects the official media in the first optical drive on the
host system but you can edit the top of the script to provide an ISO. 

Once you have the disk inserted, run [build-windows2000.sh](build-windows2000.sh).
This will download the drivers required for virtio but there are a number of steps
you'll need to follow:

1. Run the installer as you normally would (virt-install can't automate XP)
2. Accept any unsigned-driver warnings as you go along
3. Open device manager and use the mounted driver CD for the unidentifed hardware
4. Remove the virtual floppy and second disk drive so it can start once /tmp is cleaned

That should be it! You're good to go.