{profile, ...}: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      BROWSER = "zen";
      TERMINAL = "kitty";
    };

    initExtra = ''
      bindkey -s '\el' 'ls\n'
      bindkey -s '\e.' 'cd ..\n'
      bindkey -s '\ef' 'fastfetch\n'
      bindkey -s '\ec' 'clear\n'
      bindkey -s '\ey' 'yazi\n'
       if [ -f $HOME/.zshrc-personal ]; then
          source $HOME/.zshrc-personal
       fi
      pokeget shaymin --hide-name
    '';

    shellAliases = {
      sv = "sudo nvim";
      v = "nvim";
      c = "code";
      y = "yazi";

      fr = "nh os switch ~/.dotfiles --hostname ${profile}";
      fu = "nh os switch ~/.dotfiles --hostname ${profile} --update";
      zu = "sh <(curl -L https://gitlab.com/Zaney/zaneyos/-/raw/main/install-zaneyos.sh)";
      ncg = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
      cat = "bat";
      man = "BAT_THEME='default' batman";

      l = "eza --icons  -a --group-directories-first -1"; # EZA_ICON_SPACING=2
      ll = "eza --icons  -a --group-directories-first -1 --no-user --long";
      ls = "eza -a --icons";
      tree = "eza --icons --tree --group-directories-first";

      sdn = "shutdown now";
      rb = "reboot";

      # python
      piv = "python -m venv .venv";
      psv = "source .venv/bin/activate";

      # git
      g = "lazygit";
      ga = "git add";
      gaa = "git add --all";
      gs = "git status";
      gsw = "git switch";
      gb = "git branch";
      gm = "git merge";
      gd = "git diff";
      gpl = "git pull";
      gps = "git push";
      gpso = "git push origin";
      gcl = "git clone";
      gc = "git commit";
      gcm = "git commit -m";
      gcma = "git add --all && git commit -m";
    };
  };
}
