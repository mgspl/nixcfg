{
  inputs,
  pkgs,
  lib,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

    systemd.enable = false;

    extraConfig = ''
      source = ~/.config/hypr/monitors.conf
    '';

    settings = {
      "$mainMod" = "SUPER";
      exec-once = [
        "uwsm finalize"
        "openrgb -c 89b4fa"
        "uwsm app -- waybar"
        "hyprctl setcursor Bibata-Modern-Ice 24"
        "uwsm app -- clipse -listen"
        "uwsm app -- syshud -p bottom -o h -t 4s -T 3s"
        "uwsm app -- gsr-ui"
      ];

      general = {
        gaps_in = 3;
        gaps_out = 5;
        border_size = 3;
        layout = "dwindle";
        allow_tearing = true;
        "col.active_border" = "rgb(89b4fa)";
        "col.inactive_border" = "rgb(bac2de)";
      };

      dwindle = {
        force_split = 0;
        special_scale_factor = 0.8;
        split_width_multiplier = 1.0;
        use_active_for_splits = true;
        pseudotile = "yes";
        preserve_split = "yes";
      };

      misc = {
        disable_hyprland_logo = true;
        always_follow_on_dnd = true;
        layers_hog_keyboard_focus = true;
        animate_manual_resizes = true;
        enable_swallow = true;
        focus_on_activate = true;
        vfr = true;
      };

      opengl = {
        nvidia_anti_flicker = false;
      };

      render = {
        direct_scanout = true;
      };

      xwayland = {
        enabled = true;
        force_zero_scaling = true;
      };

      input = {
        kb_layout = "br";
        accel_profile = "adaptive";
        follow_mouse = 1;
        mouse_refocus = false;
        float_switch_override_focus = 2;
        natural_scroll = "yes";
        touchpad = {
          natural_scroll = "yes";
        };
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
        workspace_swipe_distance = 250;
        workspace_swipe_invert = true;
        workspace_swipe_min_speed_to_force = 15;
        workspace_swipe_cancel_ratio = 0.5;
        workspace_swipe_create_new = true;
      };

      windowrule = let
        f = regex: "float, ^(${regex})$";
      in [
        (f "pwvucontrol")
        (f "mpv")
        (f "nm-connection-editor")
        (f "xdg-desktop-portal")
        (f "xdg-desktop-portal-gtk")
        (f "xdg-desktop-portal")
      ];

      windowrulev2 = [
        #"immediate, class:^()$"
        #"immediate, class:^(steam_app_1049590)$"
        "bordersize 0, floating:0, onworkspace:w[tv1]"
        "rounding 0, floating:0, onworkspace:w[tv1]"
        "bordersize 0, floating:0, onworkspace:f[1]"
        "rounding 0, floating:0, onworkspace:f[1]"
        "float,class:(clipse)"
        "size 622 652,class:(clipse)"
      ];

      workspace = [
        "w[tv1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
      ];

      bind = [
        "$mainMod, Q, killactive"
        "$mainMod, W, exec, uwsm app -- zen"
        "$mainMod, E, exec, uwsm app -- nautilus"
        "$mainMod, R, exec, uwsm app -- fuzzel"
        "$mainMod, T, exec, uwsm app -- kitty"

        "$mainMod, M, exec, uwsm app -- syspower -p 4 -t 3"

        ",Print, exec, uwsm app -- wayfreeze --hide-cursor --after-freeze-cmd 'hyprshot -m region -o ~/Imagens/; killall wayfreeze'"

        "ALT, Z, exec, uwsm app -- gsr-ui-cli toggle-show"
        "ALT, X, exec, uwsm app -- gsr-ui-cli replay-save"

        "$mainMod, C, exec, uwsm app -- kitty --class clipse -e clipse"
        "$mainMod, V, togglefloating,"
        "$mainMod, L, exec, hyprlock"
        "$mainMod, F, fullscreen"

        # Screen brightness control
        ",XF86MonBrightnessUp, exec, brightnessctl s +10%"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"

        # Audio volume control
        ",XF86AudioLowerVolume,exec,pamixer -ud 5"
        ",XF86AudioRaiseVolume,exec,pamixer -ui 5"
        ",XF86AudioMute,exec,pamixer sset Master toggle"

        # Player control
        ",XF86AudioPlay,exec, playerctl play-pause"
        ",XF86AudioNext,exec, playerctl next"
        ",XF86AudioPrev,exec, playerctl previous"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod, period, workspace, e+1"
        "$mainMod, comma, workspace,e-1"

        # Move active window to a workspace with mainMod + CTRL + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # same as above, but doesnt switch to the workspace
        "$mainMod CTRL, 1, movetoworkspacesilent, 1"
        "$mainMod CTRL, 2, movetoworkspacesilent, 2"
        "$mainMod CTRL, 3, movetoworkspacesilent, 3"
        "$mainMod CTRL, 4, movetoworkspacesilent, 4"
        "$mainMod CTRL, 5, movetoworkspacesilent, 5"
        "$mainMod CTRL, 6, movetoworkspacesilent, 6"
        "$mainMod CTRL, 7, movetoworkspacesilent, 7"
        "$mainMod CTRL, 8, movetoworkspacesilent, 8"
        "$mainMod CTRL, 9, movetoworkspacesilent, 9"
        "$mainMod CTRL, 0, movetoworkspacesilent, 10"
      ];

      bindm = [
        "SUPER, mouse:273, resizewindow"
        "SUPER, mouse:272, movewindow"
      ];

      decoration = {
        dim_inactive = false;
        rounding = 6;
        rounding_power = 4.0;

        shadow = {
          enabled = false;
          color = "rgb(89b4fa)";
          range = 4;
          render_power = 3;
          ignore_window = true;
        };

        blur = {
          enabled = true;
          size = 6;
          passes = 3;
          new_optimizations = "on";
          noise = 0.01;
          contrast = 0.9;
          brightness = 0.8;
          popups = true;
        };
      };

      animations = {
        enabled = "yes";
        bezier = [
          "winIn, 0.1, 1.0, 0.1, 1.0"
          "winOut, 0.1, 1.0, 0.1, 1.0"
          "smoothOut, 0.5, 0, 0.99, 0.99"
          "layerOut, 0.23,1,0.32,1"
        ];
        animation = [
          "windowsIn, 1, 7, winIn, slide"
          "windowsOut, 1, 3, smoothOut, slide"
          "windowsMove, 1, 7, winIn, slide"
          "workspacesIn, 1, 8, winIn, slide"
          "workspacesOut, 1, 8, winOut, slide"
          "layersIn, 1, 10, winIn, slide"
          "layersOut, 1, 3, layerOut, popin 50%"
        ];
      };
    };
  };

  systemd.user.targets.tray.Unit.Requires = lib.mkForce ["graphical-session.target"];
}
