{ lib, stdenv, fetchurl }:

stdenv.mkDerivation rec {
  pname = "rainyhearts";
  version = "1.0";

  src = ./rainyhearts;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp -r $src/*.ttf $out/share/fonts/truetype/${pname}.ttf
  '';

  meta = with lib; {
    description = "Pixel art font by Fonts Arena";
    homepage = "https://www.dafont.com/fontsarena.d9142?l[]=10&l[]=1";
    license = licenses.ofl;
  };
}
