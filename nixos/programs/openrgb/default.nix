{
  pkgs,
  lib,
  ...
}: let
  openrgb = pkgs.openrgb.overrideAttrs {
    version = "git";
    src = pkgs.fetchFromGitLab {
      owner = "CalcProgrammer1";
      repo = "OpenRGB";
      rev = "219b8909edc39b8584d3dec91c647462b338074d";
      hash = "sha256-LiI/RWFvW4sxeGNn3PT+jiTiO0BUt72mHu/UFGWBqGU=";
    };
    postPatch = ''
      patchShebangs scripts/build-udev-rules.sh
      substituteInPlace scripts/build-udev-rules.sh \
        --replace "/usr/bin/env chmod" "${lib.getExe' pkgs.coreutils "chmod"}"
    '';
  };
in {
  # Enable OpenRGB

  services.hardware.openrgb = {
    enable = true;
    package = openrgb;
  };
  services.udev.packages = [openrgb];
}
