{
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "Miguel";

    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  home.packages = with pkgs; [
    gh
  ];
}
