{pkgs, ...}: {
  services.scx = {
    enable = true;
    scheduler = "scx_rustland";
    package = pkgs.scx.rustscheds;
    # LAVD args Rustland doenst support flags
    #extraArgs = ["--autopower"];
  };
}
