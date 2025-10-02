{
  description = "SuprLab: The ultimate portable lab";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };
  outputs = { self, nixpkgs }: 
    let
      systems = nixpkgs.lib.systems.flakeExposed;
    in
    {
      devShells = nixpkgs.lib.genAttrs systems (system: {
        default = 
          let
            pkgs = nixpkgs.legacyPackages.${system};
          in
          pkgs.mkShell {
            inherit (import ./suprshell.nix { inherit pkgs; }) buildInputs shellHook;
          };
      });
    };
}

