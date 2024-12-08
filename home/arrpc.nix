{lib, ...}: 
{
  services.arrpc.enable = true;

  systemd.user.services.arrpc.Unit.After = lib.mkForce "graphical-session.target";
}
