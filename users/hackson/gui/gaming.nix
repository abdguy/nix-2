{ pkgs, config, lib, hackson-profiles, ... }:
let
  runtime = "${pkgs.opencomposite}/lib/opencomposite";
  # runtime = "${pkgs.xrizer}/lib/xrizer";
in
{
  # osu-lazer # not currently playing
  # prismlauncher # not currently playing
  home.packages = lib.optionals (hackson-profiles.wineGaming or false) [
    pkgs.hackson-pkgs.wine
    # TODO: try bottles instead of lutris
  ];

  xdg.configFile."openxr/1/active_runtime.json".source = "${pkgs.monado}/share/openxr/1/openxr_monado.json";
  xdg.configFile."openvr/openvrpaths.vrpath".text = ''
    {
      "config": ["${config.xdg.dataHome}/Steam/config"],
      "external_drivers": null,
      "jsonid": "vrpathreg",
      "log": ["${config.xdg.dataHome}/Steam/logs"],
      "runtime" : ["${runtime}"],
      "version" : 1
    }
  '';
}