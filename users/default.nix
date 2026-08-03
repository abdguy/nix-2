# https://github.com/MatthewCroughan/nixcfg/blob/d577d164eadc777b91db423e59b4ae8b26853fc6/users/default.nix
{ config, lib, pkgs, ... }:
let
  cfg = config.my.home-manager;

  # TODO: are these sensible
  adminGroups = [
    "wheel" # Enable ‘sudo’ for the user.
    "plugdev" # openrazer requires this
    "openrazer"
    "docker"
    "audio"

    # printing
    "scanner"
    "lp"
  ];
in
{
  options.my.home-manager.enabled-users = with lib; mkOption {
    type = with types; listOf str;
    description = "List of users to include home manager configs for";
    default = [ ];
  };


  config = lib.mkMerge [
    (lib.mkIf (builtins.elem "hackson" cfg.enabled-users) {
      home-manager.users = {
        hackson = ./hackson;
      };

      services.impermanent-user-passwords = lib.mkIf config.hackson.persistence.enable {
        enable = true;
        username = "hackson";
        persistLocation = "${config.hackson.persistence.persistPath}/secrets/hackson-hashFile";
        initialPassword = "hack-son-nix";
      };

      users.users.hackson = {
        isNormalUser = true;
        shell = pkgs.fish;
        # TODO: are these sensible
        extraGroups = adminGroups;
      } // lib.optionalAttrs (!config.hackson.persistence.enable) {
        hashedPassword = "$6$jggJHhOd2onE5Zc.$fjbOIgcXWhcyyC3HmHOEh1Q./g8ZrxtXpMmsQo4dfo9VYTisBRv4GBmNXqzpBC8hyrJE7w0EXrmttuaMX8eBf1";
      };
    })

  ];
}
