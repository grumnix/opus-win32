{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    flake-utils.url = "github:numtide/flake-utils";

    tinycmmc.url = "github:grumbel/tinycmmc";
    tinycmmc.inputs.nixpkgs.follows = "nixpkgs";
    tinycmmc.inputs.flake-utils.follows = "flake-utils";

    opus_src.url = "https://archive.mozilla.org/pub/opus/opus-1.3.1.tar.gz";
    opus_src.flake = false;
  };

  outputs = { self, nixpkgs, flake-utils, tinycmmc, opus_src }:
    tinycmmc.lib.eachWin32SystemWithPkgs (pkgs:
      {
        packages = rec {
          default = opus;

          opus = pkgs.stdenv.mkDerivation {
            pname = "opus";
            version = "0.2";

            src = opus_src;

            enableParallelBuilding = true;

            configureFlags = [
            ];

            makeFlags = [
              "LDFLAGS=-lssp"
            ];

            nativeBuildInputs = [
              pkgs.buildPackages.pkgconfig
              # pkgs.pkgconfig
            ];
          };
        };
      }
    );
}