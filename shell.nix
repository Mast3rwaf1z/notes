let
    pkgs = import <nixpkgs> {};

    build-sp = pkgs.writeScriptBin "build-sp" ''
        cmake -B build
        cmake --build build
        ctest --test-dir build
    '';
in pkgs.mkShellNoCC {
    packages = with pkgs; [
        build-sp
        apache-jena
    ];
}
