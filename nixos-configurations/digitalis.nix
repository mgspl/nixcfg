{ config, lib, pkgs, modulesPath, ... }: {
  networking.hostName = "digitalis";
  
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ]; boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ]; 
  boot.initrd.kernelModules = [ ]; boot.kernelModules = [ "kvm-intel" ]; boot.extraModulePackages = [ ]; fileSystems."/" =
    { device = "/dev/disk/by-uuid/87d15d4e-e3d2-4371-81f4-956e1f15129c"; fsType = "ext4";
    };
  swapDevices = [ ];
  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking (the default) this is the recommended approach. When using 
  # systemd-networkd it's still possible to use this option, but it's recommended to use it in conjunction with explicit per-interface declarations with 
  # `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp1s0.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
