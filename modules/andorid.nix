{ lib, config, ... }:

let
  cfg = config.hackson.profiles.androidDev;
in
{
  options.hackson.profiles.androidDev = lib.mkEnableOption "Enable Android development tools";

  config = lib.mkIf cfg {
    programs.adb.enable = true;
    users.users.hackson.extraGroups = [ "adbusers" ];
  };
}