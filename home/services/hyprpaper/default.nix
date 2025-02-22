{lib, ...}: {
  services.hyprpaper = {
    enable = true;

    settings = {
      ipc = "on";
      splash = false;

      preload = ["~/.config/hypr/wallpaper.png"];

      wallpaper = [", ~/.config/hypr/wallpaper.png"];
    };
  };

  systemd.user.services.hyprpaper.Unit.After = lib.mkForce "graphical-session.target";
}
