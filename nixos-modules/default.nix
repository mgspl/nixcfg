{
  inputs,
  lib,
  modulesPath,
  pkgs,
  ...
}: {
  imports = [
    ./catppuccin.nix
    ./chaotic.nix
    ./gamemode.nix
    ./graphics.nix
    ./lix.nix
    ./maomaowm.nix
    ./nh.nix
    ./openrgb.nix
    ./polkit.nix
    ./performance.nix
    ./scx.nix
    ./steam.nix
    ./uwsm.nix
    ../packages
  ];

  boot = {
    tmp.cleanOnBoot = true;
    kernelPackages = pkgs.linuxPackages_cachyos-lto;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "pcie_aspm=off"
      "plymouth.use-simpledrm"
      "i915.enable_guc=2"
    ];
    loader = {
      timeout = 0;
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
      };
    };
    plymouth = {enable = true;};
    initrd.systemd = {
      enable = true;
      extraConfig = ''
        DefaultTimeoutStartSec=15s
                             DefaultTimeoutStopSec=10s
                             DefaultLimitNOFILE=2048:2097152'';
    };
  };

  catppuccin.plymouth.enable = true;

  networking = {
    hostFiles = [
      (pkgs.fetchurl {
        url = "https://hblock.molinero.dev/hosts";
        hash = "sha256-X3athYnwGKiyPRGYt6I0mvIXKr63wXmUFzcGZmiVIPY=";
      })
    ];
    networkmanager = {
      enable = true;
      wifi = {
        backend = "wpa_supplicant";
        powersave = false;
      };
    };
  };
  # Um mano no reddit diz que isso faz conectar em wifi enterprise
  systemd.services.wpa_supplicant.environment.OPENSSL_CONF = pkgs.writeText "openssl.cnf" ''
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

  time.timeZone = "America/Sao_Paulo";

  i18n.defaultLocale = "pt_BR.UTF-8";
  console = {
    font = "${pkgs.kbd}/share/consolefonts/Lat2-Terminus16.psfu.gz";
    # keyMap = "br";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Configure keymap in X11
  services = {
    xserver = {
      xkb.layout = "br";
      exportConfiguration = true;
    };
    gvfs.enable = true;
    upower.enable = true;
    power-profiles-daemon.enable = true;
    gnome = {gnome-keyring.enable = true;};
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    fstrim = {
      enable = true;
      interval = "weekly"; # the default
    };
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam.services.swaylock = {};
  };

  programs.dconf.enable = true;

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
      trusted-users = ["@wheel"];
      max-jobs = 8;
    };
  };

  nixpkgs.config.permittedInsecurePackages = ["mono-5.20.1.34"]; # Allow unfree
  nixpkgs.config.allowUnfree = true;
  # Nix
  documentation.nixos.enable = false;

  # Comment in installation, manually create a user
  users.users.miguel = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "video"];
    description = "Miguel";
  };

  environment.pathsToLink = ["/share/bash-completion"];

  environment.systemPackages = with pkgs; [git wl-clipboard];

  # Enable App Armor
  security.apparmor = {
    enable = true;
    killUnconfinedConfinables = true;
  };

  # Disable coredump
  systemd.coredump.enable = false;

  # kde connect
  networking.firewall = rec {
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = allowedTCPPortRanges;
    allowedTCPPorts = [5555];
  };

  system.stateVersion = "23.11";
}
