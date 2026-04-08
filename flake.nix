{
  description = "Some commonly used flake templates";

  outputs = inputs: {
    templates = {
      bevy = {
        path = ./bevy;
        description = "Bevy template";
      };
      rust = {
        path = ./rust;
        description = "Rust template";
        welcomeText = ''
          # Simple Rust template
          Edit the `name` to match your project's name and add `buildInputs` and `nativeBuildInputs` if needed.

          ## Usage
          Develop normally with `cargo`. Nix builds are cached using [naersk](github.com/nix-community/naersk).

          ## Getting started
          Run `cargo init` and commit your files to start programming 🦀.
        '';
      };
    };
  };
}
