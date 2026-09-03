{config, ...}: {
  xdg = {
    userDirs = {
      enable = true;
      setSessionVariables = true;
      createDirectories = true;
      pictures = "${config.home.homeDirectory}/pictures";
      desktop = "${config.home.homeDirectory}/desktop";
      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      music = "${config.home.homeDirectory}/music";
      videos = "${config.home.homeDirectory}/videos";
      projects = "${config.home.homeDirectory}/projects";
      publicShare = null;
      templates = null;
    };
  };
}
