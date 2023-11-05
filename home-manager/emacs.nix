{pkgs, config, ...}:
{
  home.packages = [
    (pkgs.emacsWithPackagesFromUsePackage {
      package = pkgs.emacs-git;  # replace with pkgs.emacsPgtk, or another version if desired.
      config = ./config.org; # Org-Babel configs also supported

      # Optionally provide extra packages not in the configuration file.
      extraEmacsPackages = epkgs: [
        epkgs.use-package
        epkgs.magit
        epkgs.vterm
      ];

      # Optionally override derivations.
      override = epkgs: epkgs // {
        somePackage = epkgs.melpaPackages.somePackage.overrideAttrs(old: {
           # Apply fixes here
         });
       };
     })
   ];
 }
