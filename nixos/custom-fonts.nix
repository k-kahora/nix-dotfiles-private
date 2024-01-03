{ lib, fetchurl, fontconfig, stdenv }:

let
  fontsDir = "./comic-code";  # Replace with the path to your local font files directory.
in

self: super: {
  customFonts = super.buildFont {
    name = "comic-code";
    src = fontsDir;
    buildInputs = [ fontconfig ];
  };
}
