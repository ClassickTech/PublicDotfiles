# Edit this configuration file to define what should be installed on your system.  Help is available in the 
# configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
  ];

 

  #Enable Sudo
  security.sudo.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 15; 
  boot.loader.efi.canTouchEfiVariables = true;

  # garbage collection
  nix.gc.automatic = true; 

    
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  swapDevices = [ {
      device = "/var/lib/swapfile";
      size = 16*1024;
    } ];



  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  }; 

     # Enable the X11 windowing system.
  services.xserver.enable = true;

     # Enable i3
  services.xserver.windowManager.i3.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

     # Enable the Cinnamon Desktop Environment.
     # services.xserver.desktopManager.cinnamon.enable = true;
      #services.xserver.displayManager.lightdm.enable = true;
     # Enable the GNOME Desktop Environment.
     #  services.xserver.displayManager.gdm.enable = true;
     # services.xserver.desktopManager.gnome.enable = true;
      
    # Set terminator as the default terminal
  environment.variables = {
   XDG_TERMINAL = "terminator";
  };     

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
    services.avahi.enable = true;
    services.avahi.nssmdns4 = true;
    services.avahi.openFirewall = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
   
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
   services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nixman = {
    isNormalUser = true;
    description = "nixman";
    extraGroups = [ "nixman" "networkmanager" "wheel" "scanner" "lp" "libvirtd" ];
    #subUidRanges = [{ startUid = 400000; count = 65536; }];
    #subGidRanges = [{ startGid = 400000; count = 65536; }];
    packages = with pkgs; [
        
    ];
  };

  users.groups.nixman = {
  gid = 1000;
};
     
  users.users.friends = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" ];
    packages = with pkgs; [
    
    ];
  };

  users.users.family = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" ];
    packages = with pkgs; [
    
    ];
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     bash
     brave
     chromium
     #distrobox
     home-manager
     vlc
     libinput
     libinput-gestures
     libnotify
     libreoffice-fresh
     libimobiledevice #iPhone
     ifuse # optional, to mount using 'ifuse' for iPhone
     
     # Some of my Bash Scripts Dependencies
     coreutils
     ffmpeg_7
     findutils
     gawk
     moreutils
     perl
     rclone
     rsync
     
     
];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };


services.cron.enable = true;
services.cron.systemCronJobs = [
    ''
    0 1,6,13,18 * * * nixman ~/.scripts/cronjobs/master.sh
    ''
    ''
    0 4 * * * nixman ~/.scripts/Big_Backups.sh 
    ''
    ''
    0 5 * * * root ~/.scripts/baikal.sh 
    ''
     # '' 
        # * * * * * nixman ${pkgs.bashInteractive}/bin/bash /mnt/12tb/TestStuff/cron/test.sh
        # '' # For Testing
];

  
  #services.sonarr.enable = true;
  #services.jellyfin.enable = true;
  #services.jackett.enable = true;
  services.flatpak.enable = true;
  #flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  services.openssh.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  services.tailscale.enable = true;
  services.prowlarr.enable = true;
  services.tailscale.useRoutingFeatures = "both"; 

   virtualisation.spiceUSBRedirection.enable = true;
  services.usbmuxd.enable = true;


  virtualisation.podman = {
    enable = true;
    autoPrune.enable = true;
    defaultNetwork.settings = {
      dns_enabled = true;
      ipv6_enabled = false;
    };
  };
  
  # Enable Docker or Podman
  virtualisation.docker.enable = true;
#  virtualisation.podman.enable = true;

# Enable these so Thunar preferences can stick
services.xserver.desktopManager.xfce.enable = true; 
services.xserver.desktopManager.xfce.noDesktop = true; 

 #  networking.firewall.allowedTCPPorts = [  631 9089 44 8096 8989 9117 6500 53317 9089 ];
 #  networking.firewall.allowedUDPPorts = [  631 9089 44 8096 8989 9117 6500 53317 9089 ];
  # Or disable the firewall altogether.
   networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
