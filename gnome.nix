{ config, pkgs, lib, ... } :

{
  # Desktop Environment
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "alt-intl";
  };

  services.gnome = {
    gnome-browser-connector.enable = true;
    gnome-remote-desktop.enable = false;
  };

  environment.systemPackages = with pkgs; [
    # Gnome Stuff
    desktop-file-utils
    gnome-extension-manager
    ghostty # due to gnome-terminal being removed

    # Extensions
    gnomeExtensions.just-perfection
    gnomeExtensions.caffeine
    gnomeExtensions.pano
    gnomeExtensions.appindicator
    gnomeExtensions.gsconnect
    gnomeExtensions.auto-power-profile        
    gnomeExtensions.tiling-assistant        
    gnomeExtensions.battery-health-charging
    gnomeExtensions.vertical-workspaces
    gnomeExtensions.tiling-shell
    gnomeExtensions.night-theme-switcher
    gnomeExtensions.battery-time
    gnomeExtensions.upower-battery
  ];

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
    pkgs.gnome-console
    pkgs.gnome-software
    pkgs.gnome-connections
    pkgs.gnome-text-editor
    pkgs.gnome-font-viewer
  ];
}
