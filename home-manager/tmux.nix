
{pkgs, config, ...}:
{
  programs.tmux = {
    enable = true;
    mouse = true;
    keyMode = "vi";
    shortcut = "Space";
#   shell = "\${pkgs.zsh}/bin/zsh";
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.yank
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.catppuccin

    ];
    extraConfig = ''

    set-option -sa terminal-overrides ",xterm*:Tc"

    # Shift + Alt to move through windows
    bind -n M-H previous-window
    bind -n M-L next-window

    bind '"' split-window -v -c "#{pane_current_path}"
    bind % split-window -v -c "#{pane_current_path}"

    set -g @catppuccin_flavour 'mocha'

    bind-key -T copy-move-vi v send-keys -X begin-selection
    bind-key -T copy-move-vi C-v send-keys -X rectangle-toggle
    bind-key -T copy-move-vi y send-keys -X copy-selection-and-cancel

    '';
  };
}
