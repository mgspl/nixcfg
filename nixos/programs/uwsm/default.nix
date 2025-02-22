{
  pkgs,
  config,
  lib,
  username,
  ...
}: {
  services.greetd = let
    session = {
      command = "${lib.getExe config.programs.uwsm.package} start hyprland-uwsm.desktop";
      user = "${username}";
    };
  in {
    enable = true;
    settings = {
      terminal.vt = 1;
      default_session = session;
      initial_session = session;
    };
  };

  programs.regreet = {
    enable = false;

    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };

    iconTheme = {
      name = "Colloid-Catppuccin-Dark";
      package = pkgs.colloid-icon-theme.override {
        schemeVariants = ["catppuccin"];
        colorVariants = ["default"];
      };
    };

    theme = {
      name = "Colloid-Dark-Catppuccin";
      package = pkgs.colloid-gtk-theme.override {
        themeVariants = ["default"];
        colorVariants = ["dark"];
        sizeVariants = ["standard"];
        tweaks = [
          "catppuccin"
          "rimless"
        ];
      };
    };

    cageArgs = [
      "-s"
      "-m"
      "last"
    ];
  };

  systemd.tmpfiles.rules = [
    "d /var/log/regreet 0755 greeter greeter - -"
    "d /var/cache/regreet 0755 greeter greeter - -"
  ];

  #programs.uwsm = {
  #  enable = false;
  #  waylandCompositors.hyprland = {
  #    binPath = "/run/current-system/sw/bin/Hyprland";
  #    prettyName = "Hyprland";
  #    comment = "Hyprland managed by UWSM";
  #  };
  #};
}
