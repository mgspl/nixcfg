{pkgs, ...}: {

    catppuccin.fuzzel = {
    enable = true;
    flavor = "mocha";
    accent = "blue";
  };
  

  programs.fuzzel = {
    enable = true;

    settings = {
      main = {
        terminal = "${pkgs.kitty}/bin/kitty";
        font = "UbuntuMono Nerd Font:size=16";
        prompt = " : ";
        icon-theme = "Colloid-Catppuccin-Dark";
        filter-desktop = true;
        #launch-prefix = "uwsm app -- ";
        dpi-aware = "yes";
      };
    };
  };
}
