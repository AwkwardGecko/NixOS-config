{
  config,
  lib,
  pkgs,
  ...
}: {
  home-manager.users.zozano = {
    home.file.".local/bin/mount-models.sh" = {
      text = ''
        #!/usr/bin/env bash
        sudo mount /dev/disk/by-uuid/ab4e76c1-c09a-4ee7-b61b-26bf469aebd9 /5tb-hdd
        sleep 10
        sudo mount /5tb-hdd/models ~/.local/share/ComfyUI/models
      '';
      executable = true;
    };

    xdg.desktopEntries."comfyui-mount-models" = {
      name = "ComfyUI Mount Models";
      genericName = "Utility";
      comment = "mounts the models directory on the 5tb to the ComfyUI model directory";
      exec = ".local/bin/mount-models.sh";
      icon = "utilities-terminal";
      type = "Application";
      categories = ["Utility"];
    };
  };
}
