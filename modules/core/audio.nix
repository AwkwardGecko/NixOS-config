{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    alsa-lib
  ];
  security.rtkit.enable = true;
  services.pipewire = {

    enable = true;
    pulse.enable = true;
    audio.enable = true;
    alsa.enable = true;
    #alsa.support32Bit = true;
    #jack.enable = true;
  };
}
