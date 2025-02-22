{pkgs, ...}: {
  services.scx = {
    enable = true;
    scheduler = "scx_flash";
    package = pkgs.scx.rustscheds;
    #extraArgs = [ "--autopower" ];
  };
}
