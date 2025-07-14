{
  programs.nvf = {
    enable = true;

    settings = {
      vim = {
        lsp = {
          enable = true;
          formatOnSave = true;
          lightbulb.enable = true;
          trouble.enable = true;
          lspSignature.enable = false;
          otter-nvim.enable = true;
        };
        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          bash.enable = true;
          #css.enable = true;
          nix.enable = true;
          #markdown.enable = true;
          #python.enable = false;
        };
        visuals = {
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          cinnamon-nvim.enable = true;
          fidget-nvim.enable = true;

          highlight-undo.enable = true;
          indent-blankline.enable = true;
        };

        statusline = {
          lualine = {
            enable = true;
            theme = "catppuccin";
          };
        };
        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
          transparent = false;
        };
        autopairs.nvim-autopairs.enable = true;

        autocomplete.blink-cmp = {
          enable = true;
          setupOpts.signature.enabled = true;
        };
        snippets.luasnip.enable = true;

        filetree.nvimTree = {
          enable = true;
          openOnSetup = false;
          mappings = {
            toggle = "<leader>e";
            refresh = "<leader>er";
            focus = "<leader>ef";
            findFile = "<leader>eg";
          };
        };

        tabline = {nvimBufferline.enable = true;};

        treesitter.context.enable = true;

        telescope.enable = true;

        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = false;
        };

        minimap = {
          minimap-vim.enable = false;
          codewindow.enable = false; # lighter, faster, and uses lua for configuration
        };

        dashboard.alpha.enable = true;

        utility = {
          motion = {
            hop.enable = false;
            leap.enable = true;
            precognition.enable = false;
          };
        };

        terminal.toggleterm = {
          enable = true;
          mappings.open = "<leader>t";
          setupOpts.direction = "float";
          lazygit.enable = true;
        };

        ui = {
          borders.enable = true;
          noice.enable = true;
          colorizer.enable = true;
          illuminate.enable = true;
          breadcrumbs = {
            enable = true;
            navbuddy.enable = true;
          };
          smartcolumn = {
            enable = true;
            setupOpts.custom_colorcolumn = {
              # this is a freeform module, it's `buftype = int;` for configuring column position
              nix = "110";
              ruby = "120";
              java = "130";
              go = ["90" "130"];
            };
          };
          fastaction.enable = true;
        };

        clipboard = {
          enable = true;
          providers.wl-copy.enable = true;
        };

        globals = {
          shiftwidth = 4;
          tabstop = 4;
          wrap = false;
        };

        comments = {comment-nvim.enable = true;};
        binds.whichKey.enable = true;
        lineNumberMode = "number";
        notify.nvim-notify.enable = true;
        syntaxHighlighting = true;
        undoFile.enable = true;
        withPython3 = true;
      };
    };
  };
}
