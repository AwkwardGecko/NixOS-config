{
  config,
  pkgs,
  lib,
  ...
}: {
  users.users = {
    zozano = {
      isNormalUser = true;
      description = "zozano";
      extraGroups = [
        "networkmanager"
        "wheel"
        "gamemode"
        "docker"
        "input"
        "uinput"
        "video"
        "audio"
        "ydotool"
      ];
    };
    leo = {
      isNormalUser = true;
      description = "leo";
      initialPassword = "changeme";
      extraGroups = [
        "networkmanager"
        "video"
        "input"
        "wheel"
        "audio"
      ];
    };
  };
}
