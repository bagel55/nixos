{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable-small";

    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    nixos-cosmic.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixos-cosmic, home-manager, ... }: {
    nixosConfigurations = {

      bagel-desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          unstable = import nixpkgs-unstable {
            system = "x86_64-linux";
          };
        };

        modules = [
          ./configuration.nix
          ./modules/hosts/desktop/hardware-configuration.nix
          ./modules/hosts/desktop/driver-configuration.nix

          {
            nix.settings = {
              substituters = [ "https://cosmic.cachix.org/" ];
              trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
            };
          }
          nixos-cosmic.nixosModules.default

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

        specialArgs = {
          unstable = import nixpkgs-unstable {
            system = "x86_64-linux";
          };
        };

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