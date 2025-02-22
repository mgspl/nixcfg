{
  lib,
  pkgs,
  ...
}: {
  catppuccin.helix = {
    enable = true;
    flavor = "mocha";
    useItalics = true;
  };

  programs.helix = {
    enable = true;
    extraPackages = with pkgs; [nil alejandra];
    settings = {
      #theme = "catppuccin_mocha";
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
      editor.indent-guides = {
        render = true;
      };
    };
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = lib.getExe pkgs.alejandra;
      }
    ];
  };
}
