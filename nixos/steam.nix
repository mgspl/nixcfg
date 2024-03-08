{ pkgs, inputs, ...}:

{
  programs.steam = {
    enable = true;
  };
  
  #environment.systemPackages = with pkgs; [
  #  gamescope_git
  #];

  chaotic.steam.extraCompatPackages = with pkgs; [
    proton-ge-custom
  ];
}
