{ pkgs, config, ... }: {
  home.packages = [ pkgs.jetbrains.idea-ultimate ];

  # Only use Java with IntelliJ
  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };
}
