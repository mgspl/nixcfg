{ pkgs, ...}:
{
  services.arrpc.enable = true;
  home.packages = with pkgs; [
    # Programs
    floorp
    firefox
    vesktop
    lunarvim
    nwg-displays
    loupe
    mpv
    pcmanfm
    lxmenu-data
    shared-mime-info
    xarchiver
    valent

    # Tools
    networkmanagerapplet
    btop
    unzip
    zip
    killall
    wlr-randr
    grim
    slurp
    ananicy-cpp
    ananicy-cpp-rules
    inotify-tools
    libnotify
    acpi
    pamixer
    pfetch-rs
    wlsunset
    bun
    fd

    # Fonts
    (pkgs.nerdfonts.override { fonts = [ "UbuntuMono" ]; })
    noto-fonts

    # Hyprland
    hyprshade
    swww
    wf-recorder
    wayshot
    brightnessctl
    pavucontrol
    imagemagick
    wl-clipboard
  ];
}
