 { config, pkgs, ... }:
 let
  unstableSmall = import <nixos-unstable-small> { config = {}; };
in
{environment.systemPackages = with pkgs; [

# Gnome
gnome-shell-extensions #Gnome extensions.
gnome-tweaks #Tweaks.
gnome-themes-extra #More themes to add propper dark mode.
gnome-disk-utility #Disk tool.
alacarte #Gnome menu editor.
baobab #Disk analyser.
gnome-calculator #Calculator.
nautilus #File explorer.
gnome-text-editor #Text editor GUI app.
eog #Images.
totem #Videos.
evince #Documents.

# Util
btop #System monitor.
nvtopPackages.full #GPU monitor.
corectrl #GPU configuration.
openrgb-with-all-plugins #RGB control.
pavucontrol #Audio devices configuration.
helvum #Audio porting.
fastfetch #Loonix redditing.
obsidian #Notes.

# Wine and friends
wine64Packages.stagingFull #Wine 64 bit tools.
winePackages.stagingFull #Wine 32 bit tools.
winetricks #Wine prefix editor.
protontricks #Proton prefix editor.
proton-caller #Proton updater.
protonup #Proton GE.
protonup-qt #Proton for easy apply to other apps.

# Basic Applications
alacritty #Terminal emulator.
brave #Web browser.
discord #Discord.
spotify #Spotify.

# Games
lutris #The OG.
heroic-unwrapped #Epic and GOG.
xivlauncher #FFXIV dalamud launcher.
prismlauncher #Minecraft launcher.
r2modman #Mod stuffs for loads of games.
fflogs #Not ego parsing.
gamemode #Optimizations for games.

# Emulators
rpcs3 #PS3.
shadps4 #PS4.
xemu #Original Xbox.
ryujinx #Switch.
retroarchFull #Most other emulators.

# Studio
onlyoffice-bin #Office suite.
davinci-resolve #Premeir Pro & After effects.
gimp #Photoshop.
inkscape-with-extensions #Illistrator.
blender #3D model editor.
audacity #Audio editor.
obs-studio #OBS.
linuxKernel.packages.linux_6_6.v4l2loopback #OBS virtual cam.
kicad #PCB CAD. 
unityhub #Game engine.
godot #Other game engine.

# Archive and Compression
unrar #.rar files are fucking lame.
p7zip #The GOAT.

# Base-Devel
distrobox #Containers instead of vm's.
xorg.xhost #fml.
vim #The text editor my grandfather used.
git #Imagine not knowing what git is.
github-desktop #Git for lazy fucks.
git-lfs #Git for fat fucks.
tmux #Terminal autism.
vscode #Text editor that gets paid 6 figures.
dotnet-sdk #C# Things, not a big fan.
direnv #Load env variables in CLI.
];}
