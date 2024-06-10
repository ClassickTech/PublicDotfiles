{ config, pkgs, ... }:

{
  # TODO please change the username & home directory to your own
  home.username = "nixman";
  home.homeDirectory = "/home/nixman";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';
  

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 22;
   # "Xft.dpi" = 172;
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
      alacritty
      arandr    
      android-tools
      autokey
      acl
      brave
      bitwarden
      bottom
      cava
      cinnamon.nemo-with-extensions
      cloudflared
      cmatrix
      colorpicker
      discord
      distrobox
      element-desktop
      gnome.dconf-editor
      discord
      docker-compose
      dunst
      fastfetch
      feh
      ferdium
      firefox
      flameshot
      font-awesome
      fsearch
      gimp-with-plugins
      gnome.gnome-terminal
      gparted
      gpick
      glow
      gtk4
      haskellPackages.greenclip
      i3blocks
      i3lock
      i3status
      jellyfin
      jellyfin-ffmpeg
      jellyfin-web
      joplin-desktop
      lollypop #music
      lsof
      lxappearance
      megacmd
      microsoft-edge
      micro
      nerdfonts
      neofetch
      nitrogen
      normcap
      opera
      #pcmanfm
      picom
      playerctl
      #podman-compose
      #podman-desktop 
      protonvpn-gui      
      pyload-ng
      ranger
      rename
      rofi
      rustdesk-flutter
      scrot
      starship
      telegram-desktop
      terminator
      timeshift
      tmux
      toolbox
      trash-cli
      unzip
      vlc
      vscodium
      wmctrl
      xautolock
      xarchiver
      xclip
      xorg.xprop
      xdotool
      xorg.xev
      xorg.xhost
      xdg-desktop-portal
      xdg-desktop-portal-gtk
      xprintidle #for auto lock in i3
      xvfb-run
      yt-dlp
      wine
      # file managers
      xfce.thunar
      xfce.thunar-archive-plugin
      # lockscreens
      betterlockscreen      
      
  ];

  # basic configuration of git, please change to your own
  programs.bat = {
      enable = true;
      config = {
        theme = "GitHub";
        italic-text = "always";
      };    
  };
  
  programs.git = {
    enable = true;
    userName = "Nixman";
    userEmail = "git@nixos.us";
    };



 programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
     eval "$(${pkgs.starship}/bin/starship init bash)"
   '';
     # set some aliases, feel free to add more or remove some
     shellAliases = {
     ll = "ls -l";
     
   };
 };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

 # home.enableNixpkgsReleaseCheck = false;
}
