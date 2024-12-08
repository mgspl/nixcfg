{ pkgs, lib, ... }:
{
  programs.nixvim = {
    enable = true;

    colorschemes.catppuccin.enable = true;

    plugins = {
      lazy.enable = true;
      telescope.enable = true;
      luasnip.enable = true;
      nvim-autopairs.enable = true;
      nvim-tree.enable = true;
      comment.enable = true;
      bufferline.enable = true;
      toggleterm.enable = true;
      neocord.enable = true;
      web-devicons.enable = true;
      lsp.enable = true;
      none-ls.enable = true;
      lsp-format.enable = true;
      barbecue.enable = true;
      navic.enable = true;
      illuminate.enable = true;
      which-key.enable = true;
      ts-context-commentstring.enable = true;
      friendly-snippets.enable = true;
      lualine.enable = true;
      numbertoggle.enable = true;
      scrollview.enable = true;
      statuscol.enable = true;
      noice.enable = true;
      smart-splits.enable = true;

      alpha = {
        enable = true;
        theme = "dashboard";
      };

      blink-cmp = {
        enable = true;
      };

      treesitter = {
        enable = true;

        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          bash
          json
          lua
          make
          markdown
          nix
          regex
          toml
          vim
          vimdoc
          xml
          yaml
          python
          c
          hyprlang
        ];
      };

      cmp_luasnip.enable = true;
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings.sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
      };
    };
  };
}
