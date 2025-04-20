{config, pkgs, lib, ... }:

environment.extraInit = ''
  export PATH="$HOME/.local/bin:$PATH"
'';
}
