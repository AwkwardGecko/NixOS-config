{ config, lib, pkgs, ... }:
{
  home-manager.users.zozano = {
    programs.rclone = {
      enable = true;
      remotes.proton = {
        config.type = "protondrive";
        # secrets = # check ~/.dotfiles/modules/core/security.nix
      };
    };
  };
}
