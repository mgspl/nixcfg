{ config, pkgs, ... }:
{
  # nvidia
  hardware.opengl = {
    enable = true;
    driSupport = true;
    extraPackages = [
      pkgs.vaapiIntel
      pkgs.intel-media-driver
    ];
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
      nvidiaBusId = "PCI:1:0:0";
      intelBusId = "PCI:0:2:0";
    };

    modesetting.enable = true;

    powerManagement = {
      enable = false;
    };

    open = false;
    nvidiaSettings = false; # gui app
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
