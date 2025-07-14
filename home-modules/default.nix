{
  ezModules,
  lib,
  inputs,
  ...
}: {
  imports = lib.attrValues {
    inherit
      (ezModules)
      btop
      exportModules
      firefox
      fuzzel
      gammastep
      git
      kanshi
      kitty
      maomaowm
      mpv
      neovim
      packages
      portals
      starship
      swayidle
      swaylock
      swaync
      swayosd
      theme
      valent
      waybar
      wlogout
      ;
  };

  programs.home-manager.enable = true;
}
