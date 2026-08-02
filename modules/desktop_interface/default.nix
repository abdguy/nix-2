{ lib, ... }:
{
  imports = [
    ./common.nix
    ./graphical.nix
  ];

  options.lun.desktop_interface = {
    androidDev = lib.mkEnableOption "enable android development";
    personal = lib.mkEnableOption "personal system (not shared)";
  };
}
