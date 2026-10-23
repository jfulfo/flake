{
  pkgs,
  username,
  ...
}: {
  home-manager.users.${username} = {
    config,
    lib,
    ...
  }: let
    settingsPath = "${config.home.homeDirectory}/.config/Code/User/settings.json";
  in {
    programs.vscode = {
      package = lib.mkForce (pkgs.vscode-fhsWithPackages (ps:
        with ps; [
          alejandra
          cargo
          clang-tools
          clippy
          elan
          ghc
          haskell-language-server
          nixd
          ocamlPackages.dune_3
          ocamlPackages.ocaml
          ocamlPackages.ocaml-lsp
          ocamlformat
          python3
          rocqPackages.vsrocq-language-server
          rustc
          rustfmt
        ]));

      profiles.default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;

        extensions =
          (with pkgs.vscode-extensions; [
            pkgs.vscode-extensions."13xforever".language-x86-64-assembly
            anthropic.claude-code
            banacorn.agda-mode
            charliermarsh.ruff
            detachhead.basedpyright
            esbenp.prettier-vscode
            haskell.haskell
            james-yu.latex-workshop
            jnoortheen.nix-ide
            justusadam.language-haskell
            leanprover.lean4
            llvm-vs-code-extensions.vscode-clangd
            mkhl.direnv
            ms-python.debugpy
            ms-python.python
            ocamllabs.ocaml-platform
            rocq-prover.vsrocq
            rust-lang.rust-analyzer
            shd101wyy.markdown-preview-enhanced
            sumneko.lua
            tamasfe.even-better-toml
            vadimcn.vscode-lldb
            vscodevim.vim
          ])
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              publisher = "theqtcompany";
              name = "qt-core";
              version = "1.16.0";
              hash = "sha256-6NBWsK7ljx7Ie3xvOrjBClyvwQP1UltCna1jQHJST5U=";
            }
            {
              publisher = "theqtcompany";
              name = "qt-qml";
              version = "1.16.0";
              hash = "sha256-QWjUSbBtHIdxYZyRBDn64HXhvSwhgzm7DjDaed6lNds=";
            }
          ];

        userSettings = {
          "window.zoomLevel" = 1;
          "chat.disableAIFeatures" = true;
          "extensions.autoUpdate" = false;

          "haskell.manageHLS" = "PATH";
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nixd";
          "nix.serverSettings".nixd.formatting.command = ["alejandra"];
          "ocaml.sandbox".kind = "global";
          "python.languageServer" = "None";
          "qt-qml.qmlls.customExePath" = "${pkgs.qt6.qtdeclarative}/bin/qmlls";
          "[css]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
          "[html]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
          "[javascript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
          "[typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
          "[python]"."editor.defaultFormatter" = "charliermarsh.ruff";
        };
      };
    };

    home.file.${settingsPath}.enable = lib.mkForce false;

    home.activation.vscodeMutableSettings = lib.hm.dag.entryAfter ["linkGeneration"] ''
      settings=${lib.escapeShellArg settingsPath}
      generated=${config.home.file.${settingsPath}.source}
      merged=$(mktemp)
      run mkdir -p "$(dirname "$settings")"
      if [ -f "$settings" ] && ${pkgs.jq}/bin/jq -s '.[0] * .[1]' "$settings" "$generated" > "$merged"; then
        run install -m 644 "$merged" "$settings"
      else
        [ -e "$settings" ] && run mv "$settings" "$settings.bak"
        run install -m 644 "$generated" "$settings"
      fi
      rm -f "$merged"
      run rm -f "${config.home.homeDirectory}/.vscode/extensions/.obsolete"
    '';
  };
}
