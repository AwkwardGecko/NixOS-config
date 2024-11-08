
	##################
	### MOUNT HOME ###
	##################

	{ config, pkgs, lib, modulesPath, ... }:

{
  fileSystems."/steam" =
    { device = "/dev/disk/by-uuid/249c8bec-3ec2-4b89-8618-748cd918d4ba";
      fsType = "btrfs";
    };
}
