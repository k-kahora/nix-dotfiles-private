
{pkgs, config, ...}:
{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
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

    set -g @catppuccin_flavour 'mocha'

    bind-key -T copy-move-vi v send-keys -X begin-selection
    bind-key -T copy-move-vi C-v send-keys -X rectangle-toggle
    bind-key -T copy-move-vi y send-keys -X copy-selection-and-cancel


    # do not rename windows automaticly
    set-option -g allow-rename off


    unbind r
    bind r source-file ~/.config/tmux/tmux.conf


    # pane bindings mirror emacs
    
    unbind '"'
    unbind %
    unbind s
    unbind R
    unbind ,
    
    bind s split-window -h -c "#{pane_current_path}"
    bind v split-window -v -c "#{pane_current_path}"
    bind , list-sessions
    # bind-key R rename-window 
    
    # ergo pane switching

    bind -n M-n select-pane -L
    bind -n M-o select-pane -R
    bind -n M-i select-pane -U
    bind -n M-a select-pane -D

    '';
  };
}
