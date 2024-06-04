#!/bin/sh

# Set correct ownership and permissions for the files in /lib/firmware
chown root:root $TARGET_DIR/lib/firmware/system_top.bit.bin
chown root:root $TARGET_DIR/lib/firmware/flash.sh
chmod 755 $TARGET_DIR/lib/firmware/flash.sh

# Set correct ownership and permissions for the init.d script
chown root:root $TARGET_DIR/etc/init.d/S99flash
chmod 755 $TARGET_DIR/etc/init.d/S99flash
