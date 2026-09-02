# modules/home/design.nix
#
# ADR-0005 design-mode plumbing. Exposes `mkDesignSource` to every home module
# as a `_module.args`, so native-UI modules can install a file two ways from one
# call site:
#
#   home.file."<dest>".source = mkDesignSource {
#     repo  = "modules/home/hyprland/config.lua"; # path within the working tree
#     store = ./config.lua;                       # the in-store copy
#   };
#
# - designMode = false (production hosts, every downstream fork): installs the
#   pure store copy — reproducible, no working-tree dependency.
# - designMode = true  (the one active design machine): installs an
#   out-of-store symlink to the working tree, so edits land live and each tool's
#   own reloader (hyprctl reload, quickshell's QML watcher, …) shows them with
#   no rebuild.
{
  config,
  lib,
  ...
}: {
  _module.args.mkDesignSource = {
    repo,
    store,
  }:
    if config.variables.designMode
    then config.lib.file.mkOutOfStoreSymlink "${config.variables.dotfilesPath}/${repo}"
    else store;
}
