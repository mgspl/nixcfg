{
  home = {
    username = "miguel";
    homeDirectory = "/home/miguel";
    stateVersion = "23.05";

    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      EDITOR = "nvim";
      TERMINAL = "kitty";
      #XDG_SESSION_TYPE = "wayland";
      #XDG_CURRENT_DESKTOP = "Hyprland";
      #XDG_SESSION_DESKTOP = "Hyprland";
      GDK_BACKEND = "wayland";
      QT_AUTO_SCREEN_SCALE_FACTOR = 1;
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_FORCE_DPI = "physical";
      #QT_QPA_PLATFORMTHEME = "qt5ct";
      SDL_VIDEODRIVER = "wayland,x11";
      CLUTTER_BACKEND = "wayland";
      TERM = "kitty";
      GSK_RENDERER = "ngl";
    };
  };

  programs.bash = {
    enable = true;
    sessionVariables = {
      EDITOR = "nvim";
      TERMINAL = "kitty";
      TERM = "kitty";
    };
  };

  # Allow Unfree
  nixpkgs.config.allowUnfree = true;
  # Need this or dont build a new generation
  #nix.package = pkgs.nix;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
