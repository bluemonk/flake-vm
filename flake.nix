{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
    in
    {
      # test is a hostname for our machine
      nixosConfigurations.test = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
        ];
      };
      apps = rec {
        default = test;
        test = {
          type = "app";
          program = "${nixosConfigurations.test.config.system.build.vm}/bin/run-nixos-vm";
        };
      };
    };
}
