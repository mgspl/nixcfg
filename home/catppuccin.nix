{ config, inputs, pkgs, ...}:
{
  gtk = {
    enable = true;
    theme = {
      name = "Colloid-Dark-Catppuccin";
      package = pkgs.colloid-gtk-theme.override {
        themeVariants = [ "default" ];
        colorVariants = [ "dark" ];
        sizeVariants =  [ "standard" ];
        tweaks = [ "catppuccin" "rimless" ];
      };
    };

    iconTheme = {
      name = "Colloid-Catppuccin-Dark";
      package = pkgs.colloid-icon-theme.override {
        schemeVariants = [ "catppuccin" ];
        colorVariants = [ "default" ];
      };
    };
  };
  
  
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
    style.catppuccin = {
      enable = true;
      accent = "blue";
      flavor = "mocha";
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };
  
  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
    #"Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {General.theme = "Catppuccin-Mocha-Blue";};
  };

}
