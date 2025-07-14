{lib, ...}: {
  services.gammastep = {
    enable = true;
    tray = false;

    # stopgap until geoclue's wifi location is fixed
    provider = "manual";
    latitude = -22.674;
    longitude = -48.8273;

    temperature = {
      day = 6000;
      night = 3000;
    };

    enableVerboseLogging = false;

    settings.general.adjustment-method = "wayland";
  };

  systemd.user.services.gammastep.Unit.After = lib.mkForce "graphical-session.target";
}
