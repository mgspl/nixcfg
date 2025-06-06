{
  pkgs,
  inputs,
  ...
}: {
  programs.steam = {
    enable = true;

    extraPackages = with pkgs; [
      libgdiplus
      keyutils
      libkrb5
      libpng
      libpulseaudio
      libvorbis
      at-spi2-atk
      fmodex
      gtk3
      gtk3-x11
      harfbuzz
      icu
      inetutils
      libthai
      mono5
      pango
      strace
      zlib
    ];

    package = pkgs.steam.override {
      # some launch args that work better for me
      extraArgs = "-silent -system-composer -skipstreamingdrivers -cef-disable-breakpad -cef-disable-seccomp-sandbox -cef-disable-js-logging -no-cef-sandbox";
    };

    extraCompatPackages = [
      pkgs.proton-ge-custom
    ];
  };
}
