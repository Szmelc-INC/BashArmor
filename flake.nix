{
  description = "Improved fork of the Blind-Bash PHP-based bash obfuscation tool";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (pkgs: rec {
        bash-armor = pkgs.stdenv.mkDerivation {
          pname = "bash-armor";
          version = "0-unstable-${self.shortRev or self.dirtyShortRev or "dirty"}";
          src = ./.;
          dontBuild = true;
          installPhase = ''
            runHook preInstall
            install -Dm755 exec.sh $out/bin/bash-armor
            install -Dm644 exec.php $out/share/bash-armor/exec.php
            install -Dm644 .bin/* -t $out/share/bash-armor/.bin
            install -Dm644 LICENSE $out/share/licenses/bash-armor/LICENSE
            runHook postInstall
          '';
          postFixup = ''
            # wrapper expects exec.php in its CWD — point it at the share dir
            substituteInPlace $out/bin/bash-armor \
              --replace-fail 'php exec.php' 'cd $out/share/bash-armor && php exec.php'
            wrapProgram $out/bin/bash-armor --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.php pkgs.fzf pkgs.tree ]}
          '';
          nativeBuildInputs = [ pkgs.makeWrapper ];
          meta = {
            description = "PHP-based bash obfuscation tool (Blind-Bash fork)";
            homepage = "https://github.com/Szmelc-INC/BashArmor";
            license = pkgs.lib.licenses.mit;
            mainProgram = "bash-armor";
            platforms = pkgs.lib.platforms.linux;
          };
        };
        default = bash-armor;
      });

      apps = forAllSystems (pkgs: {
        default = {
          type = "app";
          program = "${self.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/bash-armor";
        };
      });
    };
}
