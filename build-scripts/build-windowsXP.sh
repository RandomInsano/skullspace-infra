#!/bin/sh

# Build a Windows XP SP3 virtual machine from local ISO
#
# You'll have to provide the install media and product key yourself. By default
# this script will use the media found in the CD-ROM / DVD-ROM drive
#
# Some notes:
# * Because we're running Windows, the clock offset is needed
# * Spice is faster than VNC
# * It seems that the disk drivers are automatically discovered and loaded
# * You'll need to remove the various media from the VM for it to autoboot
# * Host CPU spun two cores with multi-CPU enabled (the default), so force 1
# * Driver floppies aren't built regularly anymore so force version 0.1.173

VM_MEDIA_STORE=/tmp
VM_DISK_STORE=/var/lib/libvirt/images/
ISO_PATH=/dev/cdrom # $VM_MEDIA_STORE/EN_WINXP_PRO_SP3.ISO
TEMP_STORE=/tmp

DRIVERS_ISO_URL='https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso'
DRIVERS_FLP_URL='https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.190-1/virtio-win_x86.vfd'

if [ -z "$1" ]; then
	echo "Usage: $0 <vm name>"
	exit 0
fi

if [ ! -f "$ISO_PATH" ]; then
	echo "Unable to find ISO at $ISO_PATH. Please provide one"
	echo 1
fi

echo -n "Downloading drivers... "
wget -qcO $TEMP_STORE/virtio-win-drivers.iso $DRIVERS_ISO_URL
wget -qcO $TEMP_STORE/virtio-win-drivers.vfd $DRIVERS_FLP_URL
echo "Done!"

virt-install --name "$1" \
	--vcpus 1 \
	--memory 512 \
	--disk "$VM_DISK_STORE/$1.img",size=8,bus=virtio \
	--disk "/tmp/virtio-win_x86.vfd",device=floppy \
	--disk "/tmp/virtio-win-drivers.iso",device=cdrom \
	--video=qxl \
	--network default,model=virtio \
	--sound ac97 \
	--os-type=Windows \
	--os-variant winxp \
	--graphics spice \
	--clock offset=localtime \
	--cdrom $ISO_PATH \
	--autostart
