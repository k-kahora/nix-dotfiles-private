
{pkgs, config, ...}:
{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    mouse = true;
    keyMode = "vi";
    shortcut = "Space";
    prefix = "c-a";
#   shell = "\${pkgs.zsh}/bin/zsh";
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.yank
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.catppuccin

    ];
    extraConfig = ''

    set-option -sa terminal-overrides ",xterm*:Tc"


    set -g @catppuccin_flavour 'mocha'

    bind-key -T copy-move-vi v send-keys -X begin-selection
    bind-key -T copy-move-vi C-v send-keys -X rectangle-toggle
    bind-key -T copy-move-vi y send-keys -X copy-selection-and-cancel


    # do not rename windows automaticly
    set-option -g allow-rename off


    unbind r
    bind r source-file ~/.config/tmux/tmux.conf

    # Shift + Alt to move through windows
    bind -n M-P previous-window
    bind -n M-N next-window

    bind '"' split-window -v -c "#{pane_current_path}"
    bind % split-window -h -c "#{pane_current_path}"

    '';
  };
}
