{
  config,
  pkgs,
  ...
}: {
  # Firmware
  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;

  services.fwupd = {
    enable = true;
    daemonSettings.EspLocation = config.boot.loader.efi.efiSysMountPoint;
  };

  # nvidia
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      vaapiVdpau
      libvdpau-va-gl
      intel-media-sdk
    ];
  };

  environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";};

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
      nvidiaBusId = "PCI:1:0:0";
      intelBusId = "PCI:0:2:0";
    };

    modesetting.enable = true;

    powerManagement = {enable = false;};

    open = false;
    nvidiaSettings = false; # gui app
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };
}
