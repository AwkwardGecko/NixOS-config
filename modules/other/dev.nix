{
  config,
  lib,
  pkgs,
  ...
}: {
  # Set up a global .gitignore to ignore dotfiles
  environment.etc."gitconfig".text = ''
    [core]
      excludesFile = ~/.gitignore_global
  '';

  # Ensure .gitignore_global file exists with the correct pattern
  environment.etc."gitignore_global".source = pkgs.writeText "gitignore_global" ''
    .*
  '';

  home-manager.users.zozano = {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "Zozano";
          email = "private@private.com";
        };
        init.defaultBranch = "main";
      };
      signing.format = "openpgp";
    };
  };

  programs.npm.enable = true;

  environment.systemPackages = with pkgs; [
    cmake
    conda
    crane
    dmidecode
    gcc
    gcc-unwrapped
    git
    gperftools
    icu
    lld
    llvmPackages.bintools
    nodejs
    opencv
    openssl
    pkg-config
    protobuf
    pyenv
    python3
    python312Packages.numpy
    python312Packages.opencv-python
    sqlite
    uv
  ];

  # home-manager.users.zozano = {
  #   home.packages = with pkgs; [
  #     pipx
  #   ];
  # };
}
