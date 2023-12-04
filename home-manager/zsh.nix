{pkgs, config, ...}:
{
  home.packages = with pkgs; [ eza ];
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    oh-my-zsh = {
      enable = true;
      theme = "avit";
      plugins = [
        "git"
        "direnv"
      ];
    };
    shellAliases = {
      ll = "${pkgs.eza}/bin/eza -l --color=always  --group-directories-first";
      lt = "${pkgs.eza}/bin/eza -aT --color=always  --group-directories-first";
      la = "${pkgs.eza}/bin/eza -a --color=always  --group-directories-first";
      ls = "${pkgs.eza}/bin/eza -al --color=always  --group-directories-first";
      "l." = "${pkgs.eza}/bin/eza -al $* | grep \"^\.\" --color=always  --group-directories-first";
      ".." = "cd ..";

    };
    envExtra = ''
    export ZSHVAR="Hello Person"
    export ZVM_VI_EDITOR="nvim"
    '';
    initExtra = ''
       source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    '';
  };
  home.file.".zshrc".text = ''
#ZSH_THEME="refined"
REFINED_CHAR_SYMBOL="⚡"
'';
}
