{ pkgs }:{
  pkgs.mkShell {
    name = "cpp-dev-shell";

    buildInputs = [
      pkgs.gcc
      pkgs.cmake
      pkgs.gdb
      pkgs.pkg-config
    ];

    shellHook = ''
      echo "C++ dev shell activated"
      export CC=gcc
      export CXX=g++
    '';
  }
}