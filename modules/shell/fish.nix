############
### FISH ###
############

{
  config,
  pkgs,
  lib,
  ...
}:
{
  home-manager.users.zozano = {
    programs.fish = {
      enable = true;
      shellAbbrs = {
        #update-nix = "kitty bash /home/zozano/.dotfiles/home-manager/source/local/share/applications/update.sh";
        #server-connect = "kitty ssh -t z-home@192.168.1.157 'fish -l'";
      #};
      #shellAbbrs = {
        update = "bash ~/.dotfiles/system-update.sh";
      };
      shellInit = "cd ~/.dotfiles/";
      shellInitLast = "fastfetch";
      plugins = [
        {
          name = "gruvbox";
          src = pkgs.fishPlugins.gruvbox.src;
        }
        {
          name = "grc";
          src = pkgs.fishPlugins.grc.src;
        }
      ];
    };
  };
}
