{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs }: {

        devShells.x86_64-linux.SP = nixpkgs.legacyPackages.x86_64-linux.stdenv.mkDerivation {
            name = "build";
            pname = "build";
            dontUnpack = true;
            installPhase = ''
                mkdir -p $out/bin
                cat > $out/bin/build << EOF
                    cmake -B build
                    cmake --build build
                    ctest --test-dir build
                EOF
                chmod +x $out/bin/build
            '';
        };

  };
}
