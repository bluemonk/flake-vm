{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    inputs.flake-utils.lib.eachDefaultSystem (system: rec {
      nixosConfigurations.test = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs.inputs = inputs;
        modules = [
          ./configuration.nix
        ];
      };
      apps = {
        default = {
          type = "app";
          program = "${nixosConfigurations.test.config.system.build.vm}/bin/run-nixos-vm";
        };
      };
    });
}
