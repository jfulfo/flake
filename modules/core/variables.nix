{
  config,
  lib,
  host,
  ...
}: let
  inherit (lib) mkOption types;
  hostVariables = import ../../hosts/${host}/variables.nix;
  # A single monitor entry as consumed by modules/home/hyprland/config.nix
  monitorType = types.attrsOf types.str;
in {
  # when a key is renamed or removed, add a 
  # `(lib.mkRenamedOptionModule [ "variables" "old" ] [ "variables" "new" ])` or
  # `(lib.mkRemovedOptionModule [ "variables" "gone" ] "<migration hint>")`
  # entry below.
  imports = [];

  # The `variables` contract every downstream fork depends on. The schema lives
  # here, NixOS-side; `hosts/<device>/variables.nix` is plain data checked
  # against it. Home-manager receives the resolved set as a passthrough
  # (`systemVariables`, see modules/core/user.nix + modules/home/variables.nix).
  options.variables = mkOption {
    description = "Host-specific variables (typed contract — see docs/adr/0003).";
    type = types.submodule ({config, ...}: {
      options = {
        # host identity
        profile = mkOption {
          type = types.str;
          description = "Driver/host bundle selected under ./profiles (e.g. \"nvidia\", \"amd\", \"vm\", \"iso\").";
        };
        user = mkOption {
          type = types.str;
          description = "Primary username for this host.";
        };
        sshAuthorizedKeys = mkOption {
          type = types.listOf types.str;
          default = [];
          description = "SSH public keys allowed to log in as the primary user on this host. Empty by default; each host opts in explicitly.";
        };

        # design mode (ADR-0005) — fast visual iteration on native UI files
        designMode = mkOption {
          type = types.bool;
          default = false;
          description = ''
            When true, design-mode UI configs (hyprland, quickshell, …) are
            installed via mkOutOfStoreSymlink pointing at the working tree, so
            edits are picked up by each tool's live reload with no rebuild. Only
            ever set on the active design machine — production hosts and all
            downstream forks must keep this false to stay pure/reproducible.
          '';
        };
        dotfilesPath = mkOption {
          type = types.str;
          default = "/home/${config.user}/.dotfiles";
          description = ''
            Absolute path to the checked-out dotfiles working tree, used as the
            mkOutOfStoreSymlink target when designMode is true. Only meaningful
            on the design machine.
          '';
        };

        # git config
        gitUsername = mkOption {
          type = types.str;
          description = "Git user.name used when pulling software repos.";
        };
        gitEmail = mkOption {
          type = types.str;
          description = "Git user.email used when pulling software repos.";
        };

        # hyprland display
        extraMonitorSettings = mkOption {
          type = types.listOf monitorType;
          description = "Per-monitor settings rendered into the hyprland Lua config. Each entry needs output/mode/position/scale.";
        };
        extraHardwareSettings = mkOption {
          type = types.attrs;
          default = {};
          description = "Freeform host hyprland hardware tweaks rendered as hl.config() sections (e.g. opengl, debug).";
        };
        defaultWallpaper = mkOption {
          type = types.str;
          default = "hollow-knight.png";
          description = "Wallpaper filename under ./wallpapers used by the gamemode script / swww.";
        };

        # theme
        theme = mkOption {
          type = types.str;
          default = "catppuccin-mocha";
          description = "Active palette name resolved by modules/core/palettes.nix.";
        };
        fontSizes = mkOption {
          default = {};
          description = "Font sizes per UI surface.";
          type = types.submodule {
            options = {
              applications = mkOption {
                type = types.int;
                default = 12;
                description = "Application font size.";
              };
              terminal = mkOption {
                type = types.int;
                default = 15;
                description = "Terminal font size.";
              };
              desktop = mkOption {
                type = types.int;
                default = 11;
                description = "Desktop/bar font size.";
              };
              popups = mkOption {
                type = types.int;
                default = 12;
                description = "Popup/notification font size.";
              };
            };
          };
        };

        # waybar config
        clock24h = mkOption {
          type = types.bool;
          default = true;
          description = "Use a 24-hour clock in waybar.";
        };

        # package toggle variables
        gamedev = mkOption {
          type = types.bool;
          default = false;
          description = "Install game-development packages.";
        };
        gaming = mkOption {
          type = types.bool;
          default = false;
          description = "Install gaming packages and enable related services (steam, joycond).";
        };
        texlive = mkOption {
          type = types.bool;
          default = false;
          description = "Install the TeX Live distribution.";
        };
        silly = mkOption {
          type = types.bool;
          default = false;
          description = "Install silly/novelty packages.";
        };

        # program options
        browser = mkOption {
          type = types.str;
          default = "zen";
          description = "Default browser command (e.g. \"zen\", \"google-chrome-stable\").";
        };
        terminal = mkOption {
          type = types.str;
          default = "kitty";
          description = "Default system terminal.";
        };
        keyboardLayout = mkOption {
          type = types.str;
          default = "";
          description = "X11/console keyboard layout (empty for default).";
        };
        consoleKeyMap = mkOption {
          type = types.str;
          default = "us";
          description = "Virtual-console keymap.";
        };
        editor = mkOption {
          type = types.str;
          default = "nvim";
          description = "Default editor command.";
        };
        EDITOR = mkOption {
          type = types.str;
          default = "nvim";
          description = "$EDITOR environment value.";
        };
        VISUAL = mkOption {
          type = types.str;
          default = "nvim";
          description = "$VISUAL environment value.";
        };

        # nvidia prime
        intelID = mkOption {
          type = types.nullOr types.str;
          default = null;
          description = "Intel GPU PCI bus ID for Nvidia Prime offload (e.g. \"PCI:1:0:0\").";
        };
        nvidiaID = mkOption {
          type = types.nullOr types.str;
          default = null;
          description = "Nvidia GPU PCI bus ID for Nvidia Prime offload (e.g. \"PCI:0:2:0\").";
        };

        # nfs support
        enableNFS = mkOption {
          type = types.bool;
          default = false;
          description = "Enable NFS support.";
        };

        # per-host scheduled jobs
        cronJobs = mkOption {
          type = types.listOf (types.submodule {
            options = {
              name = mkOption {
                type = types.str;
                description = "Unique identifier for this job; names the generated systemd unit as \"cronjob-<name>\".";
              };
              schedule = mkOption {
                type = types.str;
                description = "systemd OnCalendar expression (e.g. \"daily\", \"*-*-* 03:00:00\").";
              };
              command = mkOption {
                type = types.str;
                description = "Shell command to run.";
              };
              user = mkOption {
                type = types.nullOr types.str;
                default = null;
                description = "User to run the job as. Defaults to variables.user.";
              };
              description = mkOption {
                type = types.str;
                default = "";
                description = "Human-readable description for the generated systemd unit.";
              };
            };
          });
          default = [];
          description = "Per-host scheduled jobs, rendered as systemd timers (see modules/core/cron.nix). Empty by default; each host opts in explicitly.";
        };

        # derived theme values, set by modules/core/stylix.nix
        colors = mkOption {
          type = types.attrsOf types.str;
          default = {};
          internal = true;
          description = "base16 palette colors (\"#rrggbb\") injected from the active scheme.";
        };
        accent0 = mkOption {
          type = types.str;
          default = "";
          internal = true;
          description = "Primary accent color (hex, no leading #) from the active scheme.";
        };
        accent1 = mkOption {
          type = types.str;
          default = "";
          internal = true;
          description = "Secondary accent color (hex, no leading #) from the active scheme.";
        };
      };
    });
  };

  config.variables = hostVariables;
}
