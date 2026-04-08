{
  description = "Rust Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    naersk.url = "github:nix-community/naersk";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    naersk,
    rust-overlay,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [(import rust-overlay)];
    };
    name = "my-app"; # TODO: change name to match your project's name
    buildInputs = []; # TODO: change buildInputs
    nativeBuildInputs = []; # TODO: change nativeBuildInputs

    rustToolchain = pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;
  in {
    packages.${system} = {
      default =
        (naersk.lib.${system}.override {
          cargo = rustToolchain;
          rustc = rustToolchain;
        }).buildPackage {
          src = ./.;
          inherit name buildInputs;
          nativeBuildInputs = nativeBuildInputs ++ [pkgs.pkg-config];
        };
    };

    devShells.${system}.default = pkgs.mkShell {
      nativeBuildInputs = nativeBuildInputs ++ [pkgs.pkg-config];
      buildInputs = buildInputs ++ [rustToolchain];
      env.RUST_SRC_PATH = "${rustToolchain.availableComponents.rust-src}/lib/rustlib/src/rust/library";
    };
  };
}
