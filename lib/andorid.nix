{ lib, config, ... }:

let
  cfg = config.hackson.profiles.androidDev;
in
{
  options.hackson.profiles.androidDev.enable = lib.mkEnableOption "jhh";

  config = lib.mkIf cfg.enable {
    programs.adb.enable = true;
    users.users.hackson.extraGroups = [ "adbusers" ];
  };
}