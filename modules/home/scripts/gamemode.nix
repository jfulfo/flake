{
  pkgs,
  config,
  ...
}: let
  inherit (config.variables) defaultWallpaper;
in
  # this script is sourced from JaKooLit's dotfiles:
  # https://github.com/JaKooLit/Hyprland-Dots/blob/main/config/hypr/scripts/GameMode.sh
  #
  # Adapted for the lua config (ADR-0005): `hyprctl keyword` is refused by the
  # lua parser ("keyword can't work with non-legacy parsers. Use eval.") and
  # still exits 0, so the original silently changed nothing — animations stayed
  # on, the toggle never saw its own effect, and every press re-entered the
  # "enable" branch. Runtime changes have to go through `hyprctl eval`.
  pkgs.writeShellScriptBin "gamemode" ''
    # `awww kill` returns before the daemon has released its socket, and `awww
    # img` spawns a daemon of its own when the socket is not answering yet;
    # either race ends in "instance already running on this socket" and no
    # wallpaper, so both transitions are waited out on `awww query`.
    # Match the daemon with a bare `pgrep`: these are Nix-wrapped binaries, so
    # the process name is `.awww-daemon-wr` (comm is capped at 15 chars) and
    # `pgrep -x awww-daemon` silently never matches.
    awww_stop() {
      pgrep awww-daemon >/dev/null || return 0
      awww kill
      for _ in 1 2 3 4 5 6 7 8 9 10; do
        awww query >/dev/null 2>&1 || return 0
        sleep 0.2
      done
    }

    awww_start() {
      awww_stop
      awww-daemon --format xrgb &
      for _ in 1 2 3 4 5 6 7 8 9 10; do
        awww query >/dev/null 2>&1 && return 0
        sleep 0.2
      done
    }

    # hyprctl prints `bool: true` since 0.5x; older builds printed `int: 1`.
    HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
    if [ "$HYPRGAMEMODE" = 1 ] || [ "$HYPRGAMEMODE" = true ]; then
      hyprctl eval 'hl.config({
        animations = { enabled = false },
        general    = { gaps_in = 0, gaps_out = 0, border_size = 0 },
        decoration = { rounding = 0, blur = { enabled = false }, shadow = { enabled = false } },
      })'
      hyprctl eval 'hl.window_rule({ name = "gamemode-opacity", opacity = "1.0 1.0", match = { class = "^(.*)$" } })'
      awww_stop
      pkill waybar
      notify-send "Gamemode: enabled"
    else
      # Re-running the declared config restores gaps/rounding/blur/shadow/
      # animations and drops the gamemode window rule, so the "off" values live
      # in config.lua only and cannot drift from this script.
      hyprctl reload
      awww_start
      awww img "$HOME/pictures/wallpapers/${defaultWallpaper}"
      pkill waybar
      sleep 0.3
      waybar &
      notify-send "Gamemode: disabled"
    fi
  ''
