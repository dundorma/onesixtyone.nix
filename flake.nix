
{
  description = "Nix package for the onesixtyone SNMP scanner";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          default = pkgs.stdenv.mkDerivation {
            pname = "onesixtyone";
            version = "unstable-2025-08-31";

            src = pkgs.fetchFromGitHub {
              owner = "trailofbits";
              repo = "onesixtyone";
              rev = "3bedd7cab7fe1bcfc2def208f87fbf10a013efc7";
              hash = "sha256-9gvulDEaEFZdGl/x5oNHTuMNbBK56dgOydQRyzGO29Q=";
            };

            nativeBuildInputs = [ pkgs.gnumake ];

            buildPhase = ''
              runHook preBuild
              make
              runHook postBuild
            '';

            installPhase = ''
              runHook preInstall

              install -Dm755 onesixtyone \
                "$out/bin/onesixtyone"

              install -Dm644 dict.txt \
                "$out/share/onesixtyone/dict.txt"

              runHook postInstall
            '';

            meta = {
              description = "Fast SNMP scanner";
              homepage = "https://github.com/trailofbits/onesixtyone";
              license = pkgs.lib.licenses.gpl2Only;
              mainProgram = "onesixtyone";
              platforms = pkgs.lib.platforms.unix;
            };
          };
        });
    };
}

