{pkgs, config, ...}:
{

  home.packages = with pkgs; [
    eza
    dwt1-shell-color-scripts
    zsh-powerlevel10k
  ];

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    plugins = [  {
      name = "powerlevel10k";
      src = pkgs.zsh-powerlevel10k;
      file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    }
    {
      name = "powerlevel10k-config";
      src = ./p10k-config;
      file = "p10k.zsh";
    }

  ];
    # Not sure the point of "$*" in the l. alias stole it from distro tubes config
    shellAliases = {
      ll = "${pkgs.eza}/bin/eza -l -color=always  --group-directories-first";
      lt = "${pkgs.eza}/bin/eza -aT --color=always  --group-directories-first";
      la = "${pkgs.eza}/bin/eza -a --color=always  --group-directories-first";
      ls = "${pkgs.eza}/bin/eza -al --color=always  --group-directories-first";
      "l." = "${pkgs.eza}/bin/eza -al --color=always --group-directories-first $* | grep \"^\.\"";
      ".." = "cd ..";
      "emax" = "emacs --init-directory=~/nix-dotfiles/home-manager/emacs";

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
${pkgs.dwt1-shell-color-scripts}/bin/colorscript random
#ZSH_THEME="refined"
REFINED_CHAR_SYMBOL="⚡"
'';
}
