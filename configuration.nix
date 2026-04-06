{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./aliases.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # fix T480 sleeping issue
  boot.kernelParams = [ "i915.enable_psr=0" ];

  networking.hostName = "thinkpad-nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;
  # bluetooth
  hardware.bluetooth.enable = false;

  # CUPS to print documents.
  # CVE: https://discourse.nixos.org/t/newly-announced-vulnerabilities-in-cups/52771
  services.printing.enable = false;

  # Wacom tablet
  services.xserver.wacom.enable = true;
  
  nix.settings.extra-experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "America/Vancouver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable the X11 windowing system.
  # needed for LightDM


services.xserver = {
  enable = true;
  displayManager = {
    lightdm = {
      enable = true;
      greeters.gtk = {
        enable = true;
        theme.package = pkgs.gnome-themes-extra;
        theme.name = "Adwaita-dark";
        iconTheme.package = pkgs.adwaita-icon-theme;
        iconTheme.name = "Adwaita";
      };
      background =
        pkgs.runCommand "my-wallpaper" {} ''
        mkdir -p $out
        cp ${./wallpaper.png} $out/wallpaper.png
        '' + "/wallpaper.png";
    };
  };
};


	#  services.xserver.enable = true;
	#
	#  services.xserver.displayManager.lightdm = {
	#    enable = true;
	#      greeters.gtk = {
	#        enable = true;
	#        theme.package = pkgs.flat-remix-gtk;
	#        theme.name = "Flat-Remix-GTK-Dark-Blue";
	#        iconTheme.package = pkgs.flat-remix-icon-theme;
	#        iconTheme.name = "Flat-Remix-Dark-Blue";
	#        background = "#000000"; # Or set to an absolute path for an image
	#        # background = pkgs.nixos-artwork.wallpapers.simple-dark-gray-bottom.gnomeFilePath;
	#     # background =
	#     # pkgs.runCommand "my-wallpaper" {} ''
	#     #   mkdir -p $out
	#     #   cp ${./wallpaper.png} $out/wallpaper.png
	#     #   '' + "/wallpaper.png";
	# };
	#
	#
	#
	#  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Adding fonts
  fonts.packages = with pkgs; [
    cascadia-code
  ];

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
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
  users.users.bunker = {
    isNormalUser = true;
    description = "bunker";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  # it's using Lightdm.
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    lm_sensors
    thinkfan
    htop
    alacritty
    xwayland-satellite
    neovim
    git
    stow
    gimp
    fuzzel
    tofi
    waybar
    swaybg
    feh
    evince
    brave
    ungoogled-chromium  
    vscodium
    gcc
    lf
    keepassxc
    python315
    gnome-terminal
    gedit
    psmisc #killall
    unzip #for nvim's stylua
    tree
  ];


  # # auto cleanup
  # nix.gc = {
  #   automatic = true;
  #   dates = "weekly";
  #   options = "--delete-older-than 20d";
  # };
  #
  # nix.optimise = {
  #   automatic = true;
  #   dates = ["weekly"];
  # };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


  # services.openssh.enable = true;

  # git over ssh(22), http(80), https(443)
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 ];
  };

  system.stateVersion = "25.11";

}
