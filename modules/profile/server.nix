{ config, lib, ... }:
{
  options.hackson.profiles.server = lib.mkEnableOption "Enable server profile";
  config = lib.mkIf config.hackson.profiles.server {
    hardware.graphics.enable = lib.mkForce false;
    services.pulseaudio.enable = lib.mkForce false;
    services.pipewire.enable = lib.mkForce false;
    boot.plymouth.enable = lib.mkForce false;
  };
}