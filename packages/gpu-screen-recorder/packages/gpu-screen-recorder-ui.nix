{
  lib,
  stdenv,
  fetchurl,
  pkg-config,
  meson,
  ninja,
  makeWrapper,
  callPackage,
  libX11,
  libXrender,
  libXrandr,
  libXcomposite,
  libXi,
  libXcursor,
  libglvnd,
  cmake,
  wayland,
  wayland-scanner,
  libdrm,
  libpulseaudio,
  wrapperDir ? "/run/wrappers/bin",
  gitUpdater,
}:
stdenv.mkDerivation rec {
  pname = "gpu-screen-recorder-ui";
  version = "1.6.7";

  src = fetchurl {
    url = "https://dec05eba.com/snapshot/${pname}.git.${version}.tar.gz";
    hash = "sha256-H1hkcpiGyy4KS6WLJPaQ5I0ffzHGC/jr7yYbFyrLIeg=";
  };

  sourceRoot = ".";

  postPatch = ''
    substituteInPlace depends/mglpp/depends/mgl/src/gl.c \
      --replace-fail "libGL.so.1" "${lib.getLib libglvnd}/lib/libGL.so.1" \
      --replace-fail "libGLX.so.0" "${lib.getLib libglvnd}/lib/libGLX.so.0" \
      --replace-fail "libEGL.so.1" "${lib.getLib libglvnd}/lib/libEGL.so.1"

    substituteInPlace extra/gpu-screen-recorder-ui.service \
      --replace-fail "ExecStart=${meta.mainProgram}" "ExecStart=$out/bin/${meta.mainProgram}"
  '';

  nativeBuildInputs = [
    pkg-config
    meson
    ninja
    makeWrapper
    cmake
  ];

  buildInputs = [
    libX11
    libXrender
    libXrandr
    libXcomposite
    libXi
    libglvnd
    libXcursor
    libpulseaudio
    libdrm
    wayland
    wayland-scanner
  ];

  mesonFlags = [
    # Handled by the module
    (lib.mesonBool "capabilities" true)
  ];

  postInstall = let
    gpu-screen-recorder-wrapped = (callPackage ./gpu-screen-recorder.nix {}).override {
      inherit wrapperDir;
    };
  in ''
    wrapProgram "$out/bin/${meta.mainProgram}" \
      --prefix PATH : "${wrapperDir}" \
      --suffix PATH : "${
      lib.makeBinPath [
        gpu-screen-recorder-wrapped
        (callPackage ./gpu-screen-recorder-notification.nix {})
      ]
    }"
  '';

  passthru.updateScript = gitUpdater {url = "https://repo.dec05eba.com/${pname}";};

  meta = {
    description = "A fullscreen overlay UI for GPU Screen Recorder in the style of ShadowPlay";
    homepage = "https://git.dec05eba.com/${pname}/about/";
    license = lib.licenses.gpl3Only;
    mainProgram = "gsr-ui";
    maintainers = with lib.maintainers; [js6pak];
    platforms = lib.platforms.linux;
  };
}
