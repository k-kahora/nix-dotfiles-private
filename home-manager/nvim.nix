{pkgs, config, ...}:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    exatraLuaConfig = ''
    ${builtins.readFile ./nvim/options.lua}
    '';
  };
}
