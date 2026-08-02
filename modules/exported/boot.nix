{ flakeArgs, pkgs, lib, ... }:
let
  local = flakeArgs.self.localPackagesForPkgs pkgs;

in
{
  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    plymouth = {
      enable = true;

      theme = "optimus";

      themePackages = [
        local.plymouth-theme

      ];
    };
  };
}

