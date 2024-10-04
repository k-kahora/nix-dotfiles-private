{ lib, stdenv, fetchurl }:

stdenv.mkDerivation rec {
  pname = "W95FA";
  version = "1.0";

  src = ./W95FA;

  installPhase = ''
    mkdir -p $out/share/fonts/opentype
    cp -r $src $out/share/fonts/opentype/${pname}.otf
  '';

  meta = with lib; {
    description = "Pixel art font by Fonts Arena";
    homepage = "https://www.dafont.com/fontsarena.d9142?l[]=10&l[]=1";
    license = licenses.ofl;
  };
}
