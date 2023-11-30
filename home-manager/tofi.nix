{pkgs, config, ...}:
{ 
  programs.tofi = {
    enable = true;
  };
  home.file.".config/tofi/config".text = ''
  '';
}
