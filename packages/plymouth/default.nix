{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  pname = "plymouth-theme";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "adi1090x";
    repo = "plymouth-themes";
    rev = "5d8817458d764bff4ff9daae94cf1bbaabf16ede";
    hash = "sha256-e3lRgIBzDkKcWEp5yyRCzQJM6yyTjYC5XmNUZZroDuw=";
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/plymouth/themes/optimus

    cp -r pack_3/optimus/* \
      $out/share/plymouth/themes/optimus/

    # Fix paths for NixOS
    substituteInPlace $out/share/plymouth/themes/optimus/optimus.plymouth \
      --replace-fail "/usr/share/plymouth/themes/optimus" \
      "$out/share/plymouth/themes/optimus"
  '';
}
