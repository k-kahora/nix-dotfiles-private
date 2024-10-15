
{pkgs, config, ...}:
{

  programs.fish.enable = true;
  programs.fish = {
    # functions = {
    #   nix-shell-expand = {
    #     body = ''
    #     set -l package (string trim (string replace -r 'nix-shell -p ' '' -- $argv))
    #     nix-shell -p $package --run fish
    #   '';
    #   };
    # };

    interactiveShellInit = ''
    ${pkgs.dwt1-shell-color-scripts}/bin/colorscript random
    # fish_vi_key_bindings
    # abbr -a 'nix-shell -p' nix-shell-expand
    # Allows vterm to have proper clear command when using fish
    set fish_greeting
    if [ "$INSIDE_EMACS" = 'vterm' ]
        function clear
            vterm_printf "51;Evterm-clear-scrollback";
            tput clear;
        end
    end
    # Run fish_key_reader then enter you keybindg to see how to bind a key to something
    # bind --erase \el
    # bind \el forward-char
    fish_vi_key_bindings 2>/dev/null
    set -x KEEPASSXC_DB "/home/malcolm/Documents/PassDatabase/Passwords.kdbx"
    '';
    shellAbbrs = {
      ll = "${pkgs.eza}/bin/eza -l --color=always  --group-directories-first";
      lt = "${pkgs.eza}/bin/eza -aT --color=always  --group-directories-first";
      la = "${pkgs.eza}/bin/eza -a --color=always  --group-directories-first";
      ls = "${pkgs.eza}/bin/eza -al --color=always  --group-directories-first";
      "l." = "${pkgs.eza}/bin/eza -al --color=always --group-directories-first $* | grep \"^\.\"";
      ".." = "cd ..";
      "emax" = "emacs --init-directory=~/nix-dotfiles/home-manager/emacs";
      "nixos-build" = "sudo nixos-rebuild switch --flake ~/nix-dotfiles/#myNixos";
      
      # Nix helpful command
      "edit" = "nix edit nixpkgs#bat";
      "nvim" = "nix run ~/Projects/blog-neovim-nix/ --";
      
      # fire command to make a directory on the tmp filesystem (On Ram so it gets reset)
      "burner" = "cd \"\$(mktemp -d)\"";
    };

  };
}
