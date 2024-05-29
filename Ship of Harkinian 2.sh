#!/bin/bash

XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

if [ -d "/opt/system/Tools/PortMaster/" ]; then
  controlfolder="/opt/system/Tools/PortMaster"
elif [ -d "/opt/tools/PortMaster/" ]; then
  controlfolder="/opt/tools/PortMaster"
elif [ -d "$XDG_DATA_HOME/PortMaster/" ]; then
  controlfolder="$XDG_DATA_HOME/PortMaster"
else
  controlfolder="/roms/ports/PortMaster"
fi

source $controlfolder/control.txt
source $controlfolder/device_info.txt
[ -f "${controlfolder}/mod_${CFW_NAME}.txt" ] && source "${controlfolder}/mod_${CFW_NAME}.txt"
get_controls

# Set variables
GAMEDIR="/$directory/ports/soh2"

# Exports
export LD_LIBRARY_PATH="$GAMEDIR/libs:/usr/lib:$LD_LIBRARY_PATH"

# Permissions
$ESUDO chmod 0777 /dev/tty0

cd $GAMEDIR

# Remove soh2 generated logs and substitute our own
rm -rf $GAMEDIR/logs/*
> "$GAMEDIR/logs/log.txt" && exec > >(tee "$GAMEDIR/logs/log.txt") 2>&1

# Copy the right build to the main folder
if [ $CFW_NAME == "ArkOS" ] || [ "$CFW_NAME" == 'ArkOS wuMMLe' ]; then
	cp -f bin/compatibility.elf 2s2h.elf
	if [ "$(find "./mods" -name '*.otr')" ]; then
		echo "WARNING: .OTR MODS FOUND! PERFORMANCE WILL BE LOW IF ENABLED!!" > /dev/tty0
	fi
else
	cp -f bin/performance.elf 2s2h.elf
fi

# Run the game
echo "Loading, please wait... (might take a while!)" > /dev/tty0
$GPTOKEYB "2s2h.elf" -c "soh2.gptk" & 
./2s2h.elf

# Cleanup
rm -rf "$GAMEDIR/logs/2 Ship 2 Harkinian.log"
$ESUDO systemctl restart oga_events & 
printf "\033c" >> /dev/tty1
printf "\033c" > /dev/tty0
