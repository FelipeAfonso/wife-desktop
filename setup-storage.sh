#!/bin/bash
# Setup script for mounting the 4TB NTFS storage drive
# Run with: sudo bash setup-storage.sh
#
# Drive: /dev/sda2 (NTFS, "HD 4 TB 4")
# UUID:  E22AC8C12AC89447
# Mount: /mnt/storage
# Link:  ~/media -> /mnt/storage/media/

set -e

DRIVE_UUID="E22AC8C12AC89447"
MOUNT_POINT="/mnt/storage"
USER_NAME="felipe"
USER_UID=$(id -u "$USER_NAME" 2>/dev/null || echo "1000")
USER_GID=$(id -g "$USER_NAME" 2>/dev/null || echo "1000")

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Run this with sudo: sudo bash setup-storage.sh"
    exit 1
fi

# Verify drive exists
if ! blkid -U "$DRIVE_UUID" &>/dev/null; then
    echo "Drive with UUID=$DRIVE_UUID not found."
    echo "Available drives:"
    lsblk -f
    echo ""
    echo "Find your NTFS drive's UUID above and update DRIVE_UUID in this script."
    exit 1
fi

echo "Found drive: $(blkid -U "$DRIVE_UUID")"

# Create mount point
mkdir -p "$MOUNT_POINT"

# Build fstab line using ntfs3 (kernel driver, much faster than ntfs-3g)
# - uid/gid: files owned by your user, not root
# - dmask/fmask: directories 755, files 644
# - nofail: boot won't hang if drive is disconnected
# - x-systemd.automount: mount on first access (faster boot)
FSTAB_LINE="UUID=$DRIVE_UUID  $MOUNT_POINT  ntfs3  rw,uid=$USER_UID,gid=$USER_GID,dmask=0022,fmask=0133,nofail,x-systemd.automount  0  0"

# Check if already in fstab
if grep -q "$DRIVE_UUID" /etc/fstab; then
    echo ""
    echo "Drive already in /etc/fstab. Current entry:"
    grep "$DRIVE_UUID" /etc/fstab
    echo ""
    echo "Recommended entry:"
    echo "$FSTAB_LINE"
    echo ""
    read -p "Replace existing entry? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sed -i "\|$DRIVE_UUID|d" /etc/fstab
        echo "$FSTAB_LINE" >> /etc/fstab
        echo "Replaced."
    else
        echo "Skipped fstab update."
    fi
else
    echo "" >> /etc/fstab
    echo "# 4TB NTFS storage drive" >> /etc/fstab
    echo "$FSTAB_LINE" >> /etc/fstab
    echo "Added to /etc/fstab."
fi

# Mount it now
echo "Mounting..."
systemctl daemon-reload
mount "$MOUNT_POINT" 2>/dev/null || mount -a

# Create symlink ~/media -> /mnt/storage/media/
MEDIA_LINK="/home/$USER_NAME/media"
MEDIA_TARGET="$MOUNT_POINT/media/"

if [ -d "$MEDIA_TARGET" ]; then
    if [ -L "$MEDIA_LINK" ]; then
        echo "Symlink $MEDIA_LINK already exists -> $(readlink "$MEDIA_LINK")"
    elif [ -e "$MEDIA_LINK" ]; then
        echo "Warning: $MEDIA_LINK exists but is not a symlink. Skipping."
    else
        ln -s "$MEDIA_TARGET" "$MEDIA_LINK"
        chown -h "$USER_NAME:$USER_NAME" "$MEDIA_LINK"
        echo "Created symlink: $MEDIA_LINK -> $MEDIA_TARGET"
    fi
else
    echo "Note: $MEDIA_TARGET doesn't exist yet. Create it and then run:"
    echo "  ln -s $MEDIA_TARGET $MEDIA_LINK"
fi

echo ""
echo "Done. Verify with:"
echo "  ls -la ~/media/"
echo "  touch ~/media/test && rm ~/media/test"
