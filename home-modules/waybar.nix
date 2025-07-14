{pkgs, ...}: {
  home.packages = with pkgs; [wlogout pwvucontrol];
  programs.waybar = {
    enable = true;

    package = pkgs.waybar.overrideAttrs (previousAttrs: {
      patches = [./patches/hide-vacant.patch];
    });

    settings = {
      mainBar = {
        layer = "bottom";
        position = "top";
        mode = "dock";
        exlusive = true;
        passthrough = false;
        ipc = false;
        reload_style_on_change = true;
        height = 35;
        modules-left = [
          #"sway/workspaces"
          "dwl/tags"
          "dwl/window"
        ];
        modules-right = [
          "tray"
          "clock"
          "pulseaudio"
          "battery"
          "custom/notification"
          "custom/power"
        ];

        "sway/workspaces" = {
          format = "{name}";
        };
        "dwl/tags" = {
          num-tags = 9;
          hide-vacant = true;
        };
        "sway/window" = {
          format = "{appid}";
          icon = true;
          icon-size = 22;
        };
        "dwl/window" = {
          format = "{app_id}";
          icon = true;
          icon-size = 22;
        };

        "tray" = {
          icon-size = 22;
          spacing = 10;
        };

        "clock" = {
          timezone = "America/Sao_Paulo";
          format = "{:%H:%M}  ";
          format-alt = "{:%A, %b %d}  ";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><span>{calendar}</span></tt>";
          #format-alt = "<span foreground='#89b4fa'>󰥔  </span>{:%d/%m/%Y}";
          #format = "<span foreground='#89b4fa'>󰥔  </span>{:%H:%M}";
          calendar = {
            mode = "month";
            #mode-mon-col = 3;
            #week-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#f5e0dc'><b>{}</b></span>";
              days = "<span color='#cdd6f4'><b>{}</b></span>";
              weeks = "<span color='#89dceb'><b>W{}</b></span>";
              weekdays = "<span color='#fab387'><b>{}</b></span>";
              today = "<span color='#f38ba8'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };

        "battery" = {
          bat = "BAT1";
          adapter = "ADP1";
          states = {
            warning = 30;
            critical = 15;
          };
          full-at = 85;
          format = "{icon} {capacity}%";
          format-alt = "{icon}";
          format-icons = [" " " " " " " " " "];
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          tooltip = false;
          format-bluetooth = "{icon} {volume}%";
          format-muted = " Mutado!";
          on-click = "pamixer -t";
          on-scroll-up = "pamixer -i 2";
          on-scroll-down = "pamixer -d 2";
          scroll-step = 5;
          format-icons = {
            headphone = " ";
            hands-free = " ";
            headset = " ";
            phone = " ";
            portable = " ";
            car = "";
            default = ["" " " " "];
          };
          on-click-right = "pwvucontrol";
        };

        "pulseaudio#microphone" = {
          format = "{format_source}";
          format-source = " {volume}%";
          tooltip = false;
          format-source-muted = " Muted";
          on-click = "pamixer --default-source -t";
          on-scroll-up = "pamixer --default-source -i 2";
          on-scroll-down = "pamixer --default-source -d 2";
          scroll-step = 5;
        };

        "custom/notification" = {
          tooltip = false;
          format = "{icon}";
          format-icons = {
            notification = "<span foreground='#89b4fa'> </span><sup> </sup>";
            none = "<span foreground='#89b4fa'> </span>";
            dnd-notification = "<span foreground='#89b4fa'> </span><sup> </sup>";
            dnd-none = "<span foreground='#89b4fa'>  </span>";
            inhibited-notification = "<span foreground='#89b4fa'> </span><sup> </sup>";
            inhibited-none = "<span foreground='#89b4fa'> </span>";
            dnd-inhibited-notification = "<span foreground='#89b4fa'> </span><sup> </sup>";
            dnd-inhibited-none = "<span foreground='#89b4fa'>  </span>";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };

        "custom/power" = {
          tooltip = false;
          on-click = "wlogout &";
          format = "󰐥 ";
        };
      };
    };
    style = ''
            * {
        border: none;
        font-family: AdwaitaMonoNerdFonts;
        font-weight: 600;
        font-size: 14px;
        min-height: 0;
      }

      window#waybar {
        background: #1e1e2e;
        margin: 0px;
        padding: 0px;
      }

      tooltip {
        background: #1e1e2e;
        border-radius: 4px;
        border-width: 2px;
        border-style: solid;
        border-color: #89b4fa;
        color: #cdd6f4;
      }

      #language,
      #custom-updates,
      #custom-weather,
      #window,
      #taskbar,
      #tags,
      #custom-playerctl,
      #clock,
      #battery,
      #pulseaudio,
      #cpu,
      #temperature,
      #backlight,
      #network,
      #workspaces,
      #tray,
      #cava,
      #keyboard-state,
      #custom-notification,
      #custom-power {
        background: none;
        padding: 0px 7px;
        margin: 0px;
        margin-top: 3px;
        margin-bottom: 0px;
      }

      #tags,
      #workspaces {
        border-radius: 4px;
        border-width: 2px;
        border-style: none;
        border-color: #89b4fa;
        margin-left: 4px;
        padding-left: 10px;
        padding-right: 6px;
        background: #1e1e2e;

      }

      #tags button,
      #workspaces button {
        border: none;
        transition-duration: 0.3s;
        background: none;
        box-shadow: inherit;
        text-shadow: inherit;
        color: #89b4fa;
        padding: 1px;
        padding-left: 1px;
        padding-right: 1px;
        margin-right: 4px;
      }

      #tags button,
      #workspaces button {
        color: #89b4fa;
      }

      tags button.occupied,
      #workspaces button.occupied {
        color: #89b4fa;
      }

      #tags button.overview,
      #workspaces button.overview {
        color: #89b4fa;
      }

      #tags button:hover,
      #workspaces button:hover {
        color: #bac2de;
      }

      #tags button.focused,
      #workspaces button.focused {
        background-color: #89b4fa;
        color: #1e1e2e;
        margin-top: 5px;
        margin-bottom: 5px;
        padding-top: 1px;
        padding-bottom: 0px;
        border-radius: 3px;
      }

      #tags button.urgent,
      #workspaces button.urgent {
        background-color: #f38ba8;
        color: #1e1e2e;
        margin-top: 5px;
        margin-bottom: 5px;
        padding-top: 1px;
        padding-bottom: 0px;
        border-radius: 3px;
      }

      #tray {
        background: #1e1e2e;
        border-radius: 4px;
        border-width: 2px;
        border-style: none;
        border-color: #c9b890;
        margin-right: 4px;
        margin-left: 4px;
        padding-right: 8px;
        padding-left: 9px;
        padding-top: 2px;
      }

      #network {
        background: rgba(40, 40, 40, 0.76);
        border-radius: 4px;
        border-width: 2px;
        border-style: solid;
        border-color: #c9b890;
        margin-right: 4px;
        margin-left: 0px;
        padding-right: 8px;
        padding-left: 9px;
        padding-top: 2px;
        color: #ddca9e;
      }

      #language {
        background: rgba(40, 40, 40, 0.76);
        color: #ddca9e;
        border-width: 2px;
        border-style: solid;
        border-color: #c9b890;
        border-right: 0px;
        border-radius: 4px 0px 0px 4px;
        min-width: 24px;
      }

      #keyboard-state {
        background: none;
        color: #ddca9e;
        border: none;
        padding-top: 1px;
      }

      #custom-updates {
        background: rgba(40, 40, 40, 0.76);
        color: #ddca9e;
        border-radius: 0px 4px 4px 0px;
        border-width: 2px;
        border-left: 0px;
        border-style: solid;
        border-color: #c9b890;
      }

      #window {
        background: #1e1e2e;
        border-width: 2px;
        border-style: none;
        border-color: #c9b890;
        border-radius: 4px;
        margin-left: 0px;
        margin-right: 10px;
        color: #89b4fa;
      }

      #taskbar {
        background: rgba(40, 40, 40, 0.76);
        border-width: 2px;
        border-style: solid;
        border-color: #c9b890;
        border-radius: 4px;
        margin-left: 10px;
        margin-right: 10px;
        color: #ddca9e;
      }

      #taskbar.empty {
        margin-left: 0px;
        margin-right: 0px;
        padding-left: 10px;
        padding-right: 0px;
        border-radius: 0px;
        border-color: transparent;
        border: none;
        background-color: transparent;
      }

      #taskbar button {
        margin-right: 3px;
      }

      #taskbar button.minimized {
        background-color: #709d1c;
        color: #282828;
        margin-top: 5px;
        margin-bottom: 5px;
        padding-top: 0px;
        padding-bottom: 0px;
        padding-left: 3px;
        padding-right: 3px;
        border-radius: 3px;
      }

      #taskbar button.urgent {
        background-color: #ce3d0d;
        color: #282828;
        margin-top: 5px;
        margin-bottom: 5px;
        padding-top: 0px;
        padding-bottom: 0px;
        padding-left: 3px;
        padding-right: 3px;
        border-radius: 3px;
      }

      #taskbar button.active {
        background-color: #ddca9e;
        color: #282828;
        margin-top: 5px;
        margin-bottom: 5px;
        padding-top: 0px;
        padding-bottom: 0px;
        padding-left: 3px;
        padding-right: 3px;
        border-radius: 3px;
      }

      #custom-playerctl {
        background: rgba(40, 40, 40, 0.76);
        border-width: 2px;
        border-style: solid;
        border-color: #c9b890;
        border-right: 0px;
        border-left: 0px;
        color: #ddca9e;
      }

      #cava {
        background: rgba(40, 40, 40, 0.76);
        border-radius: 4px 0px 0px 4px;
        border-width: 2px;
        border-style: solid;
        border-color: #c9b890;
        border-right: 0px;
        margin-left: 4px;
        color: #ddca9e;
      }

      #clock {
        background: #1e1e2e;
        color: #89b4fa;
        border-width: 2px;
        border-style: none;
        border-color: #c9b890;
        border-right: 2px;
        border-radius: 4px 0px 0px 4px;
      }

      #pulseaudio {
        background: #1e1e2e;
        color: #89b4fa;
        border-width: 2px;
        border-width: 2px;
        border-style: none;
        border-color: #c9b890;
        border-right: 0px;
        margin-left: 0px;
        border-radius: 4px 0px 0px 4px;
      }

      #cpu  {
        background: rgba(40, 40, 40, 0.76);
        color: #ddca9e;
        border-width: 2px;
        border-style: solid;
        border-color: #c9b890;
        border-right: 0px;
        border-left: 0px;
        border-radius: 0px;
      }

      #temperature {
        background: rgba(40, 40, 40, 0.76);
        color: #ddca9e;
        border-width: 2px;
        border-style: solid;
        border-color: #c9b890;
        border-right: 0px;
        border-left: 0px;
        border-radius: 0px;
      }

      #backlight {
        background: rgba(40, 40, 40, 0.76);
        color: #ddca9e;
        border-width: 2px;
        border-style: solid;
        border-color: #c9b890;
        border-radius: 0px 4px 4px 0px;
        border-left: 0px;
        margin-right: 4px;
      }

      #battery {
        background: #1e1e2e;
        color: #89b4fa;
        border-width: 2px;
        border-style: none;
        border-color: #c9b890;
        border-radius: 0px;
        border-right: 0px;
        border-left: 0px;
      }

      #custom-weather {
        background: rgba(40, 40, 40, 0.76);
        color: #ddca9e;
        border-radius: 4px 0px 0px 4px;
        border-width: 2px;
        border-style: solid;
        border-color: #c9b890;
        border-right: 0px;
        margin-left: 4px;
        padding-right: 7px;
        padding-top: 1px;
      }

      #custom-notification {
        background: #1e1e2e;
        color: #89b4fa;
        border-width: 2px;
        border-style: none;
        border-color: #c9b890;
        border-left: 0px;
        border-right: 0px;
        border-radius: 0px;
        min-width: 18px;
      }

      #custom-power {
        background: #1e1e2e;
        color: #89b4fa;
        border-width: 2px;
        border-style: none;
        border-color: #c9b890;
        border-radius: 0px 4px 4px 0px;
        border-left: 0px;
        margin-left: 0px;
        margin-right: 4px;
        padding-right: 14px;
      }
    '';
  };
}
