{
description = "NixOS configuration for bagel";

inputs = {
  nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  home-manager.url = "github:nix-community/home-manager";
  home-manager.inputs.nixpkgs.follows = "nixpkgs";
  winboat.url = "github:TibixDev/winboat";
};

outputs = { self, nixpkgs, home-manager, winboat, ... }: {
  nixosConfigurations = {

    bagel-desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./configuration.nix
        ./modules/hosts/desktop/hardware-configuration.nix
        ./modules/hosts/desktop/driver-configuration.nix

        ({ pkgs, ... }: {
          environment.systemPackages = [
            pkgs.freerdp
            winboat.packages.x86_64-linux.winboat
          ];
        })

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
      ];
    };
  };
};
}
