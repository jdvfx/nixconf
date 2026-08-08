{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11"; # Your stable version
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

  };
  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs: {
    nixosConfigurations = {
      thinkpad-nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          pkgs-unstable = nixpkgs-unstable.legacyPackages.x86_64-linux;
	  inherit inputs;
        };
        modules = [ ./configuration.nix ];
      };
    };
  };
}
