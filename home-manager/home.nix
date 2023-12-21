
 #This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  nix-colors,
  rycee-nur-expressions,
  ...
}: {
  # You can import other home-manager modules here
	nixpkgs = {
    	overlays = [
      	(final: prev: {
		    # Put the vim plugins you want into the inputs
			# use the following format to extend vim plugins
        	vimPlugins = prev.vimPlugins // {
          	own-onedark-nvim = prev.vimUtils.buildVimPlugin {
            	name = "onedark";
            	src = inputs.plugin-onedark;
          	};
        	};
      	})
        (import inputs.emacs-overlay)
    	];
  	};
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./starship.nix
    ./hypr.nix
    #./zsh.nix
    ./fish.nix
    ./kitty.nix
    ./tmux.nix
    ./desktop.nix 
    ./rofi.nix
    ./git.nix
    ./scripts.nix
    # ./emacs.nix
    #./eww.nix
    ./firefox.nix
    ./nvim.nix
    ./lf.nix
    ./tofi.nix
    inputs.nix-colors.homeManagerModules.default
  ];

  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-hard;

  home.packages = with pkgs;[
  
    # Pixel are tool

    rofi-emoji
    tofi
    just # simpler make file I have a root justfile for nix commands I run alot
    pfetch
    nitch
    wl-clipboard
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellApplication {
    #   name = "show-nix-os.org";
    #   runtimeInputs = [curl w3m cowsay];
    #   text = ''
    #   curl -s 'https://nixos.org' | w3m -dump -T text/html | cowsay
    #   '';
    #  })
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    # TODO Havin shell set to fish makes projectile not work in emacs
    # Very werild
    # SHELL = "${pkgs.fish}/bin/fish";
  };

  nixpkgs = {
    # You can add overlays here
   #overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
   #  outputs.overlays.additions
   #  outputs.overlays.modifications
   #  outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
   #];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # TODO: Set your username
  home = {
    username = "malcolm";
    homeDirectory = "/home/malcolm";
  };


  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];
  

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;
  programs.direnv = {
    # enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
