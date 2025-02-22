{pkgs, ...}: {
    catppuccin.waybar = {
    enable = true;
    flavor = "mocha";
    mode = "createLink";
  };
  home.packages = with pkgs; [syshud];
  # Savivng this as backup
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-center = ["custom/music"];
        modules-right = [
          "pulseaudio"
          "battery"
          "power-profiles-daemon"
          "clock"
          "tray"
          "custom/notification"
          "custom/power"
        ];

        "hyprland/workspaces" = {
          all-outputs = true;
          format = " {icon} ";
          format-icons = {
            default = " ";
          };
        };

        "tray" = {
          icon-size = 18;
          spacing = 10;
        };

        "custom/music" = {
          format = "<span foreground='#89b4fa'>  </span>{}";
          escape = true;
          interval = 5;
          tooltip = false;
          exec = "playerctl metadata --format='{{ title }}'";
          on-click = "playerctl play-pause";
          max-length = 50;
        };

        "clock" = {
          timezone = "America/Sao_Paulo";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><span>{calendar}</span></tt>";
          format-alt = "<span foreground='#89b4fa'>󰥔  </span>{:%d/%m/%Y}";
          format = "<span foreground='#89b4fa'>󰥔  </span>{:%H:%M}";
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
          format-charging = "󰂄";
          format-plugged = " ";
          format-alt = "{icon}";
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
        };

        "pulseaudio" = {
          format = "<span foreground='#89b4fa'>{icon}</span> {volume}%";
          format-bluetooth = "{icon} {volume}%";
          format-muted = " ";
          format-icons = {
            default = [
              ""
              " "
              " "
            ];
          };
          on-click = "pwvucontrol";
        };

        "custom/power" = {
          tooltip = false;
          on-click = "syspower &";
          format = "󰐥 ";
        };

        "power-profiles-daemon" = {
          format = "{icon}";
          tooltip-format = "Power profile: {profile}\nDriver: {driver}";
          tooltip = true;
          format-icons = {
            default = " ";
            performance = " ";
            balanced = " ";
            power-saver = " ";
          };
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

        "hyprland/window" = {
          format = "{initialClass}";
          icon = true;
          icon-size = 18;
        };
      };
    };

    style = ''
        @import "catppuccin.css";

        * {
          font-family: UbuntuMono Nerd Font;
          font-size: 14px;
          min-height: 0;
        }

        #waybar {
        background-color: @crust;
        color: @text;
        margin: 1px 1px;
        }

      #workspaces {
        border-radius: 1rem;
        margin: 1px;
        background-color: @surface0;
        margin-left: 1rem;
      }

      #workspaces button {
        color: @text;
        border-radius: 1rem;
        padding: 0.2rem;
      }

      #workspaces button.active {
        color: @blue;
        border-radius: 1rem;
      }

      #workspaces button:hover {
        color: @lavender;
        border-radius: 1rem;
      }

      #window,
      #custom-notification,
      #power-profiles-daemon,
      #custom-music,
      #tray,
      #backlight,
      #clock,
      #battery,
      #pulseaudio,
      #custom-lock,
      #custom-power {
        background-color: @surface0;
        padding: 0.5rem 1rem;
        margin: 1px 0;
      }

      #clock {
        color: @text;
        border-radius: 0px 1rem 1rem 0px;
        margin-right: 1rem;
      }

      #battery {
        color: @blue;
      }

      #battery.charging {
        color: @green;
      }

      #battery.warning:not(.charging) {
        color: @red;
      }

      #battery {
        border-radius: 0;
      }

      #pulseaudio {
        color: @text;
        border-radius: 1rem 0px 0px 1rem;
        margin-left: 1rem;
      }

      #custom-music {
        color: @text;
        border-radius: 1rem;
      }

      #custom-power {
        margin-right: 1rem;
        border-radius: 0px 1rem 1rem 0px;
        color: @blue;
      }

      #tray {
        margin-right: 1rem;
        border-radius: 1rem;
        }

        #window {
          font-family: "UbuntuMono Nerd Font";
          color: @text;
        }

      #custom-notification {
        font-family: "UbuntuMono Nerd Font";
        border-radius: 1rem 0px 0px 1rem;
      }

      #power-profiles-daemon.performance {
        color: @yellow;
      }

      #power-profiles-daemon.balanced {
        color: @blue;
      }

      #power-profiles-daemon.power-saver {
        color: @green;
        }

      #window {
          border-radius: 1rem;
          margin-left: 1rem;
        }

        window#waybar.empty #window {
          background-color: transparent;
        }

    '';
  };
}
