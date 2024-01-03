{ lib, stdenv, fetchurl }:

stdenv.mkDerivation rec {
  pname = "comic-code-font";
  version = "1.0";

  src = ./comic-code;

  installPhase = ''
    mkdir -p $out/share/fonts/opentype
    cp $src $out/share/fonts/opentype/${pname}.otf
  '';

  meta = with lib; {
    description = "Comic code font by toshi omagari";
    homepage = "https://tosche.net/fonts/comic-code";
    license = licenses.ofl;
  };
}
