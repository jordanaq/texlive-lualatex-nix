{
  description = "LaTeX Docker image with texlive and git";

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
          name = "texlive";
          tag = "latest";
          created = "now";
          copyToRoot = pkgs.buildEnv {
            name = "image-root";
            paths = with pkgs; [
              bash
              busybox
              cmake
              coreutils
              curl
              findutils
              gawk
              gcc
              git
              glibc
              nodejs_20
              texlive.combined.scheme-medium
            ];
          };
          config = {
            Cmd = [ "bash" ];
            WorkingDir = "/workspace";
          };
        };
      });
}
