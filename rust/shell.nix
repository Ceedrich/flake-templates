{
  pkgs,
  rustToolchain ? pkgs.rust-bin.stable.latest.default.override {extensions = ["rust-src"];},
  extraPackages ? [],
}:
pkgs.mkShell rec {
  nativeBuildInputs = [
    pkgs.pkg-config
  ];
  buildInputs = with pkgs;
    [
      rustToolchain
      libxkbcommon
    ]
    ++ extraPackages;
  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;
}
