{

    description = "Nixos config flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

        home-manager = {
            url = "github:nix-community/home-manager/release-24.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        hyprland.url = "github:hyprwm/Hyprland";

        stylix.url = "github:danth/stylix/release-24.05";
    };

    outputs = { self, nixpkgs, ... }@inputs: {
        nixosConfigurations = {
            # default nixos configuration
            default = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit inputs; };
                modules = [
                    ./hosts/default/configuration.nix
                ];
            };
        };
    };

}
