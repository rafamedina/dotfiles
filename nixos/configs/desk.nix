# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs;
  [
    firefox
    ntfsprogs
    skype
    xfce.xfce4-battery-plugin
    xfce.xfce4-appfinder
    xfce.xfce4-xkb-plugin

    lightdm
    lightdm_gtk_greeter
    gnome3.nautilus
    polybarFull
  ];

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;   
    displayManager.defaultSession = "xfce";
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
      };
    };
  };
  services.picom = {
    enable = true;
    fade = true;
    inactiveOpacity = "0.9";
    shadow = true;
    fadeDelta = 4;
  };

  services.xserver.layout = "us,latam";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;
}

