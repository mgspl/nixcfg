{pkgs, ...}: {
  home.packages = with pkgs; [swaybg playerctl sway-audio-idle-inhibit];

  wayland.windowManager.maomaowm = {
    enable = true;
    systemd.enable = false;

    settings = ''
      # Animation Configuration
      animations=1
      animation_type_open=zoom
      animation_type_close=zoom
      animation_fade_in=1
      tag_animation_direction=1
      zoom_initial_ratio=0.5
      fadein_begin_opacity=0.5
      fadeout_begin_opacity=0.8
      animation_duration_move=500
      animation_duration_open=400
      animation_duration_tag=350
      animation_duration_close=800
      animation_curve_open=0.46,1.0,0.29,1
      animation_curve_move=0.46,1.0,0.29,1
      animation_curve_tag=0.46,1.0,0.29,1
      animation_curve_close=0.08,0.92,0,1

      # Layer Animations
      layer_animations=1
      layer_animation_type_open=zoom
      layer_animation_type_close=zoom

      # Layer Shadows
      layer_shadows=1

      # Shadow Configurations
      shadows=1
      shadows_size=5
      shadows_blur=10
      shadows_position_x=2
      shadows_position_y=2
      shadows_color=0x89b4fa7F
      shadow_only_floating=1

      # Window Borders
      border_radius=8
      no_radius_when_single=1

      # Scroller Layout Setting
      scroller_structs=20
      scroller_default_proportion=0.8
      scroller_focus_center=0
      scroller_prefer_center=0
      scroller_default_proportion_single=1.0
      scroller_proportion_preset=0.5,0.8,1.0

      # Master-Stack Layout Setting (tile,spiral,dwindle)
      new_is_master=1
      default_mfact=0.50
      default_nmaster=1
      smartgaps=1

      # Overview Setting
      hotarea_size=10
      enable_hotarea=0
      ov_tab_mode=0
      overviewgappi=5
      overviewgappo=15

      # Misc
      no_border_when_single=1
      axis_bind_apply_timeout=100
      focus_on_activate=1
      inhibit_regardless_of_visibility=0
      sloppyfocus=1
      warpcursor=1
      focus_cross_monitor=1
      focus_cross_tag=1
      enable_floating_snap=1
      snap_distance=30
      cursor_size=24
      cursor_theme=Bibata-Modern-Ice
      drag_tile_to_tile=1
      syncobj_enable=1

      # keyboard
      repeat_rate=25
      repeat_delay=600
      numlockon=1
      xkb_rules_layout=br

      # Trackpad
      # need relogin to make it apply
      tap_to_click=1
      tap_and_drag=1
      drag_lock=1
      trackpad_natural_scrolling=1
      disable_while_typing=1
      left_handed=0
      middle_button_emulation=0
      swipe_min_threshold=20

      # mouse
      # need relogin to make it apply
      mouse_natural_scrolling=1

      # Appearance
      gappih=5
      gappiv=5
      gappoh=5
      gappov=5
      borderpx=2
      # 0x equals # (Hashtag symbol)
      # After convert RGBA to hexcode
      rootcolor=0x1e1e2eed
      bordercolor=0x444444ff
      focuscolor=0x89b4faed
      maxmizescreencolor=0x89aa61ff
      urgentcolor=0xf38ba8ed
      scratchpadcolor=0xb4befeed
      globalcolor=0xb4befeed
      overlaycolor=0x14a57cff

      env=XKB_DEFAULT_LAYOUT,br
      env=XCURSOR_SIZE,24
      env=QT_QPA_PLATFORMTHEME,qt5ct
      env=QT_QPA_PLATFORM,wayland

      # Window Rules
      windowrule=isfloating:1,appid:xdg-desktop-portal-gtk
      windowrule=isfloating:1,appid:xdg-desktop-portal-gtk
      windowrule=isfloating:1,appid:polkit-gnome-authentication-agent-1
      windowrule=isfloating:1,width:622,height:652,title:clipse

      # Tags rules
      tagrule=id:1,layout_name:dwindle
      tagrule=id:2,layout_name:dwindle
      tagrule=id:3,layout_name:dwindle
      tagrule=id:4,layout_name:dwindle
      tagrule=id:5,layout_name:dwindle
      tagrule=id:6,layout_name:dwindle
      tagrule=id:7,layout_name:dwindle
      tagrule=id:8,layout_name:dwindle
      tagrule=id:9,layout_name:dwindle

      # Key Bindings
      # mod keys name: super,ctrl,alt,shift,none

      # reload config
      bind=SUPER+SHIFT,r,reload_config

      # menu and terminal
      bind=SUPER,w,spawn,firefox
      bind=SUPER,e,spawn,nautilus
      bind=SUPER,r,spawn,fuzzel
      bind=SUPER,t,spawn,kitty
      bind=SUPER,c,spawn,kitty --title clipse -e clipse

      bind=ALT,z,spawn,gsr-ui-cli toggle-show
      bind=ALT,x,spawn,gsr-ui-cli replay-save

      bind=none,Print,spawn,gsr-ui-cli take-screenshot-region
      bind=Shift,Print,spawn,gsr-ui-cli take-screenshot


      # audio
      #bind=none,XF86AudioRaiseVolume,spawn,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
      #bind=none,XF86AudioLowerVolume,spawn,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      bind=none,XF86AudioRaiseVolume,spawn,swayosd-client --output-volume 5
      bind=none,XF86AudioLowerVolume,spawn,swayosd-client --output-volume -5
      bind=none,XF86AudioMute,spawn,swayosd-client --output-volume mute-toggle
      #bind=none,XF86AudioMute,spawn,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bind=none,XF86AudioStop,spawn,${pkgs.playerctl}/bin/playerctl stop
      bind=none,XF86AudioPrev,spawn,${pkgs.playerctl}/bin/playerctl previous
      bind=none,XF86AudioNext,spawn,${pkgs.playerctl}/bin/playerctl next
      bind=none,XF86AudioPlay,spawn,${pkgs.playerctl}/bin/playerctl play-pause

      # Brightness
      #bind=none,XF86MonBrightnessDown,spawn,brightnessctl set 5%-
      #bind=none,XF86MonBrightnessUp,spawn,brightnessctl set 5%+
      bind=none,XF86MonBrightnessUp,spawn,swayosd-client --brightness +5
      bind=none,XF86MonBrightnessDown,spawn,swayosd-client --brightness -5

      # exit
      bind=SUPER,m,spawn,wlogout
      bind=SUPER,q,killclient,

      # switch window focus
      bind=SUPER,Tab,focusstack,next
      bind=ALT,Left,focusdir,left
      bind=ALT,Right,focusdir,right
      bind=ALT,Up,focusdir,up
      bind=ALT,Down,focusdir,down

      # swap window
      bind=SUPER+SHIFT,Up,exchange_client,up
      bind=SUPER+SHIFT,Down,exchange_client,down
      bind=SUPER+SHIFT,Left,exchange_client,left
      bind=SUPER+SHIFT,Right,exchange_client,right

      # switch window status
      bind=SUPER,g,toggleglobal,
      bind=ALT,Tab,toggleoverview,
      bind=SUPER,v,togglefloating,
      bind=ALT,a,togglemaxmizescreen,
      bind=SUPER,f,togglefullscreen,
      bind=ALT+SHIFT,f,togglefakefullscreen,
      bind=SUPER,i,minized,
      bind=SUPER,u,toggleoverlay,
      bind=SUPER+SHIFT,I,restore_minized
      bind=ALT,s,toggle_scratchpad

      # scroller layout
      bind=ALT,e,set_proportion,1.0
      bind=ALT,x,switch_proportion_preset,

      # switch layout
      #bind=SUPER,n,switch_layout

      # tag switch
      bind=SUPER,Left,viewtoleft,
      bind=CTRL,Left,viewtoleft_have_client,
      bind=SUPER,Right,viewtoright,
      bind=CTRL,Right,viewtoright_have_client,
      bind=CTRL+SUPER,Left,tagtoleft,
      bind=CTRL+SUPER,Right,tagtoright,

      bind=SUPER,1,view,1
      bind=SUPER,2,view,2
      bind=SUPER,3,view,3
      bind=SUPER,4,view,4
      bind=SUPER,5,view,5
      bind=SUPER,6,view,6
      bind=SUPER,7,view,7
      bind=SUPER,8,view,8
      bind=SUPER,9,view,9

      # tag: move client to the tag and focus it
      # tagsilent: move client to the tag and not focus it
      # bind=Alt,1,tagsilent,1
      bind=SUPER+SHIFT,1,tag,1
      bind=SUPER+SHIFT,2,tag,2
      bind=SUPER+SHIFT,3,tag,3
      bind=SUPER+SHIFT,4,tag,4
      bind=SUPER+SHIFT,5,tag,5
      bind=SUPER+SHIFT,6,tag,6
      bind=SUPER+SHIFT,7,tag,7
      bind=SUPER+SHIFT,8,tag,8
      bind=SUPER+SHIFT,9,tag,9

      # monitor switch
      bind=alt+shift,Left,focusmon,left
      #bind=alt+shift,Right,focusmon,right
      bind=SUPER,o,focusmon,right
      bind=SUPER+Alt,Left,tagmon,left
      bind=SUPER+SHIFT,o,tagmon,right

      # gaps
      bind=ALT+SHIFT,X,incgaps,1
      bind=ALT+SHIFT,Z,incgaps,-1
      bind=ALT+SHIFT,R,togglegaps

      # movewin
      bind=CTRL+SHIFT,Up,movewin,+0,-50
      bind=CTRL+SHIFT,Down,movewin,+0,+50
      bind=CTRL+SHIFT,Left,movewin,-50,+0
      bind=CTRL+SHIFT,Right,movewin,+50,+0

      # resizewin
      bind=CTRL+ALT,Up,resizewin,+0,-50
      bind=CTRL+ALT,Down,resizewin,+0,+50
      bind=CTRL+ALT,Left,resizewin,-50,+0
      bind=CTRL+ALT,Right,resizewin,+50,+0

      # Mouse Button Bindings
      # NONE mode key only work in ov mode
      mousebind=SUPER,btn_left,moveresize,curmove
      mousebind=NONE,btn_middle,togglemaxmizescreen,0
      mousebind=SUPER,btn_right,moveresize,curresize
      mousebind=NONE,btn_left,toggleoverview,-1
      mousebind=NONE,btn_right,killclient,0

      # Axis Bindings
      axisbind=SUPER,UP,viewtoleft_have_client
      axisbind=SUPER,DOWN,viewtoright_have_client

    '';

    autostart_sh = ''
      uwsm finalize &
      openrgb -c 89b4fa
      uwsm app -- swaybg -i ~/nixcfg/assets/wallpaper.png &
      uwsm app -- swaync &
      uwsm app -- waybar &
      uwsm app -- gsr-ui &
      uwsm app -- clipse -listen &
      uwsm app -- sway-audio-idle-inhibit &
    '';
  };
}
