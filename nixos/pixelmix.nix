{ lib, stdenv, fetchurl }:

stdenv.mkDerivation rec {
  pname = "pixelmix";
  version = "1.0";

  src = ./pixelmix;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp -r $src $out/share/fonts/truetype/${pname}.ttf
  '';

  meta = with lib; {
    description = "Comic code font by toshi omagari";
    homepage = "https://tosche.net/fonts/comic-code";
    license = licenses.ofl;
  };
}
