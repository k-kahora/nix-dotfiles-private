{pkgs, config, ...}:
{ 
  programs.desktop = {

  enable = true;
  entries = [

    {
      name = "Emax Client";
      exec = "/run/current-system/sw/bin/emacsclient -c";
      categories = [ "Utility" ];
    }
    {
      name = "Emax Daeomn";
      exec = "/run/current-system/sw/bin/emacs --init-directory=/home/malcolm/nix-dotfiles/home-manager/emacs --fg-daemon";
      categories = [ "Utility" ];
    }
  ];
  };
}
