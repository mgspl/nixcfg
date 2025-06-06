{
  catppuccin.kitty = {
    enable = true;
    flavor = "mocha";
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "UbuntuMono Nerd Font";
      size = 14;
    };

    settings = {
      confirm_os_window_close = 0;
      tab_bar_min_tabs = 2;
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
      active_tab_background = "#89b4fa";
    };
  };
}
