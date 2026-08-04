{ config, pkgs, lib, flakeArgs, ... }:

let
  local = flakeArgs.self.localPackagesForPkgs pkgs;
in
{
  options.hackson.desktop_interface.graphical =
    (lib.mkEnableOption "Enable graphical profile") // {
      default = true;
    };

  config = lib.mkIf config.hackson.desktop_interface.graphical {

    environment.systemPackages = lib.mkMerge [
      [
        local.sddm-theme
        pkgs.kdePackages.kate
        pkgs.kdePackages.kamera

      ]
      config.xdg.portal.configPackages
      config.xdg.portal.extraPortals
    ];

    services.xserver.enable = true;

    programs.ssh.askPassword =
      "${pkgs.x11_ssh_askpass}/libexec/x11-ssh-askpass";


    services.desktopManager.plasma6.enable = true;

    services.displayManager = {
      defaultSession = "plasma";

      sddm = {
        enable = true;
        wayland.enable = true;
        theme = "ltmnight";

        settings = {
          Theme = {
            CursorTheme = "rose-pine-hyprcursor";
            CursorSize = 24;
          };
        };

        extraPackages = with pkgs.qt6Packages; [
          qtdeclarative
          qtsvg
          qtmultimedia
          qtvirtualkeyboard
        ];
      };
    };

    systemd.services."drkonqi-coredump-processor@".wantedBy =
      lib.mkForce [ ];

    services.earlyoom = {
      enable = true;
      freeMemThreshold = 5;
      freeSwapThreshold = 10;
    };

    hackson.print.enable = false;

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
    };

    hardware.graphics = {
      enable = true;
      enable32Bit =
        lib.mkForce (pkgs.stdenv.hostPlatform.system == "x86_64-linux");
    };

    services.pulseaudio.enable = false;

    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      wireplumber.enable = true;
      jack.enable = false;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    hardware.bluetooth.enable = true;

    hackson.persistence.dirs = [
      "/var/lib/bluetooth"
    ];

    services.blueman.enable = true;

    programs.dconf.enable = true;

    services.speechd.enable = true;
  };
}
