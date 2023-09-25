# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };


  # FIXME: Add the rest of your current configuration

  # Set your hostname
  networking.hostName = "nixos";

  # This is just an example, be sure to use whatever bootloader you prefer
  # boot.loader.systemd-boot.enable = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Configure your system-wide user settings (groups, etc), add more users as needed.
  users.users = {
    # FIXME: Replace with your username
    malcolm = {
      #  You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      initialPassword = "pass";
      isNormalUser = true;
      description = "Malcolm Kahora";
      openssh.authorizedKeys.keys = ["AAAAB3NzaC1yc2EAAAADAQABAAABgQC+8ML9DGcfSBXYIdrr5GvkFNGhF9Ha7igM2R3CpLUB+wx+sSJmHJYsTFIMOpWI9f+WNm8ZjSdo+6IfL2E/sWlxP9oCC5rZAdTat1eS0CIIAkfA83Z+tn8BVPcW2dr0pn1F1ddL0h+FDRMTexB9MK7QodcTRlN7U1z10xLBy1LK5IMh3hnOn7uC/q8lUeama0ApPoCjFonwepCzkGFQ9GUdetmlyPe/uzk76xHETTrfayh3cbA5DlGjvdlOq7C1137f2apLxZky4ux/Dy8H0GtmfJZB0fp3qoedsJbJz+/x3i8ZTjKCiId65Irb9tcCLayz3kh5Ts/ohkmoKr7VdkDTIHwkpa4fc+S3ulEjipAU5xlYFO67obuWWgXGrOTmxLRf4Rbeij6k7w7GbbkL41rTIPMGNT8IwcVdwYJ9TJwduSiESUH+a0mLz8U+SxJvXT4ZQO9gqsO2TzGEMNKYvzBYP7FcKHNI4Y0iRS3mksId48KxtkPVc+ySk5YdFyqf1zc="];
        # Add your SSH public key(s) here, if you plan on using SSH to connect
      #  Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = ["wheel networkmanager docker audio"];
    };
  };

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    # Forbid root login through SSH.
    settings = {
      PermitRootLogin = "yes" ;
      PasswordAuthentication = true;
    };
    # Use keys only. Remove if you want to SSH using password (not recommended)
  };

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [22];
    };
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
 };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # fonts.packages = with pkgs; [
  #   (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" "DroidSansMono" ]; })
  # ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";

  environment.systemPackages = with pkgs; [
    vim git waybar dunst libnotify swww kitty rofi-wayland just cliphist home-manager firefox
  ];

  programs.hyprland = {
    enable = true;
  };
}
