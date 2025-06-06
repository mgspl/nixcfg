{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.callPackage ./packages/gpu-screen-recorder-notification.nix {})
    (pkgs.callPackage ./packages/gpu-screen-recorder-ui.nix {})
  ];

  programs.gpu-screen-recorder = {
    enable = true;
    package = pkgs.callPackage ./packages/gpu-screen-recorder.nix {};
  };
}
