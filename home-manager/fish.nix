
{pkgs, config, ...}:
{

  programs.fish.enable = true;
  programs.fish = {

    interactiveShellInit = ''
    ${pkgs.dwt1-shell-color-scripts}/bin/colorscript random
    fish_vi_key_bindings
    '';
    shellAbbrs = {
      ll = "${pkgs.eza}/bin/eza -l -color=always  --group-directories-first";
      lt = "${pkgs.eza}/bin/eza -aT --color=always  --group-directories-first";
      la = "${pkgs.eza}/bin/eza -a --color=always  --group-directories-first";
      ls = "${pkgs.eza}/bin/eza -al --color=always  --group-directories-first";
      "l." = "${pkgs.eza}/bin/eza -al --color=always --group-directories-first $* | grep \"^\.\"";
      ".." = "cd ..";
      "emax" = "emacs --init-directory=~/nix-dotfiles/home-manager/emacs";
    };

  };
}
