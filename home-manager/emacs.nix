{pkgs, config, rycee-nur-expressions, ...}:
let
  nurNoPkgs = rycee-nur-expressions
  
in 
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
