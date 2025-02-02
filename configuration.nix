{ config, pkgs, lib, ... } :

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./packages.nix
      ./home.nix
      ./services.nix
      ./programs.nix
      ./work.nix
      ./kernel.nix
      ./battery.nix
      # ./ai.nix
      # ./howdy.nix

      # DE Picker (pick one)
      # ./kde.nix
      ./desktop-enviroments/gnome.nix
      # ./desktop-enviroments/cosmic.nix
    ];

  
  # Security
  security.rtkit.enable = true;

  # NIXOS STUFF
  # Garbage Collection
  nix.gc = {
    automatic = true;
    randomizedDelaySec = "14m";
    options = "--delete-older-than 10d";
  };

  # Unholy packages
  nixpkgs.config.allowUnfree = true;

  # Environment Variables
  environment.sessionVariables = {
    GTK_IM_MODULE = "cedilla";
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  };

  # System State Version
  system.stateVersion = "25.05";

  # ower management
  powerManagement.powertop.enable = true;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking = {
    hostName = "nomad"; 
    useDHCP = lib.mkDefault true;
    extraHosts = ''
      127.0.0.1 local.estrategia-sandbox.com.br
    '';

    networkmanager = {
      enable = true;
    };
  };

  # Time and Locale
  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Fonts
  fonts = {
    fontconfig.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
    ];
  };

  fonts.fontconfig.defaultFonts = {
    monospace = [ "fira-code" ];
    sansSerif = [ "noto-sans" ];
    serif = [ "noto-serif" ];
  };

  # XDG Portal
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Docker
  virtualisation.docker.enable = true;
}
