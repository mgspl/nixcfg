{ lib, ... }:
{
  services.gammastep = {
    enable = true;
    tray = false;

    # stopgap until geoclue's wifi location is fixed
    provider = "manual";
    /* Boc coords
    latitude = -22.674;
    longitude = -48.8273;
    */

    # DV cords
    latitude = -25.7475;
    longitude = -53.091;

    temperature = {
      day = 6499;
      night = 3000;
    };

    enableVerboseLogging = false;

    settings.general.adjustment-method = "wayland";
  };

  systemd.user.services.gammastep.Unit.After = lib.mkForce "graphical-session.target";
}
