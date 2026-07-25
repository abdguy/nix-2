{ lib, ... }:
{
  imports = [
    ./common.nix
    ./graphical.nix
    ./gaming.nix
    ./server.nix
  ];

  options.hackson.profiles = {
    androidDev = lib.mkEnableOption "enable android development";
    personal = lib.mkEnableOption "personal system (not shared)";
  };
}