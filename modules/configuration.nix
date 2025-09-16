{ lib, ... }:

{
  imports = [
    ./boot.nix
    ./time.nix
    ./nixos.nix
    ./services.nix
    ./zfs.nix
  ];

  # Hardware
  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;

  # Graphics acceleration
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # For Broadwell (2014) or newer processors. LIBVA_DRIVER_NAME=iHD
    ];
  };

  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };

  # Users
  users.mutableUsers = false;
  users.users."nick" = {
    isNormalUser = true;
    initialHashedPassword = "$y$j9T$8fEFURYXvsFCcIcPX5/4o0$U91T.17uI95SIWlerbecLpcek1VSEcYYrTH/2LDAJw.";
    extraGroups = [ "wheel" "libvirtd" ];
  };

  # Power management
  powerManagement.enable = true;
  services.thermald.enable = true;

  # Virtualisation
  virtualisation = {
    libvirtd.enable = true;

    containers.enable = true;

    podman = {
      enable = true;

      dockerCompat = true;

      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Networking
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;

  networking = {
    hostName = "milo"; # Define your hostname.
    hostId = "fff69420";
    useDHCP = lib.mkDefault true;
    networkmanager.enable = true;
  };
}