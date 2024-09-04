{ config, pkgs, lib, inputs, ... }:

{

    imports = [
        inputs.stylix.nixosModules.stylix
    ];

    options = {
        theme.enable = lib.mkEnableOption "enables stylix ricing module";
    };

    config = lib.mkIf config.theme.enable {

        # # Ricing NixOS Configuration using Stylix
        # Enable Stylix
        stylix.enable = true;

        # Set the colorscheme for the entire system
        stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
        # stylix.base16Scheme = "#${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";

        # Set the wallpaper
        stylix.image = /home/boole/.config/background;

        # Set the list of fonts, most appropriate font will be used based on situation
        stylix.fonts = {
            monospace = {
                package = pkgs.nerdfonts.override { fonts = ["Agave"]; };
                name = "Agave Nerd Font";
            };
            sansSerif = config.stylix.fonts.monospace;
            serif = config.stylix.fonts.monospace;
            emoji = config.stylix.fonts.monospace;
        };

        # Set the opacity for window types
        stylix.opacity = {
            applications = 1.0;
            terminal = 0.8;
            desktop = 0.8;
            popups = 0.8;
        };

        # Select a theme polarity for the entire system
        stylix.polarity = "either"; # "light", "dark", or "either"

        # Target gnome to work
        stylix.targets = {
            gnome.enable = true;
        };

        # Setting up cursor theme
        stylix.cursor.package = pkgs.capitaine-cursors;
        stylix.cursor.name = "capitaine-cursors";

    };

}
