{ pkgs, ... }: {
  home.packages = with pkgs; [ swaybg autotiling wlogout ];

  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;

    checkConfig = false;

    wrapperFeatures.gtk = true;

    config = {
      modifier = "Mod4";

      bars = [ ];

      gaps = {
        outer = 5;
        inner = 3;
        smartBorders = "on";
        smartGaps = true;
      };

      window = { hideEdgeBorders = "smart"; };

      focus = { followMouse = "always"; };

      input = {
        "type:keyboard" = { xkb_layout = "br"; };
        "type:touchpad" = {
          left_handed = "disabled";
          tap = "enabled";
          natural_scroll = "enabled";
          dwt = "enabled";
          accel_profile = "flat";
          pointer_accel = "0.5";
        };
        "type:pointer" = { natural_scroll = "enabled"; };
      };

      output = {
        "*" = { background = "~/nixcfg/assets/wallpaper.png fill"; };
        "eDP-1" = { pos = "1920 0"; };
        "HDMI-A-1" = { pos = "0 0"; };
      };

      startup = [
        { command = "uwsm finalize"; }
        { command = "uwsm app -- waybar"; }
        { command = "openrgb -c 89b4fa"; }
        { command = "uwsm app -- clipse -listen"; }
        { command = "uwsm app -- gsr-ui"; }
      ];

      keybindings = let
        mod = "Mod4";
        term = "kitty";
        app-menu = "fuzzel";
        browser = "firedragon";
        file-manager = "nautilus";
      in {
        "${mod}+q" = "kill";

        "${mod}+w" = "exec uwsm-app ${browser}";
        "${mod}+e" = "exec uwsm-app ${file-manager}";
        "${mod}+r" = "exec uwsm-app ${app-menu}";
        "${mod}+t" = "exec uwsm-app ${term}";

        "${mod}+Shift+c" = "reload";

        "Print" =
          "exec wayfreeze --after-freeze-cmd 'grim -g \"$(slurp)\" $(xdg-user-dir PICTURES)/$(date +%Y-%m-%d_%H-%m-%s).png; killall wayfreeze'";

        "${mod}+m" = "exec wlogout --protocol layer-shell";

        "${mod}+f" = "fullscreen";
        "${mod}+v" = "floating toggle";

        # Move your focus around
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        # Move the focused window with the same, but add Shift
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";

        # Switch to workspace
        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";
        "${mod}+8" = "workspace number 8";
        "${mod}+9" = "workspace number 9";
        "${mod}+0" = "workspace number 10";
        # Move focused container to workspace
        "${mod}+Shift+1" = "move container to workspace number 1";
        "${mod}+Shift+2" = "move container to workspace number 2";
        "${mod}+Shift+3" = "move container to workspace number 3";
        "${mod}+Shift+4" = "move container to workspace number 4";
        "${mod}+Shift+5" = "move container to workspace number 5";
        "${mod}+Shift+6" = "move container to workspace number 6";
        "${mod}+Shift+7" = "move container to workspace number 7";
        "${mod}+Shift+8" = "move container to workspace number 8";
        "${mod}+Shift+9" = "move container to workspace number 9";
        "${mod}+Shift+0" = "move container to workspace number 10";

        # Scratchpad:
        "${mod}+i" = "move scratchpad";
        "${mod}+s" = "scratchpad show";

        # Audio
        "XF86AudioRaiseVolume" = "exec set-volume inc 1";
        "XF86AudioLowerVolume" = "exec set-volume dec 1";
        "XF86AudioMute" = "exec set-volume toggle-mute";
        "XF86AudioStop" = "exec ${pkgs.playerctl}/bin/playerctl stop";
        "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";
        "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
        "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";

        # Brightness
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
      };
    };

    # SwayFX settings
    extraConfig = ''
      default_border pixel 3
      corner_radius 8
      smart_corner_radius enable
      shadows enable
      shadows_on_csd disable
      shadow_blur_radius 3
      shadow_color #89b4fa7F
      shadow_offset 2 2
      shadow_inactive_color #1e1e2e7F
      titlebar_separator enable
    '';
  };
}
