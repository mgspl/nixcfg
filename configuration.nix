# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./hyprland.nix
      ./nvidia.nix
      ./steam.nix
      ./greeter.nix
      ./ananicy.nix
      ./zram.nix
      ./scx.nix
      ./nh.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    tmp.cleanOnBoot = true;
    kernelPackages = pkgs.linuxPackages_cachyos;
    kernelParams = [ "pcie_aspm=off" "SYSTEMD_CGROUP_ENABLE_LEGACY_FORCE=1" ];
    loader = {
      timeout = 3;
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
      };
    };
    plymouth = {
      enable = true;
    };
  };

  networking = { 
    hostName = "digitalis";
    hostFiles = [ (pkgs.fetchurl {url = "https://hblock.molinero.dev/hosts"; hash = "sha256-Eq1GCKiKOEq2l+7iJMJrf34jyjWUdqqD1xldLyc8aws=";}) ];
    networkmanager.enable = true;  
  };

  # Um mano no reddit diz que isso faz conectar em wifi enterprise 
  systemd.services.wpa_supplicant.environment.OPENSSL_CONF = pkgs.writeText"openssl.cnf"''
    openssl_conf = openssl_init
    [openssl_init]
    ssl_conf = ssl_sect
    [ssl_sect]
    system_default = system_default_sect
    [system_default_sect]
    Options = UnsafeLegacyRenegotiation
    [system_default_sect]
    CipherString = Default:@SECLEVEL=0
  '';

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "pt_BR.UTF-8";
  console = {
     font = "Lat2-Terminus16";
     # keyMap = "br";
     useXkbConfig = true; # use xkb.options in tty.
  };

  # Configure keymap in X11
  services.xserver.xkb.layout = "br";

# Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true; 
    jack.enable = true;
   };


  # bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
  
  # nix configs
  nix = {
    gc = {
      automatic = false;
      dates = "weekly";
      options = "--delete-older-than 3d";
    };
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      substituters = [
        "https://hyprland.cachix.org" 
      ];
      trusted-public-keys = [ 
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" 
      ];
    };
  };

  # Allow unfree 
  nixpkgs.config.allowUnfree = true;
  # Nix
  documentation.nixos.enable = false;


  # Comment in installation, manually create a user
  users.users.miguel = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  environment.pathsToLink = [ "/share/bash-completion" ];

  environment.systemPackages = with pkgs; [
     neovim
     wget
     git
     wl-clipboard
  ];
  
  # Enable TRIM
  services.fstrim = {
    enable = true;
    interval = "weekly"; # the default
  };

  # Enable App Armor 
  security.apparmor = {
    enable = true;
    killUnconfinedConfinables = true;
  };

  # Disable coredump
  systemd.coredump.enable = false;

  # kde connect
  networking.firewall = rec {
    allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

  system.stateVersion = "23.11"; 
}
