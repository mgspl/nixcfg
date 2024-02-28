{ pkgs, inputs, ...}:

{
  programs.steam.enable = true;
  
  chaotic.steam.extraCompatPackages = with pkgs; [
    proton-ge-custom
  ];
}
