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
      udev
      alsa-lib-with-plugins
      vulkan-loader
      xorg.libX11
      xorg.libXcursor
      xorg.libXi
      xorg.libXrandr # To use the x11 feature
      libxkbcommon
      wayland # To use the wayland feature
    ]
    ++ extraPackages;
  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;
}
