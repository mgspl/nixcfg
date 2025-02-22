{pkgs, ...}: {
  programs.zed-editor = {
    enable = true;

    extensions = [
      "nix"
      "catppuccin"
    ];

    extraPackages = with pkgs; [
      nil
      alejandra
      nerd-fonts.ubuntu-mono
      typescript-language-server
      tree-sitter-grammars.tree-sitter-javascript
      nodePackages.prettier
    ];

    userSettings = {
      assistant.enabled = false;
      telemetry.metrics = false;

      hour_format = "hour24";
      auto_update = false;
      terminal = {
        alternate_scroll = "off";
        blinking = "off";
        copy_on_select = false;
        dock = "bottom";
        detect_venv = {
          on = {
            directories = [
              ".env"
              "env"
              ".venv"
              "venv"
            ];
            activate_script = "default";
          };
        };
        env = {
          TERM = "kitty";
        };
        font_family = "UbuntuMono Nerd Font";
        font_features = null;
        font_size = null;
        line_height = "comfortable";
        option_as_meta = false;
        button = false;
        shell = "system";
        toolbar = {
          title = true;
        };
        working_directory = "current_project_directory";
      };
      # Configure Nil from lsp settings
      lsp = {
        nil = {
          settings = {
            nix = {
              binary = "/run/current-system/sw/bin/nix";
              maxMemoryMB = 2560;
            };
            flake = {
              autoArchive = true;
              autoEvalInputs = true;
              nixpkgsInputName = "nixpkgs";
            };
          };
          initialization_options = {
            formatting = {
              command = [
                "alejandra"
                "--quiet"
                "--"
              ];
            };
          };
        };
      };
      # Only Use nil
      languages = {
        Nix = {
          language_servers = [
            "nil"
            "!nixd"
          ];
          formatter = {
            external = {
              command = "alejandra";
              arguments = [
                "--quiet"
                "--"
              ];
            };
          };
        };
        JavaScript = {
          formatter = {
            external = {
              command = "prettier";
              arguments = ["--stdin-filepath" "{buffer_path}"];
            };
          };
        };
      };
      vim_mode = true;
      load_direnv = "shell_hook";
      theme = {
        mode = "dark";
        dark = "Catppuccin Mocha";
        light = "Catppuccin Mocha";
      };
      base_keymap = "JetBrains";
      ui_font_size = 15;
      ui_font_family = "UbuntuMono Nerd Font";
      buffer_font_size = 15;
      buffer_font_family = "UbuntuMono Nerd Font";
    };
  };
}
