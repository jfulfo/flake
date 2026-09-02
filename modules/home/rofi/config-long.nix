{mkDesignSource, ...}: {
  # Alternate vertical layout. Native rasi, symlinked to the working tree in
  # designMode (ADR-0005); rofi relaunches per-invocation so edits show on open.
  xdg.configFile."rofi/config-long.rasi".source = mkDesignSource {
    repo = "modules/home/rofi/config-long.rasi";
    store = ./config-long.rasi;
  };
}
