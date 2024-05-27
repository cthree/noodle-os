# flake.nix
{
  description = "Star Citizen Flake and more";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";

    # ...

    nix-citizen.url = "github:LovingMelody/nix-citizen";

    # Optional - updates underlying without waiting for nix-citizen to update
    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-citizen.inputs.nix-gaming.follows = "nix-gaming";
  };

  outputs = {self, nixpkgs, ...}@inputs: {
    # NixOS Setup
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};

      modules = [
        ./configuration.nix
        # ....
      ];
    };

    # HomeManager...
    homeConfigurations.nixos = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };

      extraSpecialArgs = {inherit inputs;};
      modules = [
        ./home.nix
        # ...
      ];
    };
  };
}
