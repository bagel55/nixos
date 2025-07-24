{ pkgs }:

pkgs.mkShell {
  buildInputs = [
    pkgs.gcc
    pkgs.cmake
    pkgs.gdb
    pkgs.pkg-config
  ];

  shellHook = ''
    echo "🛠️  C++ dev shell activated"
    export CC=gcc
    export CXX=g++
  '';
}
