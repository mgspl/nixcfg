{
  pkgs,
  inputs,
  ...
}: {
  #imports = [inputs.android-nixpkgs.hmModule];

  #nixpkgs.overlays = [inputs.android-nixpkgs.overlays.default];

  /*
    android-sdk = {
    enable = true;

    path = "/home/miguel/.local/share/android";

    packages = sdk:
      with sdk; [
        build-tools-35-0-1
        cmdline-tools-latest
        platform-tools
        platforms-android-35
        sources-android-35
      ];
  };
  */

  home.packages = [pkgs.jetbrains.idea-ultimate];

  # Only use Java with IntelliJ
  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };
}
