{
  description = "Ceedrich Templates";

  outputs = {...} : {
    templates = {
      rust = {
        path = ./rust;
        description = "A rust template";
      };
    };
  };
}
