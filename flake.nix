{
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    catppuccin.url = "github:catppuccin/nix";
    nix-proton-cachyos.url =
      "github:jbgi/nix-proton-cachyos?rev=58a15c234eb69acd16b9860e1a7da48562b5f784";
    betterfox.url = "github:HeitorAugustoLN/betterfox-nix";

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lix-module = {
      url =
        "https://git.lix.systems/lix-project/nixos-module/archive/2.93.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    ez-configs = {
      url = "github:ehllie/ez-configs";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ inputs.ez-configs.flakeModule ];
      systems = [ "x86_64-linux" ];

      ezConfigs = {
        root = ./.;
        globalArgs = { inherit inputs; };
        nixos.hosts.digitalis.userHomeModules = { miguel = "miguel"; };
      };
    };
}
