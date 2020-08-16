# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs;
  [
    clojure
    leiningen
  ];
  
  services.emacs = with pkgs; {
    enable = true;
    defaultEditor = true;
  };
}

