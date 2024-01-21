# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ self, config, pkgs, inputs, nixos-unstable, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
      inputs.impermanence.nixosModules.impermanence
    ];
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users."malcolm" = import ../home-manager/home.nix;
  };

  # Use systemd boot (EFI only)
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use the GRUB 2 boot loader (Both EFI and legacy boot supported).
  boot.loader.grub.enable = true;

  # This is for GRUB in EFI mode
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  networking.hostName = "Nukeproof";
  networking.networkmanager.enable = true;
  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  
  # Docker 
  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [ "malcolm" ];
  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the Plasma 5 Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
  

  # Gnome
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  # Remvove the bullshit
  environment.gnome.excludePackages = (with pkgs; [
  gnome-photos
  gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    gnome-terminal
    gedit # text editor
    epiphany # web browser
    geary # email reader
    evince # document viewer
    gnome-characters
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);
  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;
  # TODO   
  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  nixpkgs.config.pulseaudio = true;
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;
  users.users.root.initialPassword = "hunter2";
  users.users."malcolm".initialPassword = "pass";
  users.users."malcolm".extraGroups = ["wheel"];
  users.users."malcolm".isNormalUser = true;
  # users.users.alice = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     firefox
  #     tree
  #   ];
  # };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    firefox
    unzip
    gcc # This is installed globaly as temp fix to compile treesitter grammars
    	# Have not packaged the grammars myself NOTE good idea to do that
    zip
    direnv
    gtk3 # Needed to use emacs as my run launcher
    ripgrep
    discord
    # Pixel art
    aseprite
    
    # Gnome externsions
    # gnomeExtensions.pop-shell was trying this out thought it was trash

    # For my quantom keyboards
    qmk
    
    
    # bought font called comic code
    (callPackage ./comic-code.nix {})

    killall # Type killall emacs to get rid of all emacs processec
    wpa_supplicant # Need this to connect to eduroam via cmdline
    (pkgs.emacsWithPackagesFromUsePackage {
      package = pkgs.emacs-git;  # replace with pkgs.emacsPgtk, or another version if desired.
      config = ./config.org; # Org-Babel configs also supported

      defaultInitFile = false;
      # alwaysEnsure = true;

      # Optionally provide extra packages not in the configuration file.
      extraEmacsPackages = epkgs: [
        epkgs.diminish
        epkgs.ligature
	epkgs.perspective

	# Themes
	epkgs.doom-themes
	epkgs.doom-modeline
	epkgs.nimbus-theme
	epkgs.ef-themes
	
        # Style
	epkgs.rainbow-delimiters
	
        # Development
 	epkgs.lsp-bridge
    	epkgs.lsp-mode
    	epkgs.tree-sitter-langs
    	epkgs.tree-sitter
	epkgs.company
	epkgs.chatgpt-shell
	# Ocaml dev
    	epkgs.tuareg
	epkgs.merlin
	epkgs.merlin-eldoc
	epkgs.flycheck-ocaml

        epkgs.use-package
        epkgs.magit # TODO
	epkgs.git-timemachine
        epkgs.eat
        epkgs.vterm-toggle
	
        # Evil mode
        epkgs.evil
	    epkgs.evil-commentary
        epkgs.evil-collection
	    epkgs.evil-goggles

        epkgs.avy # Unbeliavle movement great avy article
	# https://karthinks.com/software/avy-can-do-anything/

        epkgs.rainbow-delimiters
        epkgs.org-roam # TODO
        epkgs.company
        epkgs.dashboard # TODO
        epkgs.projectile # TODO
        epkgs.dired-open # TODO
	epkgs.envrc
        epkgs.dired-preview # TODO
        epkgs.elfeed # TODO
	    epkgs.hl-todo
        epkgs.general
        epkgs.which-key
        epkgs.hydra
        epkgs.vertico
	# epkgs.markdown-mode alread build into emacs 30
        epkgs.orderless
        epkgs.eshell-toggle
        epkgs.all-the-icons
        epkgs.all-the-icons-dired
        epkgs.eshell-syntax-highlighting
      ];

      # alwaysEnsure = true;

      # Optionally override derivations.
      override = epkgs: epkgs // {
        somePackage = epkgs.melpaPackages.somePackage.overrideAttrs(old: {
           # Apply fixes here
         });
       };
     })
    # (emacs-overlay.emacsWithPackagesFromUsePackage {
    #   config = /home/malcolm/nix-dotfiles/home-manager/emacs.el;
    #   alwaysEnsure = t;
    #
    # })
  ];

  environment.persistence."/nix/persist" = {
    directories = [
      "/etc/nixos"
      "/etc/NetworkManager/system-connections"
    ];
    files = [
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
    ];
    users."malcolm" = {
      directories = [
       "Documents"
       "Desktop"
       "org-roam"
       "Pictures"
       "nix-dotfiles"
       
       # Fish history
       ".local/share/fish"
       
       # STATEFUL 
       ".config/doom" # This is temporary while I figure out what I need to do make a custom emacs    
       ".config/emacs" # ^
       #".emacs.d"
       # STATEFUL ^


       "Projects"
       "clones"
       { directory = ".ssh"; mode = "0700"; }
      ];
      # This is temporary until I set up emacs on home manager
      # When doing files in the home directory set them up so the 
      
      # Using the file attribute does not seem to work.
      # user is <user> it defaults to root
      files = [".authinfo"];
      # files = [{file = ".local/share/fish/fish_history"; }];

    };
  };
  programs.hyprland.enable = true;
  programs.nm-applet.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

# MY ADDITIONS
# Unfree software 
  nixpkgs.overlays = [(import inputs.emacs-overlay)];
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes" ];


  fonts.packages = with pkgs; [

    (nerdfonts.override { fonts = [ "FiraCode" "Iosevka" "Ubuntu"]; })
    emacs-all-the-icons-fonts
    jetbrains-mono
    victor-mono
    cascadia-code
    
  ];
  
  # Limit the number of configurations with with NixOS
  
  # boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.grub.configurationLimit = 20;

  # Perform garbage collection weekly to maintain low disk usage
  #nix.gc = {
  #  automatic = true;
  #  dates = "weekly";
  #  options = "--delete-older-than 1w";
  #};

  # Optimize storage
  # You can also manually optimize the store via:
  #    nix-store --optimise
  # Refer to the following link for more details:
  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
  # nix.settings.auto-optimise-store = true;
  
  # If you want nix shell and nix run to use the same nixos as this flake 
  # nix.registry.nixpkgs.flake = nixos-unstable;
  # Channels are never used we use flakes
  # nix.channel.enable = false;
  # With nix channel disabled you no longer have acess to the $NIX_PATH
  # This means you must use things such as nix reply -f flake:nixpkgs

}

