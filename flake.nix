{
  description = "digitalis";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    #nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    catppuccin.url = "github:catppuccin/nix";
    hyprland.url = "github:hyprwm/Hyprland";
    betterfox.url = "github:HeitorAugustoLN/betterfox-nix";
    nix-proton-cachyos.url = "github:kimjongbing/nix-proton-cachyos";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    #nixpkgs-stable,
    chaotic,
    lix-module,
    catppuccin,
    home-manager,
    betterfox,
    ...
  } @ inputs: let
    username = "miguel";
    prettyname = "Miguel";
  in {
    nixosConfigurations = {
      digitalis = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs username;
        };
        modules = [
          ./configuration.nix # Your system configuration.
          {nixpkgs.hostPlatform = "x86_64-linux";}
          catppuccin.nixosModules.catppuccin # Export Catppuccin Module
          chaotic.nixosModules.default # Export Chaotic Module
          lix-module.nixosModules.default # Export LIX module
          # Home Manager Modules Config
          home-manager.nixosModules.home-manager
          {
            #home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "bkp";
            home-manager.users.${username} = {
              imports = [
                ./home.nix
                catppuccin.homeManagerModules.catppuccin
                chaotic.homeManagerModules.default
                # nvf.homeManagerModules.default # Export NvF module
              ];
            };
            home-manager.extraSpecialArgs = {
              inherit inputs;
              inherit username;
              inherit prettyname;

              /*
                pkgs-stable = import nixpkgs-stable {
                inherit system;
                config.allowUnfree = true;
              };
              */
            };
          }
        ];
      };
    };
  };
}
