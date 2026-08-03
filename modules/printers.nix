{ pkgs, lib, config, ... }:
{
  options.hackson.print.enable = lib.mkEnableOption "Enable printing and scanning";
  config = lib.mkIf config.hackson.print.enable {
    services.printing = {
      enable = true;
      drivers = [
        pkgs.hplip
      ];
    };

    hardware.printers.ensurePrinters = [
      {
        name = "HP_LaserJet";
        location = "Home";
        deviceUri = "usb://HP/LaserJet";
        model = "drv:///hp/hpcups.drv/hp-laserjet.ppd";
        ppdOptions = {
          PageSize = "A4";
        };
      }
    ];
  };
}
