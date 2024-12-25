{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      test-vm = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./configuration.nix ];
      };
    in
    {
      apps.${system}.default = {
        type = "app";
        program = "${test-vm.config.system.build.vm}/bin/run-nixos-vm";        
      };
      defaultPackage.${system} = test-vm.config.system.build.vm;
    };
}
