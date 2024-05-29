## Information
2Ship2Harkinian binaries were built from the develop branch (bleeding edge) on 05/27/2024 with commit [513e89c](https://github.com/HarbourMasters/2ship2harkinian/commit/513e89c073e79b29f9b8fc27abb2dd7aada9a5db). You can build your own binaries by following the [BUILDING.md guide](BUILDING.md).

## Installation
You must generate your `mm.o2r` file on a PC with one of the following SHAs:

```
d6133ace5afaa0882cf214cf88daba39e266c078 - N64 US
9743aa026e9269b339eb0e3044cd5830a440c1fd - GC US
```

Obtain your rom and download [2Ship2Harkinian](https://github.com/HarbourMasters/2ship2harkinian/releases), then place the rom in the same folder and run the 2ship binary to generate your `mm.o2r` file. Copy it to the `ports/soh2` folder. Texture pack files can be added to the `ports/soh2/mods` folder. Logs are recorded automatically and kept in `/ports/soh2/logs`. Please provide a log if you report an issue. PortMaster does not mantain the 2Ship2Harkinian repository and is not responsible for bugs or issues outside of our control.

## Graphics Adjustments
You can open `2ship2harkinan.json` in a text editor and modify the values as you wish. If you mess up the syntax, the game will regenerate this file and your settings will be reverted to default. Please create a backup before modification. If you're running a widescreen device, you can copy `json/2ship2harkinian-ws.json` to the base folder as `2ship2harkinian.json` for a widescreen HUD.

## Further Adjustments
There is a `soh2.gptk` file you can use to change which button emulates F1 (default is L3). Controller menu navigation is not implemented yet, but you can use a mouse.

## Default Gameplay Controls
The port uses SDL controller mapping and controls can be remapped from the menu bar.

## Suggested Mods
You can find mods at https://gamebanana.com/games/20371.

## Thanks
- Nintendo for the game  
- HarbourMasters for the native pc port  
- AkerHasReawakened for the cover art  
- Testers and Devs from the PortMaster Discord  




