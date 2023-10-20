{pkgs, config, ...}:
{
  programs.neovim = let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
	in {
	enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
	# Batterise incluede everything in this file will build a complete nvim environment
	extraPackages = with pkgs; [
	  wl-clipboard
	  xclip
	   
	  # Frequent lsps
	  luajitPackages.lua-lsp 
	  rnix-lsp

	];
    extraLuaConfig = ''
    ${builtins.readFile ./nvim/options.lua}
    '';
	plugins = with pkgs.vimPlugins; [
	   {
        plugin = nvim-lspconfig;
        config = toLuaFile ./nvim/plugin/lsp.lua;
      }

      {
        plugin = comment-nvim;
        config = toLua "require(\"Comment\").setup()";
      }

#     {
#       plugin = gruvbox-nvim;
#       config = "colorscheme gruvbox";
#     }

      neodev-nvim

      nvim-cmp 
      {
        plugin = nvim-cmp;
        config = toLuaFile ./nvim/plugin/cmp.lua;
      }

      {
        plugin = telescope-nvim;
        config = toLuaFile ./nvim/plugin/telescope.lua;
      }

      telescope-fzf-native-nvim

      cmp_luasnip
      cmp-nvim-lsp

      luasnip
      friendly-snippets


      lualine-nvim
      nvim-web-devicons

      {
        plugin = nvim-metals;
      }

      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
        ]));
        config = toLuaFile ./nvim/plugin/treesitter.lua;
      }

      vim-nix

        {
          plugin = own-onedark-nvim;
          config = "colorscheme onedark";
        }
    ];

  };
}
