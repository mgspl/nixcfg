{ config, pkgs, ...}:

{
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" ];
        size = "standard";
        variant = "mocha";
        tweaks = [ "rimless" ];
      };
    };

    iconTheme = {
      package = pkgs.morewaita-icon-theme;
      name = "MoreWaita";
    };

  }; 

  home.packages = with pkgs; [ 
    gnome.adwaita-icon-theme 
    (catppuccin-kvantum.override {
      accent = "Blue";
      variant = "Mocha";
    })
  ];
  
  qt = {
    enable = true;
    platformTheme = "qtct";
    style.name = "kvantum";

  };
  
  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
    "Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {General.theme = "Catppuccin-Mocha-Blue";};
  };
}
