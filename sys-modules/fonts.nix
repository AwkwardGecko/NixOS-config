{
  config,
  pkgs,
  lib,
  ...
}:
{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [

      dejavu_fonts
      fira-code
      fira-code-symbols
      font-awesome
      nerd-fonts.symbols-only
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf

      # Optional alternates if you want variety:
      #nerd-fonts.hack
      #nerd-fonts.terminess-ttf
      #nerd-fonts.caskaydia-cove
      #nerd-fonts.ubuntu-mono

      # Old and duplicate stuff — safe to nuke unless you’re *using* them:
      #liberation_ttf
      #mplus-outline-fonts.githubRelease
      #nerd-fonts.zed-mono
      #nerd-fonts.victor-mono
      #nerd-fonts.ubuntu-sans
      #nerd-fonts.ubuntu
      #nerd-fonts.tinos
      #nerd-fonts.space-mono
      #nerd-fonts.shure-tech-mono
      #nerd-fonts.sauce-code-pro
      #nerd-fonts.roboto-mono
      #nerd-fonts.recursive-mono
      #nerd-fonts.proggy-clean-tt
      #nerd-fonts.profont
      #nerd-fonts.overpass
      #nerd-fonts.open-dyslexic
      #nerd-fonts.mplus
      #nerd-fonts.mononoki
      #nerd-fonts.monoid
      #nerd-fonts.monofur
      #nerd-fonts.monaspace
      #nerd-fonts.meslo-lg
      #nerd-fonts.martian-mono
      #nerd-fonts.lilex
      #nerd-fonts.liberation
      #nerd-fonts.lekton
      #nerd-fonts.iosevka-term-slab
      #nerd-fonts.iosevka-term
      #nerd-fonts.intone-mono
      #nerd-fonts.inconsolata-lgc
      #nerd-fonts.inconsolata-go
      #nerd-fonts.inconsolata
      #nerd-fonts.im-writing
      #nerd-fonts.hurmit
      #nerd-fonts.heavy-data
      #nerd-fonts.hasklug
      #nerd-fonts.gohufont
      #nerd-fonts.go-mono
      #nerd-fonts.geist-mono
      #nerd-fonts.fira-mono
      #nerd-fonts.fira-code
      #nerd-fonts.fantasque-sans-mono
      #nerd-fonts.envy-code-r
      #nerd-fonts.droid-sans-mono
      #nerd-fonts.departure-mono
      #nerd-fonts.dejavu-sans-mono
      #nerd-fonts.daddy-time-mono
      #nerd-fonts.d2coding
      #nerd-fonts.cousine
      #nerd-fonts.commit-mono
      #nerd-fonts.comic-shanns-mono
      #nerd-fonts.code-new-roman
      #nerd-fonts.caskaydia-mono
      #nerd-fonts.blex-mono
      #nerd-fonts.bitstream-vera-sans-mono
      #nerd-fonts.bigblue-terminal
      #nerd-fonts.aurulent-sans-mono
      #nerd-fonts.arimo
      #nerd-fonts.anonymice
      #nerd-fonts.agave
      #nerd-fonts._3270
      #nerd-fonts._0xproto

      #proggyfonts
      #gyre-fonts
      #dina-font
      #ipafont
      #noto-fonts-extra
      #ubuntu_font_famly
      #vazir-fonts
    ];

    fontconfig = {
      enable = true;
      cache32Bit = true;
      allowBitmaps = false;
      useEmbeddedBitmaps = false;
      hinting.enable = true;
      hinting.style = "slight";
      #subpixelRendering = "rgb";
    };
  };
}
