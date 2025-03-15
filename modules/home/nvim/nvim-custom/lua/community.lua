-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- Bars and Lines
  { import = "astrocommunity.bars-and-lines.smartcolumn-nvim" },
  -- Colorschemes
  { import = "astrocommunity.colorscheme.tokyodark-nvim" },
  { import = "astrocommunity.colorscheme.monokai-pro-nvim" },
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.colorscheme.sonokai" },
  { import = "astrocommunity.colorscheme.onedarkpro-nvim" },
  -- Comments
  { import = "astrocommunity.comment.ts-comments-nvim" },
  -- Completions
  { import = "astrocommunity.completion.cmp-emoji" },
  -- Diagnostics
  { import = "astrocommunity.diagnostics.lsp_lines-nvim" },
  -- Editing Support
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  { import = "astrocommunity.editing-support.refactoring-nvim" },
  { import = "astrocommunity.editing-support.zen-mode-nvim" },
  -- Git
  { import = "astrocommunity.git.blame-nvim" },
  { import = "astrocommunity.git.diffview-nvim" },
  -- Markdown and Latex
  { import = "astrocommunity.markdown-and-latex.peek-nvim" },
  { import = "astrocommunity.markdown-and-latex.vimtex" },
  -- Media
  { import = "astrocommunity.media.image-nvim" },
  -- Motion
  { import = "astrocommunity.motion.hop-nvim" },
  { import = "astrocommunity.motion.leap-nvim" },
  -- Language Packs
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.cmake" },
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.cs" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.haskell" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.java" },
  { import = "astrocommunity.pack.lean" },
  { import = "astrocommunity.pack.lua" },
  --{ import = "astrocommunity.pack.ocaml" },
  { import = "astrocommunity.pack.php" },
  { import = "astrocommunity.pack.ps1" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.ruby" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.sql" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.terraform" },
  { import = "astrocommunity.pack.typescript-all-in-one" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.zig" },
}
