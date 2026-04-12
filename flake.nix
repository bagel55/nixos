{
description = "NixOS configuration for bagel";

inputs = {
  nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  home-manager.url = "github:nix-community/home-manager";
  home-manager.inputs.nixpkgs.follows = "nixpkgs";
};

outputs = { self, nixpkgs, home-manager, ... }: {
  nixosConfigurations = {

    bagel-desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./configuration.nix
        ./modules/hosts/desktop/hardware-configuration.nix
        ./modules/hosts/desktop/driver-configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          
          home-manager.users.bagel = import ./modules/home.nix;
        }
      ];
    };

    bagel-laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./configuration.nix
        ./modules/hosts/laptop/hardware-configuration.nix
        ./modules/hosts/laptop/driver-configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          
          home-manager.users.bagel = import ./modules/home.nix;
        }
      ];
    };
  };
};
}
