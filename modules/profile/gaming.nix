{ config, lib, ... }:
{
  options.hackson.profiles.gaming = lib.mkEnableOption "Enable gaming profile";
  options.hackson.profiles.wineGaming = lib.mkEnableOption "Enable wine gaming profile";
  config = lib.mkIf config.hackson.profiles.gaming {
    programs.steam.enable = true;
    services.input-remapper.enable = true;
  };
}