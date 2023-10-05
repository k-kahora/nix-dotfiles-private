{pkgs, config, ...}:
{
  programs.emacs = {
    enable = true;
    packages = pkgs.emacs;
  };
}
