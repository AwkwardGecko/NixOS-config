{ config, libs, pkgs, ... }:

{
  boot.kernel.sysctl = {
    "vm.nr_hugepages" = 512;  # Set this to the number of huge pages you want
  };

  boot.kernelParams = [
    "hugepagesz=1G"
    "hugepages=4"
    "transparent_hugepage=always"
  ];

  boot.kernelModules = [
    "msr"
  ];

  users.users.zozano.extraGroups = [ "msr" ];

}
