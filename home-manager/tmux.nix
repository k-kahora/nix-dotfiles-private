
{pkgs, config, ...}:
{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    shortcut = "Space";
#   shell = "\${pkgs.zsh}/bin/zsh";
  };
}
