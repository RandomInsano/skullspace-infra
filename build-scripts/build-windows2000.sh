#!/bin/sh

# Build a Windows 2000 SP4 virtual machine from WinWorld download
#
# You'll have to visit the site for the CD key and also run this on
# the VM host to get proper graphics. Windows does not install
# automatically

ISO_NAME=EN_WIN2000_PRO_SP4.ISO
VM_MEDIA_STORE=/tmp
VM_DISK_STORE=/var/lib/libvirt/images/
TEMP_STORE=/tmp

MIRROR='https://dl.winworldpc.com'
MIRROR='https://dl-alt1.winworldpc.com'
ISO_URL="$MIRROR/Abandonware%20Operating%20Systems/PC/Microsoft%20Windows/Windows%202000/Microsoft%20Windows%202000%20Professional%20(5.00.2195.6717.sp4).7z"

if [ -z "$1" ]; then
	echo "Usage: $0 <vm name>"
	exit 0
fi

if [ ! -f "$VM_MEDIA_STORE/$ISO_NAME" ]; then
	# Download the ISO (and continue the download if aborted or skip if exists)
	echo "Downloading Windows 2000"
	curl -#C - -o $TEMP_STORE/Windows2000_SP4.7z $ISO_URL
	echo -n "Extracting... "
	7z e -y -o"$VM_MEDIA_STORE" $TEMP_STORE/Windows2000_SP4.7z > /dev/null
	echo "Done!"
fi

virt-install --name "$1" \
	--memory 128 \
	--disk "$VM_DISK_STORE/$1.img",size=4 \
	--video=cirrus \
	--os-type=Windows \
	--os-variant win2k \
	--graphics spice \
	--cdrom $VM_MEDIA_STORE/$ISO_NAME

