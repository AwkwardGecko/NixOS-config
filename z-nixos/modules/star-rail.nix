{ config, lib, pkgs, ... }:
let
  flatpakBin = "${pkgs.flatpak}/bin/flatpak";
  mkdirBin = "${pkgs.coreutils}/bin/mkdir";
  gamePath = "/steam/Honkai-Star-Rail";
in
{
  services.flatpak.enable = true;

  # Make flatpak available in system PATH during activation scripts
  environment.systemPackages = with pkgs; [
    flatpak
  ];

  system.activationScripts.addFlathubRemote.text = ''
    echo "Creating game directories in ${gamePath}..."
    ${mkdirBin} -p "${gamePath}/prefix" "${gamePath}/game" "${gamePath}/temp"

    echo "Granting Flatpak override permissions for ${gamePath}..."
    ${flatpakBin} override --filesystem=${gamePath} moe.launcher.the-honkers-railway-launcher

    if ! ${flatpakBin} remote-list | grep -q '^flathub'; then
      echo "Adding Flathub remote..."
      ${flatpakBin} remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    fi

    if ! ${flatpakBin} remote-list --user | grep -q '^launcher.moe'; then
      echo "Adding Honkai: Star Rail repository..."
      ${flatpakBin} remote-add --if-not-exists --user launcher.moe https://gol.launcher.moe/gol.launcher.moe.flatpakrepo
    fi

    echo "Installing Gnome platform..."
    ${flatpakBin} install -y org.gnome.Platform//47

    echo "Installing Honkai: Star Rail..."
    ${flatpakBin} install -y launcher.moe moe.launcher.the-honkers-railway-launcher
  '';
}

