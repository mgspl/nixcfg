{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.ironbar = {
    enable = true;
    config = let
      workspaces = {
        type = "workspaces";
        all_monitors = true;
        hidden = ["special"];
        name_map = let
          workspaces = lib.genAttrs (
            map (n: builtins.toString n) [
              1
              2
              3
              4
              5
              6
              7
              8
              9
              10
            ]
          );
        in
          workspaces (
            i:
              if i == "1"
              then "●"
              else if i == "2"
              then "●"
              else if i == "3"
              then "●"
              else if i == "4"
              then "●"
              else if i == "5"
              then "●"
              else if i == "6"
              then "●"
              else if i == "7"
              then "●"
              else if i == "8"
              then "●"
              else if i == "9"
              then "●"
              else if i == "10"
              then "●"
              else "●"
          );
      };

      music = {
        type = "music";
        player_type = "mpris";
        format = "{title}  {artist}";
        truncate.mode = "start";
        truncate.max_length = 100;
        #icons.play = "icon:media-playback-start";
        #icons.pause = "icon:media-playback-pause";
        show_status_icon = false;
        icon_size = 20;
        cover_image_size = 128;
      };

      focused = {
        type = "focused";
        truncate.mode = "end";
        truncate.max_length = 100;
        icon_size = 20;
      };

      battery = {
        type = "upower";
        format = "{percentage}%";
      };

      tray = {
        type = "tray";
        icon_size = 20; # Evitar icones embaçados
      };

      notification = {
        type = "notifications";
      };

      clock = {
        type = "clock";
        format = "%H:%M";
      };

      volume = {
        type = "volume";
        format = "{icon} {percentage}%";
      };

      dash = rec {
        type = "custom";
        name = "nix-launcher";
        class = name;
        bar = [
          {
            type = "button";
            label = "";
            on_click = "popup:toggle";
          }
        ];
        popup = [
          {
            type = "box";
            orientation = "v";
            widgets = [
              #{
              #  type = "label";
              #  label = "{{${pkgs.macchina}/bin/macchina}}";
              #}
              {
                type = "box";
                widgets = [
                  {
                    type = "button";
                    label = "󱗼 Applications";
                    on_click = "!${pkgs.fuzzel}/bin/fuzzel";
                  }
                  {
                    type = "button";
                    label = "󰕾 Sound";
                    on_click = "!${pkgs.pwvucontrol}/bin/pwvucontrol";
                  }
                  {
                    type = "button";
                    label = "󰐥 Power";
                    on_click = "!${pkgs.nwg-bar}/bin/nwg-bar";
                  }
                ];
              }
            ];
          }
        ];
      };

      left = [
        dash
        workspaces
        focused
      ];
      right = [
        tray
        clock
        notification
        battery
        volume
      ];
      center = [
        music
      ];
    in {
      anchor_to_edges = true;
      position = "top";
      start = left;
      end = right;
      center = center;
      #center = [
      #  {
      #    type = "label";
      #    label = "random num: {{500:playerctl metadata mpris:artUrl}}";
      #  }
      #];
      height = 32;
      icon_theme = config.gtk.iconTheme.name;
    };
    style = let
      built = pkgs.callPackage ./scss-pkg.nix {
        src = ./styles;
        entry = "main";
      };
    in ''
      @import url("${built}/out.css");
    '';
  };

  home.packages = with pkgs; [
    syshud
    nwg-bar
    libdbusmenu
  ];
}
