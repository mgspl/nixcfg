{ inputs, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    plugins = [
      inputs.hycov.packages.${pkgs.system}.hycov
    ]; 
    
    extraConfig = ''  
      source = ~/.config/hypr/monitors.conf

      plugin {
         hycov {
          overview_gappo = 60 #gaps width from screen
          overview_gappi = 24 #gaps width from clients
          hotarea_size = 10 #hotarea size in bottom left,10x10
          enable_hotarea = 1 # enable mouse cursor hotarea
          hotarea_pos = 3 # position of hotarea (1: bottom left, 2: bottom right, 3: top left, 4: top right)          
        }
      }

    '';

    settings = {
      "$mainMod" = "SUPER";
      exec-once = [
        "hyprshade auto"
	      "AGS_SKIP_V_CHECK=true ags"
      ];

      general = {
        gaps_in = 3;
        gaps_out = 5;
        border_size = 3;
	      layout = "dwindle";
      };

      dwindle = {
	      no_gaps_when_only = true;
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
       sensitivity = 0;
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
	      (f "pavucontrol")
	      (f "mpv")
	      (f "nm-connection-editor")
	      (f "xdg-desktop-portal")
      	(f "xdg-desktop-portal-gtk")
	      (f "xdg-desktop-portal")
	      (f "com.github.Aylur.ags")
      ];

     bind = [
       "$mainMod, Q, killactive"
       "$mainMod, W, exec, floorp"
       "$mainMod, E, exec, pcmanfm"
       "$mainMod, R, exec, ags -t applauncher"
       "$mainMod, T, exec, kitty"

         "$mainMod, M, exec, ags -t powermenu"
        
        ",Print,         exec, ags -r 'recorder.screenshot()'"

       "$mainMod, V, togglefloating,"
       "$mainMod, F, fullscreen"

       "ALT,Tab,hycov:toggleoverview"

       # Screen brightness
       ",XF86MonBrightnessUp, exec, ags -r 'brightness.screen += 0.05; indicator.display()'"
       ",XF86MonBrightnessDown, exec, ags -r 'brightness.screen -= 0.05; indicator.display()'"

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
	    "$mainMod CTRL, 1, movetoworkspace, 1"
	    "$mainMod CTRL, 2, movetoworkspace, 2"
	    "$mainMod CTRL, 3, movetoworkspace, 3"
	    "$mainMod CTRL, 4, movetoworkspace, 4"
	    "$mainMod CTRL, 5, movetoworkspace, 5"
	    "$mainMod CTRL, 6, movetoworkspace, 6"
	    "$mainMod CTRL, 7, movetoworkspace, 7"
	    "$mainMod CTRL, 8, movetoworkspace, 8"
	    "$mainMod CTRL, 9, movetoworkspace, 9"
	    "$mainMod CTRL, 0, movetoworkspace, 10"

    # same as above, but doesnt switch to the workspace
	    "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
	    "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
	    "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
	    "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
	    "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
	    "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
	    "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
	    "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
	    "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
	    "$mainMod SHIFT, 0, movetoworkspacesilent, 10"
     ];

     bindm = [
        "SUPER, mouse:273, resizewindow"
        "SUPER, mouse:272, movewindow"
     ];

     decoration = {
        drop_shadow = "yes";
        shadow_range = 8;
        shadow_render_power = 2;
        "col.shadow" = "rgba(00000044)";

        dim_inactive = false;

        blur = {
          enabled = true;
          size = 8;
          passes = 3;
          new_optimizations = "on";
          noise = 0.01;
          contrast = 0.9;
          brightness = 0.8;
        };
      };

      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 5, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };     
    };
  };
} 
