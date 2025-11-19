{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "kingler";
  version = "unstable-2025-06-19";

  src = fetchFromGitHub {
    owner = "Altair-39";
    repo = "kingler";
    rev = "main";
    hash = "sha256-RBZzHCTU4v6SD/1Hjn0Y5qY2hv11NwYoNiVPsSSWlvg=";
  };

  cargoHash = "sha256-y4T6Qtgwf5yRRaLI7zpjfxaoeO0F2oJX3T9jq+SzBS4=";

  meta = with lib; {
    description = "Print Pokemon sprites in your terminal";
    homepage = "https://github.com/Altair-39/kingler";
    license = licenses.gpl3;
    maintainers = [];
    mainProgram = "kingler";
    platforms = platforms.all;
  };
}
