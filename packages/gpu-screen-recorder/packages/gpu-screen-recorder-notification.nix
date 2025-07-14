{
  lib,
  stdenv,
  fetchurl,
  pkg-config,
  meson,
  ninja,
  libX11,
  libXrender,
  libXrandr,
  libXext,
  libglvnd,
  wayland-scanner,
  wayland,
  gitUpdater,
}:
stdenv.mkDerivation rec {
  pname = "gpu-screen-recorder-notification";
  version = "1.0.7";

  src = fetchurl {
    url = "https://dec05eba.com/snapshot/${pname}.git.${version}.tar.gz";
    hash = "sha256-zeL15/rSPasZ98FWkG4BMlBxszvZJS8MGr6557OGeE4=";
  };

  sourceRoot = ".";

  postPatch = ''
    substituteInPlace depends/mglpp/depends/mgl/src/gl.c \
      --replace-fail "libGL.so.1" "${lib.getLib libglvnd}/lib/libGL.so.1" \
      --replace-fail "libGLX.so.0" "${lib.getLib libglvnd}/lib/libGLX.so.0" \
      --replace-fail "libEGL.so.1" "${lib.getLib libglvnd}/lib/libEGL.so.1"
  '';

  nativeBuildInputs = [
    pkg-config
    meson
    ninja
  ];

  buildInputs = [
    libX11
    libXrender
    libXrandr
    libXext
    libglvnd
    wayland-scanner
    wayland
  ];

  passthru.updateScript = gitUpdater {url = "https://repo.dec05eba.com/${pname}";};

  meta = {
    description = "Notification in the style of ShadowPlay";
    homepage = "https://git.dec05eba.com/${pname}/about/";
    license = lib.licenses.gpl3Only;
    mainProgram = "gsr-notify";
    maintainers = with lib.maintainers; [js6pak];
    platforms = lib.platforms.linux;
  };
}
