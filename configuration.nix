# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... } :

{

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./packages.nix
      ./home.nix
      ./services.nix
    ];

  
  # Security
  security.rtkit.enable = true;

  # Disable Printing services
  services.printing.enable = false;

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
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  };

  # System State Version
  system.stateVersion = "24.11";

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking = {
    hostName = "nomad"; 
    useDHCP = lib.mkDefault true;
    networkmanager.enable = true;
    extraHosts = ''
      127.0.0.1 local.estrategia-sandbox.com.br
    '';
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

  # X11 and Desktop Environment
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "alt-intl";
  };

  # User Accounts
  users.users.pedrinho = {
    isNormalUser = true;
    description = "pedrinho";
    extraGroups = [ "networkmanager" "wheel" "docker" "adbusers" ];
    packages = with pkgs; [
      # Thunderbird
    ];
    shell = pkgs.zsh;
  };

  # Systemd Packages
  systemd.packages = with pkgs; [ cloudflare-warp ];

  # Programs
  programs = {
    firefox = {
      enable = true;
    };
    adb.enable = true;
    direnv.enable = true;
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
    };
    starship.enable = true;
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



  # XDG Portal
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Docker
  virtualisation.docker.enable = true;

  # Gnome Debloat
  # Exclude Core Apps From Being Installed.
  environment.gnome.excludePackages = with pkgs.gnome; [
    pkgs.epiphany
    pkgs.gedit
    pkgs.totem
    pkgs.yelp
    pkgs.geary
    pkgs.gnome-calendar
    pkgs.gnome-contacts
    pkgs.gnome-maps
    pkgs.gnome-music
    pkgs.gnome-photos
    pkgs.gnome-tour
    pkgs.evince
    pkgs.gnome-weather
    pkgs.gnome-clocks
    pkgs.gnome-characters
    pkgs.gnome-sound-recorder
    pkgs.gnome-logs
    pkgs.gnome-usage
    pkgs.simple-scan
    pkgs.gnome-software
  ];
}
