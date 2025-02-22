{ lib, ... }:
{
  services.arrpc.enable = false;

  systemd.user.services.arrpc.Unit.After = lib.mkForce "graphical-session.target";
}
