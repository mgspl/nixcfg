{inputs, ...}: {
  imports = [inputs.maomaowm.nixosModules.maomaowm];
  programs.maomaowm.enable = true;
}
