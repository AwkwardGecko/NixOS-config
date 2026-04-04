{
  config,
  lib,
  pkgs,
  ...
}: {
  home-manager.users.zozano.wayland.windowManager.hyprland.settings = {
    general.layout = "master";
    master = {
      allow_small_split = false; # enable adding additional master windows in a horizontal split style
      special_scale_factor = 1; #the scale of the special workspace windows. [0.0 - 1.0]
      mfact = 0.5; #the size as a percentage of the master window, for example mfact = 0.70 would mean 70% of the screen will be the master window, and 30% the slave [0.0 - 1.0] 
      new_status = false; # master: new window becomes master; slave: new windows are added to slave stack; inherit: inherit from focused window 
      new_on_top = false;
      new_on_active = "none";
      orientation = "left";
      slave_count_for_center_master = 2;
      center_master_fallback = "left";
      smart_resizing = true;
      drop_at_cursor = true;
      always_keep_position = false;
    };
  };
}
