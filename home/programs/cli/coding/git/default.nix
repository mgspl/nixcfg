{
  pkgs,
  prettyname,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "${prettyname}";

    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  home.packages = with pkgs; [
    gh
  ];
}
