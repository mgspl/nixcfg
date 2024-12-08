{ config, pkgs, inputs, ... }:
{
  # add the home manager module
  imports = [
    ./home/hyprland.nix
    ./home/hyprlock.nix
    ./home/hypridle.nix
    ./home/packages.nix
    ./home/portals.nix
    ./home/kitty.nix
    ./home/starship.nix
    ./home/catppuccin.nix
    ./home/btop.nix
    ./home/mpv.nix
    ./home/rofi.nix
    ./home/kdeconnect.nix
    ./home/arrpc.nix
    #./home/nvim.nix
  ];

  home.username = "miguel";
  home.homeDirectory = "/home/miguel";
  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
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
    GSK_RENDERER = "ngl";
  };
  # enable bash
  programs.bash = {
    enable = true;
    sessionVariables = {
      EDITOR = "lvim";
      TERMINAL = "kitty";
      TERM = "kitty";
    };
  };
  
  # Allow Unfree
 # nixpkgs.config.allowUnfree = true;
  # Need this or dont build a new generation
  #nix.package = pkgs.nix;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
