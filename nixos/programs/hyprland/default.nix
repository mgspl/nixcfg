{
  inputs,
  pkgs,
  ...
}: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    withUWSM = true;
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = ["gtk"];
      hyprland.default = ["hyprland"];
    };
    extraPortals = [pkgs.xdg-desktop-portal-gtk inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland];
  };

  security = {
    polkit.enable = true;
  };

  services = {
    gvfs.enable = true;
    #udisks2.enable = true;
    upower.enable = true;
    power-profiles-daemon.enable = true;
    gnome = {
      gnome-keyring.enable = true;
    };
  };
}
