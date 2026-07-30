{ flakeArgs, pkgs, lib, ... }:

let
  myPlymouthTheme =
    flakeArgs.self.localPackagesForPkgs pkgs.plymouth;
in
{
  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = false;
    };

    plymouth = {
      enable = true;

      theme = "hud";

      themePackages = [
        myPlymouthTheme
      ];
    };
  };
}
