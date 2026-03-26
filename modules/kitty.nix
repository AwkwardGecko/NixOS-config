#############
### KITTY ###
#############

{
  config,
  pkgs,
  lib,
  ...
}:
{
  home-manager.users.zozano = {
  # home.packages = with pkgs; [
  #   jetbrains-mono
  # ];

  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    settings = {
      # Shell
      shell = "fish";

      # Look
      #background_opacity = "0.8";
      # background = "#1a1a1a";

      # Cursor
      #cursor_shape = "beam";
      #cursor_blink_interval = 0;

      # Scrollback
      scrollback_lines = 20000;
      scrollback_pager_history_size = 10000;

      # Clipboard / selection
      copy_on_select = "yes";
      strip_trailing_spaces = "smart";

      # Links
      open_url_with = "default";
      detect_urls = "yes";
      url_style = "single";

      # Rendering
      repaint_delay = 10;
      input_delay = 0;
      sync_to_monitor = "yes";
    };

    #font = {
      #name = "JetBrains Mono";
      #name = "JetBrainsMono Nerd Font";
      #size = 12;
    #};

    #themeFile = "GruvboxMaterialDarkMedium";
  };
  };
}
