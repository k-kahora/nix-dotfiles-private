{pkgs, config, ...}:
{
  programs.eww = {
    enable = true;
    configDirectory = ./;
  };
}
