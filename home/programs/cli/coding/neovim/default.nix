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
          lspSignature.enable = true;
        };
        languages = {
          enableLSP = true;
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          bash.enable = true;
          css.enable = true;
          nix.enable = true;
          python.enable = true;
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

        autocomplete.nvim-cmp.enable = true;
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

        tabline = {
          nvimBufferline.enable = true;
        };

        treesitter.context.enable = true;

        telescope.enable = true;

        minimap = {
          minimap-vim.enable = true;
          codewindow.enable = false; # lighter, faster, and uses lua for configuration
        };

        dashboard.alpha.enable = true;

        utility = {
          motion = {
            hop.enable = true;
            leap.enable = true;
          };
        };

        terminal.toggleterm = {
          enable = true;
          mappings.open = "<leader>t";
          setupOpts.direction = "float";
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
            enable = false;
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

        comments = {
          comment-nvim.enable = true;
        };
        binds.whichKey.enable = true;
        lineNumberMode = "number";
        notify.nvim-notify.enable = true;
        syntaxHighlighting = true;
        undoFile.enable = true;
        useSystemClipboard = true;
        withPython3 = true;
      };
    };
  };
}
