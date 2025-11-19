{
  lib,
  pkgs,
}:
pkgs.stdenv.mkDerivation rec {
  pname = "datacorn";
  version = "2.2.0";

  src = pkgs.fetchurl {
    url = "https://github.com/ProjectIgnis/Datacorn/releases/download/latest/datacorn-qt6";
    sha256 = "sha256:e0a8951da9d42e974de8054e9e7f2ba28e63bfcb8c0a45a086576778a0f4b7c4";
  };

  nativeBuildInputs = [
    pkgs.autoPatchelfHook
    pkgs.qt6.wrapQtAppsHook
    pkgs.wrapGAppsHook3
  ];

  dontBuild = true;
  dontUnpack = true;

  buildInputs = [
    pkgs.qt6.qtbase
    pkgs.stdenv.cc.cc.lib
  ];

  installPhase = ''
    mkdir -p $out/bin

    cp $src $out/bin/datacorn
    chmod +x $out/bin/datacorn
  '';

  meta = with lib; {
    description = "A universal, multi-platform YGOPro data manager";
    homepage = "https://github.com/ProjectIgnis/Datacorn";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
  };
}
