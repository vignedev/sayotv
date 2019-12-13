# sayotv
Information board made for my school with Löve for single board Raspberry Pi computers. Made to be displayed on *vertical displays*. 

As of time of writing, it displays nothing more than the best girl holding an energy drink from [UsagiSii](https://twitter.com/UsagiSii/status/1194167229819998210), because our backend is not finished yet and this is currently used as a stress-testing tool to see how far can we push RPi and it's OpenGL capabilities.

Also the main reason it's here on GitHub is for auto-update capabilities later on.

## Installation

Both instructions assume you're using a fresh install of Raspbian 10 Buster.

### Using script

There is a script prepared called `install.sh` however it is untested and may or may not mess your setup up. It's not reccommended so use at your own discretion.

To use this script, simply run the script with root.

```bash
chmod +x ./install.sh
sudo ./install.sh
```

### Manual installation

Install these dependencies
```bash
sudo apt update
sudo apt install git love xserver-xorg xinit
```

Enable OpenGL driver (fake KMS is fine)
```bash
sudo raspi-config
```

Clone this repository and launch it (with Xserver running)
```bash
git clone https://github.com/vignedev/sayotv
love sayotv
```
## Configuration

The configuration isn't easily customizable, so manual labor is required.

For developement (and saving our necks) we can turn off the vertical mode in `conf.lua`'s header.

```lua
vertigoMode = false               --vertical rotation
vertigoOrientation = -1           --orientation (1 rotates clockwise; -1 rotates counterclockwise)
scale = 0.5                       --scale down (for developement, mostly)
scrWidth = 1920                   --screen width
scrHeight = 1080                  --screen height
primaryColor = { 1.0, 0.1, 0.0 }  --header/footer color
```

Logo can be changed by replacing the file at `assets/logo.png` or changing the filename at `components/staticparts.lua`.
```lua
local logo = lg.newImage('assets/logo.png')
```

## License

MIT