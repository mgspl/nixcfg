{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.strings) optionalString makeBinPath;

  programs = makeBinPath (
    builtins.attrValues {
      inherit
        (pkgs)
        coreutils
        systemd
        power-profiles-daemon
        ;
    }
  );

  startscript = pkgs.writeShellScript "gamemode-start" ''
      export PATH=$PATH:${programs}
      powerprofilesctl set performance
    ${pkgs.libnotify}/bin/notify-send -a 'Modo de Jogo' -i input-gaming 'Modo de Jogo: Ativado'
  '';

  endscript = pkgs.writeShellScript "gamemode-end" ''
    export PATH=$PATH:${programs}
      powerprofilesctl set balanced
      ${pkgs.libnotify}/bin/notify-send -a 'Modo de Jogo' -i input-gaming 'Modo de Jogo: Desativado'
  '';
in {
  programs.gamemode = {
    enable = true;
    enableRenice = false;

    settings = {
      /*
        general = {
        reaper = 30;
        desiredgov = "performance";
        igpu_power_treshhold = -1;
        ioprio = 0;
        softrealtime = "auto";
        renice = 15;
        disable_splitlock = 1;
      };
      */
      custom = {
        start = startscript.outPath;
        end = endscript.outPath;
      };
    };
  };
}
