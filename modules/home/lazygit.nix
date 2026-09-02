{pkgs, ...}: let
  # The drafting instructions live in their own file so the script can `cat` them
  # — avoids shell-quoting the backticks/`$` in the prompt. Mirrors the commit
  # convention enforced by cog (see cog.toml / docs/adr/0002): breaking changes
  # get `!` plus a `BREAKING CHANGE:` footer with the downstream migration step.
  commitPrompt = pkgs.writeText "suggest-commit-prompt.md" ''
    You are writing ONE git commit message for the staged diff provided on stdin.

    Rules:
    - Follow Conventional Commits: `type(optional-scope): summary`. Imperative
      mood, lower-case summary, no trailing period, keep the subject <= 72 chars.
    - Allowed types: feat, fix, docs, refactor, chore, test, build, ci, perf, style.
    - This repo is consumed by downstream forks. If the change breaks the
      documented `variables` contract OR moves/renames/removes a module file,
      it is BREAKING: append `!` after the type/scope AND add a trailing
      `BREAKING CHANGE: <what changed and the exact migration step a fork must take>`
      footer. Otherwise add no such footer.
    - Add a short body only when it carries real information the subject cannot.
    - Output ONLY the raw commit message: no code fences, no preamble, no quotes.
  '';

  # Drafts a message, then drops you into $EDITOR (nvim) on it via `git commit
  # --edit`. cog's commit-msg hook validates whatever you save, so a bad draft
  # can never land a non-conforming commit. Degrades gracefully without `claude`.
  suggestCommit = pkgs.writeShellScriptBin "git-suggest-commit" ''
    set -eu

    if ! command -v claude >/dev/null 2>&1; then
      echo "git-suggest-commit: 'claude' CLI not on PATH; commit normally with c/C." >&2
      exit 1
    fi

    if git diff --cached --quiet; then
      echo "git-suggest-commit: nothing staged. Stage changes (space) then retry." >&2
      exit 1
    fi

    tmp=$(mktemp)
    trap 'rm -f "$tmp"' EXIT

    prompt="$(cat ${commitPrompt})

    Recent subject lines in this repo, for style reference:
    $(git log -n 10 --format='%s' 2>/dev/null || true)"

    if ! git diff --cached | head -c 120000 | claude -p --model haiku "$prompt" > "$tmp"; then
      echo "git-suggest-commit: claude failed; opening an empty editor instead." >&2
      : > "$tmp"
    fi

    git commit --edit --file "$tmp"
  '';
in {
  home.packages = with pkgs; [lazygit suggestCommit];

  xdg.configFile."lazygit/config.yml".text = ''
    gui:
        border: single
    customCommands:
        - key: '<c-g>'
          context: 'files'
          description: 'AI: draft a conventional-commit message, then edit'
          command: 'git-suggest-commit'
          output: terminal
  '';
}
