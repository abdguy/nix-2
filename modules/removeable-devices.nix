{ lib, config, ... }:

let
  cfg = config.modules.hardware.usbEthernet;
in
{
  options.modules.hardware.usbEthernet.enable =
    lib.mkEnableOption "Enable USB Ethernet RTL8156 configuration";

  config = lib.mkIf cfg.enable {
    systemd.network.links."10-en-usb-8cd8" = {
      matchConfig.PermanentMACAddress = "8c:ae:4c:dd:20:d8";
      linkConfig.Name = "en-usb-8cd8";
    };

    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="usb", \
      ATTR{idVendor}=="0bda", \
      ATTR{idProduct}=="8156", \
      TEST=="power/control", \
      ATTR{power/control}="on"
    '';
  };
}