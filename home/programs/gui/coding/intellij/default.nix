{
  pkgs,
  config,
  pkgs-stable,
  ...
}: {
  home.packages = [pkgs-stable.jetbrains.idea-ultimate];

  # Only use Java with IntelliJ
  programs.java = {
    enable = true;
    package = pkgs.jdk17;
  };
}
