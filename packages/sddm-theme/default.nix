{ lib
, stdenvNoCC
, fetchFromGitHub
}:

stdenvNoCC.mkDerivation {
  pname = "sddm-theme";
  version = "1.2.4";

  src = fetchFromGitHub {
    owner = "hyprltm";
    repo = "ltmnight-sddm-theme";
    rev = "main";
    hash = "sha256-to8+o0DgtrwR+pXUQy7+Fk+T3Zh8kKYqI552NAjVz/k=";
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/sddm/themes/ltmnight

    cp -r ./* $out/share/sddm/themes/ltmnight/
  '';


  meta = {
    description = "Modern animated SDDM theme with HiDPI support";
    homepage = "https://github.com/hyprltm/ltmnight-sddm-theme";
    license = lib.licenses.agpl3Only;
    platforms = lib.platforms.linux;
  };
}
