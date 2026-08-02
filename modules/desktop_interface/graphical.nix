{ config, pkgs, lib, flakeArgs, ... }:
let
  local = flakeArgs.self.localPackagesForPkgs pkgs;
in
{
  options.lun.desktop_interface.graphical =
    (lib.mkEnableOption "Enable graphical profile") // { default = true; };

  config = lib.mkIf config.lun.desktop_interface.graphical {

    environment.systemPackages = lib.mkMerge [
      [
        local.sddm-theme
        pkgs.bibata-cursors
      ]
      config.xdg.portal.configPackages
      config.xdg.portal.extraPortals
    ];

    services.xserver.enable = true;

    programs.ssh.askPassword =
      "${pkgs.x11_ssh_askpass}/libexec/x11-ssh-askpass";

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "ltmnight";

      extraPackages = with pkgs.qt6Packages; [
        qtdeclarative
        qtsvg
        qtmultimedia
        qtvirtualkeyboard
      ] ++ [
        pkgs.bibata-cursors
      ];


    };

    # Environment for SDDM greeter
    systemd.services.display-manager.serviceConfig.Environment = [
      "XCURSOR_THEME=Bibata-Modern-Classic"
      "XCURSOR_SIZE=24"
      "XCURSOR_PATH=${pkgs.bibata-cursors}/share/icons"
    ];

    systemd.services."drkonqi-coredump-processor@".wantedBy = lib.mkForce [ ];

    services.displayManager.defaultSession = "hyprland";

    services.earlyoom = {
      enable = true;
      freeMemThreshold = 5;
      freeSwapThreshold = 10;
    };

    lun.print.enable = false;

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
    };

    hardware.graphics = {
      enable = true;
      enable32Bit = lib.mkForce (pkgs.stdenv.hostPlatform.system == "x86_64-linux");
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

    lun.persistence.dirs = [
      "/var/lib/bluetooth"
    ];

    services.blueman.enable = true;
    programs.dconf.enable = true;
    services.speechd.enable = true;
  };
}
