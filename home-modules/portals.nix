{ pkgs, inputs, ... }: {
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
    xdgOpenUsePortal = true;
    config = {
      sway = {
        default = [ "gtk" "wlr" ];
        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
      };
      # "org.freedesktop.impl.portal.Screencast" = [ "hyprland" ];
      # "org.freedesktop.impl.portal.Screenshot" = [ "hyprland" ];
      # "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
    };
  };
}
