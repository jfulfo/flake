{
  lib,
  appimageTools,
  fetchurl,
}: let
  pname = "revolting-desktop";
  version = "0.1.0";
  name = "${pname}-${version}";

  src = fetchurl {
    url = "https://github.com/CharredLee/revolt-desktop/releases/download/v${version}/revolting-desktop-${version}.AppImage";
    sha256 = "06nyayn3xdw0wqvgvk1q6y883p8gfkkbj1qgdwmijcks6ff9g34m";
  };

  appimageContents = appimageTools.extractType2 {
    inherit pname version src;
  };
in
  appimageTools.wrapType2 {
    inherit name pname version src;

    extraInstallCommands = ''
      # Create directories
      mkdir -p $out/share/applications
      mkdir -p $out/share/icons/hicolor/512x512/apps

      # Install desktop file if it exists
      if [ -e ${appimageContents}/*.desktop ]; then
        install -m 444 -D ${appimageContents}/*.desktop $out/share/applications/${pname}.desktop
        substituteInPlace $out/share/applications/${pname}.desktop \
          --replace 'Exec=AppRun' 'Exec=${pname}'
      fi

      # Install icon if it exists
      if [ -e ${appimageContents}/*.png ]; then
        install -m 444 -D ${appimageContents}/*.png $out/share/icons/hicolor/512x512/apps/${pname}.png
      fi
    '';

    meta = with lib; {
      description = "third party revolt app";
      homepage = "https://github.com/CharredLee/revolt-desktop";
      license = licenses.gpl3;
      platforms = ["x86_64-linux"];
    };
  }
