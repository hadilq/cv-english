{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "nixpkgs/nixos-24.11";
  };

  outputs = { flake-utils, nixpkgs, ... }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
      };

      buildInputs = with pkgs; [
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

      FONTCONFIG_FILE = pkgs.makeFontsConf {
        fontDirectories = [ ./fonts/Rubik/static ];
      };

    in {
      packages.resume = pkgs.stdenv.mkDerivation {
        name = "resume";
        inherit buildInputs FONTCONFIG_FILE;
        src = ./.;
        buildPhase = ''
          ./generate.sh
        '';
        installPhase = ''
          mkdir -p $out/bin
          cp cv-public-lashkari-*.pdf $out

          cat <<EOF > $out/bin/resume
          #!/bin/bash
          echo $out/cv-public-lashkari-*.pdf
          EOF

          chmod +x $out/bin/resume
        '';
      };

      devShells.default = pkgs.mkShell {
        name = "xelatex-shell";
        inherit buildInputs FONTCONFIG_FILE;
      };
    });
}
