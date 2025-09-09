#	 This file is part of the OrangeFox Recovery Project
# 	 Copyright (C) 2021-2024 The OrangeFox Recovery Project
#	 Copyright (C) 2024 The Android Open Source Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#	SPDX-License-Identifier: Apache-2.0
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	  See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any part of it
#
FDEVICE="cap_sprout"
fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep -w $FDEVICE)
   if [ -n "$chkdev" ]; then
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep BASH_ARGV | grep -w $FDEVICE)
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then

 # Fox-specific flags
 export OF_QUICK_BACKUP_LIST="/boot;/data;/super;"
 ##export FOX_RECOVERY_INSTALL_PARTITION="/dev/block/bootdevice/by-name/recovery_a"
 
 
 # OrangeFox Addons
 export FOX_ENABLE_APP_MANAGER=1

 # Binaries & Tools
 export FOX_USE_BASH_SHELL=1
 export FOX_ASH_IS_BASH=1
 export FOX_USE_NANO_EDITOR=1
 export FOX_USE_TAR_BINARY=1
 export FOX_USE_SED_BINARY=1
 export FOX_USE_XZ_UTILS=1
 ##export FOX_REPLACE_BUSYBOX_PS=1

 # Version & Variant
 # export FOX_VERSION="R12.1"  Deprecated!!!!
 export FOX_MAINTAINER_PATCH_VERSION="69"
 export FOX_VARIANT="A12"
 export FOX_BUILD_TYPE="Stable"

 # A/B partitioning
 export FOX_AB_DEVICE=1
 ##export FOX_VIRTUAL_AB_DEVICE=1
 
 # Store settings at /data/recovery instead of internal storage
 ##export FOX_USE_DATA_RECOVERY_FOR_SETTINGS=1

 # Security (Disables MTP&ADB during password prompt)

 # Debugging
 ##export FOX_RESET_SETTINGS=0
 ##export FOX_INSTALLER_DEBUG_MODE=1

 # Other..
 export TW_DEFAULT_LANGUAGE="en"
 export LC_ALL="C"
 

# run a process after formatting data to work-around MTP issues
# export OF_RUN_POST_FORMAT_PROCESS=1


 # Let's see our build VARs ZZZ
 if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
  export | grep "FOX" >> $FOX_BUILD_LOG_FILE
  export | grep "OF_" >> $FOX_BUILD_LOG_FILE
  export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
  export | grep "TW_" >> $FOX_BUILD_LOG_FILE
 fi
fi
# Reserved
