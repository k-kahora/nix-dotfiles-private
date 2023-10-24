{pkgs, config, ...}:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29;
    extraPackages = epkgs: [epkgs.magit epkgs.evil];
  };
  services.emacs = {
    package = pkgs.emacs29;
    enable = true;
  };
}
