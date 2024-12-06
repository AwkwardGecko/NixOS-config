let
  aagl-gtk-on-nix = import (
    builtins.fetchTarball "https://github.com/ezKEa/aagl-gtk-on-nix/archive/main.tar.gz"
  );
in
{
  home.packages = [ aagl-gtk-on-nix.the-honkers-railway-launcher ];
}
