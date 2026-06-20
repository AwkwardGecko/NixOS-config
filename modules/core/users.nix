{
  config,
  pkgs,
  lib,
  ...
}: {
  users.users.zozano = {
    isNormalUser = true;
    description = "zozano";
    extraGroups = [
      "networkmanager"
      "wheel"
      "gamemode"
      "docker"
      "input"
      "uinput"
    ];
  };
}
