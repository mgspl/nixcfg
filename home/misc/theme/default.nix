{
  config,
  pkgs,
  inputs,
  ...
}: {
  gtk = {
    enable = true;
    theme = {
      name = "Colloid-Dark-Catppuccin";
      package = pkgs.colloid-gtk-theme.override {
        themeVariants = ["default"];
        colorVariants = ["dark"];
        sizeVariants = ["standard"];
        tweaks = [
          "catppuccin"
        ];
      };
    };

    iconTheme = {
      name = "Colloid-Catppuccin-Dark";
      package = pkgs.colloid-icon-theme.override {
        schemeVariants = ["catppuccin"];
        colorVariants = ["default"];
      };
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 23;
  };

  /*
    catppuccin.kvantum = {
    enable = true;
    apply = true;
    flavor = "mocha";
    accent = "blue";
  };
  */

  home.packages = with pkgs; [catppuccin-qt5ct lightly-boehs];

  qt = {
    enable = true;
    platformTheme.name = "qtct";
  };

  xdg.enable = true;
  xdg.configFile = let
    package = pkgs.catppuccin-qt5ct;
    name = "Catppuccin-Mocha";
    themeDir = "${package}/share/qt5ct/colors";
    qtctConf = ''
      [Appearance]
      custom_palette=true
      color_scheme_path=${themeDir}/${name}.conf
      icon_theme=Colloid-Catppuccin-Dark
      standard_dialogs=xdgdesktopportal
      style=Lightly
    '';
  in {
    "qt5ct/qt5ct.conf".text = qtctConf;
    "qt6ct/qt6ct.conf".text = qtctConf;
  };

  /*
    xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
    #"Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {General.theme = "Catppuccin-Mocha-Blue";};
  };
  */
}
