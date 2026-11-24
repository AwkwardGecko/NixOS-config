{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    firefox
    geckodriver

    (python3.withPackages (ps:
      with ps; [
        selenium
        beautifulsoup4
        openpyxl
      ]))
  ];
}
