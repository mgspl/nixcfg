{pkgs, ...}: {
  services.scx = {
    enable = true;
    scheduler = "scx_lavd";
    package = pkgs.scx.rustscheds;
    extraArgs = ["--autopower"];
  };
}
