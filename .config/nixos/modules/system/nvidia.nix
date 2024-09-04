{ config, lib, pkgs, ... }:

{
    options = {
        nvidia.enable = lib.mkEnableOption "enables nvidia module";
    };


    config = lib.mkIf config.nvidia.enable {
        hardware.opengl = {
            enable = true;
            driSupport = true;
            driSupport32Bit = true;
        };

        environment.sessionVariables = {
            # If your cursor becomes invisible
            WLR_NO_HARDWARE_CURSORS = "1";
            # Hint electron apps to use wayland
            NIXOS_OZONE_WL = "1";
        };

        environment.systemPackages = with pkgs; [
            libva-utils vdpauinfo
            vulkan-tools vulkan-validation-layers
            libvdpau-va-gl egl-wayland wgpu-utils mesa libglvnd libGL
            nvtopPackages.nvidia nvitop
        ];

        services.xserver = {
            enable = true;
            videoDrivers = [ "nvidia" ];
            displayManager.gdm.enable = true;
            desktopManager.gnome.enable = true;
        };

        hardware.nvidia = {
            forceFullCompositionPipeline = true;
            modesetting.enable = true;
            powerManagement.enable = true;
            powerManagement.finegrained = false;
            open = false;
            nvidiaSettings = true;
            package = config.boot.kernelPackages.nvidiaPackages.production;
        };
    };
}
