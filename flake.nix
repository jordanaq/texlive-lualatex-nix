{
  description = "LaTeX Docker image with luatatex, latexmk, and git";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        packages.dockerImage = pkgs.dockerTools.buildImage {
          name = "texlive-lualatex";
          tag = "latest";
            contents = with pkgs; [
              git
              latexmk
              texlive.combined.scheme-full
          ];
          config = {
            Cmd = [ "bash" ];
            WorkingDir = "/workspace";
          };
        };
      });
  }
