{
  description = "Nixos config flake";
     
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    disko = {
      url = "github:nix-community/disko";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs:
  let 
    inherit (self) outputs;
  in {
    nixosConfigurations.ix = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs outputs; };
      modules = [
        inputs.disko.nixosModules.default
        (import ./modules/disko.nix { })

        ./modules/configuration.nix
      ];
    };
  };
}