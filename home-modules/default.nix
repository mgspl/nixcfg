{ ezModules, lib, inputs, ... }: {
  imports = lib.attrValues {
    inherit (ezModules)
      btop exportModules firefox fuzzel gammastep git kitty mpv neovim packages
      portals starship swayfx swaylock swaync theme valent waybar;
  };

  programs.home-manager.enable = true;
}
