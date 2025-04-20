{ config, pkgs, lib, ... }:

{

  programs.feh = {
    enable = true;
    keybindings = {
      zoom_in = "mousewheel up";
      zoom_out = "mousewheel down";
      prev_img = "Left";
      next_img = "Right";
    };



  };


}
