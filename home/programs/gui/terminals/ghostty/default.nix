{
  programs.ghostty = {
    enable = true;

    enableBashIntegration = true;

    settings = {
      theme = "catppuccin-mocha";
      cursor-style = "bar";
      gtk-titlebar = false;

      window-save-state = "always";

      font-family = "UbuntuMono Nerd Font";
      font-size = 14;
    };
  };
}
