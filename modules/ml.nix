{ config, lib, ... }:

let
  cfg = config.hackson.ml;

  virtualisation =
    config.virtualisation.podman.enable
    or config.virtualisation.docker.enable;

  intel = builtins.elem "intel" cfg.gpus;

in
{
  options.hackson.ml = {
    enable = lib.mkEnableOption "Enable ml";

    gpus = with lib; mkOption {
      type = with types; listOf (enum [ "intel" ]);
      default = [ ];
    };
  };

  config = lib.mkIf cfg.enable (
    lib.mkIf (virtualisation && intel) {

      hardware.graphics.enable = true;

      hardware.graphics.extraPackages = [
        # Intel GPU compute/runtime packages
      ];

    }
  );
}