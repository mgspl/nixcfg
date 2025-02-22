{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  inherit (lib.strings) optionalString makeBinPath;

  programs = makeBinPath (
    builtins.attrValues {
      inherit
        (pkgs)
        hyprland
        coreutils
        systemd
        power-profiles-daemon
        ;
    }
  );

  startscript = pkgs.writeShellScript "gamemode-start" ''
      export PATH=$PATH:${programs}
      export HYPRLAND_INSTANCE_SIGNATURE=$(ls -w1 /tmp/hypr | tail -1)
      hyprctl --batch 'keyword animations:enabled 0 ; keyword misc:vfr 0; keyword general:gaps_in 0; keywors general:gaps_out 0; keyword decoration:rounding 0; keyword decoration:blur:enabled 0; keyword decoration:shadow:enabled 0'
      powerprofilesctl set performance
      gsr-ui-cli toggle-replay

    ${pkgs.libnotify}/bin/notify-send -a 'Modo de Jogo' -i input-gaming 'Modo de Jogo: Ativado'
  '';

  endscript = pkgs.writeShellScript "gamemode-end" ''
    export PATH=$PATH:${programs}
      export HYPRLAND_INSTANCE_SIGNATURE=$(ls -w1 /tmp/hypr | tail -1)
      hyprctl --batch 'keyword animations:enabled 1; keyword misc:vfr 1; keyword general:gaps_in 3; keywors general:gaps_out 5; keyword decoration:rounding 6; keyword decoration:blur:enabled 1; keyword decoration:shadow:enabled 1'
      powerprofilesctl set balanced
      gsr-ui-cli toggle-replay

      ${pkgs.libnotify}/bin/notify-send -a 'Modo de Jogo' -i input-gaming 'Modo de Jogo: Desativado'
  '';
in {
  programs.gamemode = {
    enable = true;
    enableRenice = false;

    settings = {
      general = {
        reaper = 30;
        desiredgov = "performance";
        igpu_power_treshhold = -1;
        ioprio = 0;
        softrealtime = "auto";
        renice = 15;
        disable_splitlock = 0;
      };
      custom = {
        start = startscript.outPath;
        end = endscript.outPath;
      };
    };
  };
}
