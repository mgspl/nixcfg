{
  lib,
  pkgs,
  ...
}: {
  services.kdeconnect = {
    enable = true;
    indicator = true;
    #package = pkgs.valent;
  };

  systemd.user.services = {
    kdeconnect.Unit.After = lib.mkForce ["graphical-session.target"];
    kdeconnect-indicator.Unit.After = lib.mkForce ["graphical-session.target"];
  };
}
