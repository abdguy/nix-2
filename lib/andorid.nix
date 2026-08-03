{ lib, config, ... }:
{
  config = lib.mkIf config.hackson.desktop_interface.androidDev {
    programs.adb.enable = true;
    users.users.hackson.extraGroups = [ "adbusers" ];
  };
}
