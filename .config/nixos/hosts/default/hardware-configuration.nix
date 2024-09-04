# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.

{ config, lib, pkgs, modulesPath, ... }:

{

    imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
        
        ./../../modules/system
    ];

    boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" "nvidia_uvm" "nvidia_modeset" "nvidia_drm" "nvidia" ];
    boot.kernelParams = [ "nvidia-drm.modeset=1" ];
    boot.extraModulePackages = [ ];

    # Enable advanced nvidia graphics settings
    nvidia.enable = lib.mkDefault true;

    fileSystems."/" = {
        device = "/dev/disk/by-uuid/7cf79705-a467-4bd9-8aaa-41f815db17a8";
        fsType = "ext4";
    };

    swapDevices = [ ];

    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    networking.useDHCP = lib.mkDefault true;
    # networking.interfaces.enp7s0.useDHCP = lib.mkDefault true;
    # networking.interfaces.wlp0s20f0u1.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    # Enable bluetooth
    hardware.bluetooth.enable = true;

}
