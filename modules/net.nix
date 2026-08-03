{
  networking.wireless = {
    enable = true; # Enables wireless support via wpa_supplicant.
    networks."Abbasia5G".psk = "12345678";
  };
  networking.wireless.userControlled = true;
  users.extraUsers.hackson.extraGroups = [ "wheel" ];



  services.resolved = {
    enable = true;
    settings.Resolve = {
      LLMNR = "true";
      DNSSEC = "false";
      FallbackDNS = [
        "1.1.1.1"
        "8.8.8.8"
      ];
    };
  };
  services.nscd.enableNsncd = true;
}
