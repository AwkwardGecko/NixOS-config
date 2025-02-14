[ pkgs, lib, config ]:

{
  environment.systemPackages = [
    python312Packages.openai-whisper
  ];
}
