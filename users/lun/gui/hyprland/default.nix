{ pkgs, flakeArgs, ... }:
let
  local = flakeArgs.self.localPackagesForPkgs pkgs;
in
{
  imports = [
    ./idle.nix
  ];

  home.packages = [
    pkgs.rofi
    pkgs.hyprpaper
    pkgs.wayle
    local."hyprlock-style"
  ];

  programs.hyprlock.enable = true;

  xdg.configFile."hypr/hyprlock.conf".text = ''
    # BACKGROUND
    background {
        monitor =
        path = ${local."hyprlock-style"}/share/hyprlock-style/hypr.png
        blur_passes = 0
        contrast = 0.8916
        brightness = 0.8172
        vibrancy = 0.1696
        vibrancy_darkness = 0.0
    }

    # GENERAL
    general {
        no_fade_in = false
    }

    # Time
    label {
        monitor =
        text = cmd[update:1000] echo "<span>$(date +"%I:%M")</span>"
        color = rgba(216, 222, 233, .7)
        font_size = 90
        font_family = steelfish outline regular
        position = 0, 250
        halign = center
        valign = center
    }

    # Day-Month-Date
    label {
        monitor =
        text = cmd[update:1000] echo -e "$(date +"%A, %B %d")"
        color = rgba(216, 222, 233, .7)
        font_size = 22
        font_family = SF Pro Display Bold
        position = 0, 350
        halign = center
        valign = center
    }

    # Foreground
    image {
        monitor =
        path = ${local."hyprlock-style"}/share/hyprlock-style/foreground.png
        size = 500
        border_size = 0
        rounding = 0
        rotate = 0
        reload_time = 0
        position = 0, -50
        halign = center
        valign = center
    }

    # USER
    label {
        monitor =
        text =     $USER
        color = rgba(216, 222, 233, 0.80)
        font_size = 18
        font_family = SF Pro Display Bold
        position = 0, -150
        halign = center
        valign = center
    }

    # INPUT FIELD
    input-field {
        monitor =
        size = 300, 60
        outline_thickness = 2
        dots_size = 0.2
        dots_spacing = 0.2
        dots_center = true
        outer_color = rgba(255, 255, 255, 0)
        inner_color = rgba(255, 255, 255, 0.1)
        font_color = rgb(200, 200, 200)
        fade_on_empty = false
        font_family = SF Pro Display Bold
        placeholder_text = <i><span foreground="##ffffff99">🔒 Enter Pass</span></i>
        hide_input = false
        position = 0, -220
        halign = center
        valign = center
    }
  '';


  xdg.configFile."hypr/Fonts".source =
    "${local."hyprlock-style"}/share/hyprlock/Fonts";


  lun.hyprland-idle = {
    enable = true;
    dimPercentage = 5;
    dimTimeout = 60;
    dpmsTimeout = 180;
    lockTimeout = 600;
    suspendTimeout = null;

    mouseMoveEnablesDpms = true;
    keyPressEnablesDpms = true;

    ignoreDbus = false;
    ignoreSystemd = false;
    ignorePipewire = false;
  };


  services.hyprpaper.enable = true;

  services.hyprpaper.settings = {
    ipc = "on";
    splash = false;
  };
}
