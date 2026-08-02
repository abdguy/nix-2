{ lib
, stdenvNoCC
, fetchFromGitHub
}:


stdenvNoCC.mkDerivation {
  pname = "hyprlock-style";
  version = "git";

  src = fetchFromGitHub {
    owner = "MrVivekRajan";
    repo = "Hyprlock-Styles";
    rev = "main";
    hash = "sha256-BCf34JqAp2LSPn+fsPcgBq//uUdQkVSMCC6B+vXIh7Q=";
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/hyprlock-style

    cp -r Style-2/* $out/share/hyprlock-style/
  '';

  meta = with lib; {
    description = "Style 2 theme for Hyprlock";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
