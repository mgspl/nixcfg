{ pkgs, inputs, ... }: {
  home.packages = with pkgs; [
    # Programs
    firedragon
    goofcord
    loupe
    nautilus
    papers

    # Tools
    networkmanagerapplet
    unzip
    zip
    killall
    wlr-randr
    pamixer
    microfetch

    # Fonts
    nerd-fonts.adwaita-mono
    noto-fonts

    # Compositor
    playerctl
    grimblast
    clipse
    pwvucontrol
    imagemagick
    wl-clipboard
    xdg-utils
    brightnessctl
  ];
}
