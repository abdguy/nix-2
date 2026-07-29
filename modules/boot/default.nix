{ flakeArgs, pkgs, lib, ... }:
{
  config = {
    boot = {
      kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = false;
      };

      kernelParams = [
        "quiet"
        "splash"
        "loglevel=3"
      ];

      plymouth = {

        enable = true;

        theme = "mytheme";


        themePackages = [
          (pkgs.runCommand "mytheme" { } ''
            mkdir -p $out/share/plymouth/themes/mytheme

            cp -r ${./plymouth/mytheme}/* \
              $out/share/plymouth/themes/mytheme/
          '')
        ];
      };


    };
  };
}
