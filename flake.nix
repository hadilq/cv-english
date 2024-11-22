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

    in {
      devShells.default = pkgs.mkShell {
        name = "xelatex-default";

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
      };
    });
}
