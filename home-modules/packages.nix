{pkgs, ...}: {
  home.packages = with pkgs; [
    # Programs
    dorion
    loupe
    nautilus
    papers
    losslesscut-bin

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
    clipse
    pwvucontrol
    imagemagick
    wl-clipboard
    xdg-utils
    xdg-user-dirs
    brightnessctl
  ];
}
