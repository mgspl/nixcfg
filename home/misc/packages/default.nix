{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    # Programs
    inputs.zen-browser.packages."${system}".default
    goofcord
    nwg-displays
    loupe
    nautilus
    ffmpegthumbs
    evince

    lapce
    nil

    losslesscut-bin
    kdenlive

    # Tools
    networkmanagerapplet
    unzip
    zip
    killall
    wlr-randr
    pamixer
    microfetch

    # Fonts
    nerd-fonts.ubuntu-mono
    noto-fonts

    # Hyprland
    playerctl
    # gammastep
    jq
    wayfreeze
    sysmenu
    syspower
    hyprshot
    clipse
    pwvucontrol
    imagemagick
    wl-clipboard
    xdg-utils
    brightnessctl
  ];
}
