{pkgs, config, ...}:
{
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
      ll = "ls -l";
      ".." = "cd ..";
    };
    envExtra = ''
    export ZSHVAR="Hello Person"
    '';
  };
  home.file.".zshrc".text = ''


#ZSH_THEME="refined"
REFINED_CHAR_SYMBOL="⚡"




'';
}
