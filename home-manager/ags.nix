{ inputs, pkgs, ... }:
{
  imports = [ inputs.ags.homeManagerModules.default ];

  home.packages = with pkgs; [
    dart-sass
    gtk3
    (python311.withPackages (p: [ p.python-pam ]))

  ];

  programs.ags = {
    enable = true;
    configDir = null;
    extraPackages = with pkgs; [
      accountsservice
    ];
  };
}
