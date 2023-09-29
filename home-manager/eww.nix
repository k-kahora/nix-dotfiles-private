{pkgs, config, ...}:
let 
  ROOT = builtins.toString ./eww;
in
{ 
  programs.eww = {
    enable = true;
    configDir = ROOT;
  };
}

