{pkgs, ...}: let
  pythonEnv = pkgs.python3.withPackages (ps:
    with ps; [
      selenium
      beautifulsoup4
      openpyxl
    ]);
in {
  environment.systemPackages = [
    pkgs.firefox
    pkgs.geckodriver

    (pkgs.writeShellScriptBin "mega-python" ''
      exec ${pythonEnv}/bin/python3 "$@"
    '')
  ];
}
