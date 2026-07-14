#############
### KITTY ###
#############
{
  config,
  pkgs,
  lib,
  ...
}: {
  home-manager.users.zozano = {
    # home.packages = with pkgs; [
    #   jetbrains-mono
    # ];

    programs.kitty = {
      enable = true;
      shellIntegration.enableFishIntegration = true;

      font = {
        name = "JetBrainsMono Nerd Font";
        size = 11;
        package = pkgs.nerd-fonts.jetbrains-mono;
      };

      settings = {
        shell = "fish";

        scrollback_lines = 20000;
        scrollback_pager_history_size = 10000;

        copy_on_select = "yes";
        strip_trailing_spaces = "smart";

        open_url_with = "default";
        detect_urls = "yes";
        url_style = "single";

        repaint_delay = 10;
        input_delay = 0;
        sync_to_monitor = "yes";
      };

      #themeFile = "GruvboxMaterialDarkMedium";
    };
  };
}
