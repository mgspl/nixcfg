{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    # Programs
    inputs.zen-browser.packages."${system}".specific
    goofcord
    nwg-displays
    loupe
    nautilus
    ytmdesktop
    (vivaldi.override {
      proprietaryCodecs = true;
      enableWidevine = true;
    })

    # Adwaita Icon Theme to use as fallback
    adwaita-icon-theme

    # Screen Recorder
    wl-screenrec

    # Coding Tools
    jetbrains.idea-ultimate
    inputs.Akari.packages.${system}.default
    gh

    # Tools
    networkmanagerapplet
    unzip
    zip
    killall
    wlr-randr
    pamixer
    neofetch

    # Fonts
    nerd-fonts.ubuntu-mono
    nerd-fonts.jetbrains-mono
    noto-fonts

    # Hyprland
    hyprpanel
    gammastep
    jq
    wayfreeze
    hyprshot
    clipse
    pwvucontrol
    imagemagick
    wl-clipboard
    xdg-utils
    brightnessctl
  ];
}
