{
  inputs = {
    # Whole system tracks nixos-unstable (rolling); home-manager master follows it.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      # One machine = one folder under ./modules/hosts/<name>
      mkHost = host: nixpkgs.lib.nixosSystem {
        inherit system;
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
