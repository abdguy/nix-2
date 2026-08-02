{ lib, config, ... }:
{
  config = lib.mkIf config.lun.desktop_interface.androidDev {
    programs.adb.enable = true;
    users.users.lun.extraGroups = [ "adbusers" ];
  };
}
