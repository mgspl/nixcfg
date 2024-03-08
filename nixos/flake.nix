{
  description = "digitalis";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    #chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    chaotic.url = "https://flakehub.com/f/chaotic-cx/nyx/*.tar.gz";
    hyprland.url = "github:hyprwm/Hyprland";
    ags.url = "github:Aylur/ags";
  };

  outputs = { nixpkgs, chaotic, ... } @inputs: let
    system = "x86_64-linux";
    username = "miguel";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    asztal = pkgs.callPackage ./greeter { inherit inputs; };
    in {
    nixosConfigurations = {
      digitalis = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs username asztal; };
        modules = [
          ./configuration.nix # Your system configuration.
          chaotic.nixosModules.default # OUR DEFAULT MODULE
        ];
      };
    };
  };
}
