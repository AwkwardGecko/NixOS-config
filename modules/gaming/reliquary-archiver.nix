{ config, lib, pkgs, ... }:
{
  programs.reliquary-archiver = {
  enable = true;
  version = "0.14.0";
  srcHash = lib.fakeHash;  # step 2: replace with real
  gameDataRev = "<latest commit SHA from Dimbreath repo>";
  gameDataHash = lib.fakeHash;  # step 3: replace with real
  cargoOutputHashes = {
    "reliquary-19.0.0" = lib.fakeHash;  # step 4: replace with real
    # uncomment if build complains about these:
    # "raxis-0.1.0" = lib.fakeHash;
    # "self_update-0.42.0" = lib.fakeHash;
  };
};
}
