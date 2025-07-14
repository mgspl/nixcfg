{pkgs, ...}: {
  programs.sway = {
    enable = true;
    # Already defined on HomeManager
    extraPackages = [];
    package = pkgs.swayfx;
    wrapperFeatures.gtk = true;
    extraSessionCommands = ''
      export XCURSOR_SIZE=24

      export GDK_BACKEND=wayland
      export SDL_VIDEODRIVER=wayland
      export CLUTTER_BACKEND=wayland

      export QT_AUTO_SCREEN_SCALE_FACTOR=1
      export QT_QPA_PLATFORM=wayland-egl;xcb
      export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
      export _JAVA_AWT_WM_NONREPARENTING=1
    '';
  };
}
