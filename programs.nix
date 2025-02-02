{ pkgs, ... }:

{ 
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

    chromium.extensions = [
      pkgs.chromium-extensions.dark-reader
      pkgs.chromium-extensions.protonpass
    ];
  };
}