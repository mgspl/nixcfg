{
  description = "digitalis";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    catppuccin.url = "github:catppuccin/nix";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    Akari.url = "github:mgspl/Akari";
    nixvim.url = "github:nix-community/nixvim";

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.1-1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      chaotic,
      lix-module,
      catppuccin,
      hyprpanel,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      username = "miguel";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        digitalis = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs username;
          };
          modules = [
            ./configuration.nix # Your system configuration.
            catppuccin.nixosModules.catppuccin # Export Catppuccin Module
            chaotic.nixosModules.default # Export Chaotic Module
            lix-module.nixosModules.default # Export LIX module
            # Home Manager Modules Config
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = {
                imports = [
                  ./home.nix
                  catppuccin.homeManagerModules.catppuccin
                  chaotic.homeManagerModules.default
                ];
              };
              home-manager.extraSpecialArgs = {
                inherit inputs;
                inherit system;
              };
              nixpkgs.overlays = [ inputs.hyprpanel.overlay ];
            }
          ];
        };
      };
    };
}
