{
  config,
  lib,
  pkgs,
  ...
}: {
  home-manager.users.zozano = {
    home.file.".local/bin/myscript" = {
      text = ''
        #!/usr/bin/env bash
        echo "hello"
      '';
      executable = true;
    };

    xdg.desktopEntries."my_entry" = {
      name = "My Script";
      genericName = "Utility";
      comment = "does a thing";
      exec = "~/.local/bin/myscript";
      icon = "utilities-terminal";
      type = "Application";
      categories = ["Utility"];
    };
  };
}
