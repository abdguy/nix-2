{ lib, pkgs, hackson-desktop_interface, ... }:
{
  imports = [

    ./modern-unix.nix
    ./shells
    ./on-nixos
    ./jujutsu.nix
  ] ++ lib.optionals hackson-desktop_interface.graphical [
    ./gui
  ];

  manual.manpages.enable = false;
  programs.man.enable = false;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "hackson";
  home.homeDirectory = "/home/hackson";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    # Nice to have these on path especially since
    # can't nix run pkgs#usbutils and get lsusb!
    usbutils
    pciutils
    nixpkgs-fmt
    nixpkgs-review
    nixpkgs-hammering
    gh
    unar
    unzip
    p7zip
    git-filter-repo
  ];

  programs.git = {
    enable = true;

    lfs.enable = true;

    settings = {
      user.name = "Your Name";
      user.email = "your-email@example.com";

      checkout.defaultRemote = "origin";
      core.eol = "lf";

      gpg.format = lib.mkForce "ssh";
      commit.gpgsign = true;
      user.signingkey = "/home/hackson/.ssh/git_signing_key.pub";

      diff.colorMoved = "zebra";
      fetch.prune = true;

      init.defaultBranch = "main";

      rebase.autostash = true;
      rebase.autoSquash = true;
      pull.rebase = true;
      push.autoSetupRemote = true;

      merge.tool = "vscode";
      merge.conflictStyle = "diff3";
      diff.tool = "vscode";

      mergeTool = {
        keepBackup = false;
        vscode.cmd = "code --wait --new-window $MERGED";
      };

      difftool.vscode.cmd = "code --wait --new-window --diff $LOCAL $REMOTE";
      include.path = "./local";
    };
  };



  programs.nix-index.enable = true;

  # FIXME: makes firefox open blank window?
  # systemd.user.startServices = "sd-switch";
}
