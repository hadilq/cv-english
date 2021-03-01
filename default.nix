{ nixpkgs ? import <nixpkgs> {} }:
with nixpkgs.pkgs;
stdenv.mkDerivation {
  name = "xelatex-default";
  buildInputs = [
   (texlive.combine {
     inherit (texlive)
     scheme-small
     fontspec
     xcolor
     stackengine
     geometry
     titlesec
     tocloft
     hyperref
     xifthen
     etoolbox
     ifmtarg;
   })
  ];

  FONTCONFIG_FILE = makeFontsConf {
    fontDirectories = [ ./fonts/Rubik/static ];
  };

  buildPhase = ''
    ./generate.sh
  '';
}

