# A NixOS module to set up nsxiv with delete-on-keypress and file manager integration
{ config, pkgs, ... }:

let
  wrapperScript = pkgs.writeShellScriptBin "nsxiv-wrapper" ''
    #!/usr/bin/env bash

    file="$1"
    dir="$(dirname "$file")"
    filename="$(basename "$file")"

    # Safely collect images in the directory
    mapfile -t images < <(find "$dir" -maxdepth 1 -type f \(
      -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \
      -o -iname '*.gif' -o -iname '*.webp' \) | sort)

    exec ${pkgs.nsxiv}/bin/nsxiv -n "${images[@]}" -S "$filename"
  '';

  deleteScript = pkgs.writeShellScript "delete_and_next.sh" ''
    #!/usr/bin/env bash
    file="$1"
    [ -f "$file" ] && rm "$file"
  '';

  keyHandlerScript = pkgs.writeShellScript "key-handler" ''
    #!/usr/bin/env bash
    case "$1" in
      Delete|d) ${deleteScript} "$2" ;;
    esac
  '';

  configDir = "/home/${config.users.users.${config.mainUser}.name}/.config/nsxiv";

in {
  options.mainUser = with pkgs.lib; mkOption {
    type = types.str;
    description = "Main user to configure nsxiv for.";
  };

  config = {
    environment.systemPackages = with pkgs; [ nsxiv wrapperScript ];

    systemd.tmpfiles.rules = [
      "d ${configDir}/exec 0755 ${config.mainUser} users - -"
    ];

    # Write the key-handler using home.file if using Home Manager or write directly otherwise
    home.file.".config/nsxiv/exec/key-handler" = {
      text = keyHandlerScript.text;
      executable = true;
      target = "${configDir}/exec/key-handler";
    };
  };
}

