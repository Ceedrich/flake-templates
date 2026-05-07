{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };
  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};

    name = "my-cpp-app"; # TODO: change name
    nativeBuildInputs = with pkgs; [
      cmake
      # libsForQt5.wrapQtAppsHook
    ];
    buildInputs = with pkgs; [
      # libsForQt5.qtbase
      # raylib
    ];
  in {
    packages.${system}.default = pkgs.stdenv.mkDerivation (finalAttrs: {
      name = name;

      src = ./.;

      inherit nativeBuildInputs buildInputs;

      installPhase = ''
        runHook preInstall

        mkdir -p $out/bin
        cp ./bin/* $out/bin/

        runHook postInstall
      '';
    });
  };
}
