{ lib, config, pkgs, ... }:
let cfg = config.hackson.unifi; in
{
  options.hackson.unifi.enable = lib.mkEnableOption "Enable unifi controller";

  config = {
    services.unifi = lib.mkIf cfg.enable {
      enable = true;
      unifiPackage = pkgs.unifi;
      openFirewall = true;
      jrePackage = pkgs.jre8_headless;
    };
  };
}