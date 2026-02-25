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
      };
    };
  };
}
