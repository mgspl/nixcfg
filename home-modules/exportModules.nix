{ inputs, ...}: {
  imports = with inputs; [
   chaotic.homeManagerModules.default
   catppuccin.homeModules.catppuccin
   nvf.homeManagerModules.default
  ];
}
