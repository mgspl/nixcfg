{ config, pkgs, inputs, ... }:

{
  # add the home manager module
  imports = [  
    ./hyprland.nix
    ./kitty.nix
    ./ags.nix
    ./theme.nix
    ./packages.nix
  ];

  home.username = "miguel";
  home.homeDirectory = "/home/miguel";
  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.sessionVariables = {
    EDITOR = "lvim";
    TERMINAL = "kitty";
    XDG_SESSION_TYPE  = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    GDK_BACKEND = "wayland";
    QT_AUTO_SCREEN_SCALE_FACTOR = 1;
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_FORCE_DPI = "physical";
    #QT_QPA_PLATFORMTHEME = "qt5ct";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    TERM = "kitty";
    # Run hyprland into iGPU
    WLR_DRM_DEVICES = "/dev/dri/card0:/dev/dri/card1";
  };
  
  # Allow Unfree
  nixpkgs.config.allowUnfree = true;
  # Need this or dont build a new generation
  nix.package = pkgs.nix;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
