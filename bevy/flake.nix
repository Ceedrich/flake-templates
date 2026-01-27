{
  description = "bevy flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
    bevy_cli.url = "github:ceedrich/bevy_cli";
  };

  outputs = {
    nixpkgs,
    rust-overlay,
    flake-utils,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (
      system: let
        overlays = [
          (import rust-overlay)
          (x: y: {bevy_cli = inputs.bevy_cli.packages.${system}.bevy_cli;})
        ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
        rustToolchain = pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;
      in {
        devShells.default = import ./shell.nix {inherit pkgs rustToolchain;};
      }
    );
}
