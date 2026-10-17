{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable-small";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      system = "x86_64-linux";
      unstable = import nixpkgs-unstable { inherit system; };

      # One machine = one folder under ./modules/hosts/<name>
      mkHost = host: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit unstable; };

        modules = [
          ./configuration.nix
          ./modules/hosts/${host}/hardware-configuration.nix
          ./modules/hosts/${host}/driver-configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.bagel = import ./modules/home.nix;
          }
        ];
      };
    in {
      nixosConfigurations = {
        bagel-desktop-nixos = mkHost "desktop";
        bagel-laptop-nixos = mkHost "laptop";
      };
    };
}
