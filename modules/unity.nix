{ config, pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.writeShellApplication {
      name = "unity-vulkan";

      runtimeInputs = [
        pkgs.unityhub
      ];

      text = ''
        editor="$HOME/Unity/Hub/Editor/6000.3.9f1/Editor/Unity"

        if [ ! -x "$editor" ]; then
          echo "Unity editor not found: $editor" >&2
          exit 1
        fi

        exec unityhub-fhs-env "$editor" \
          -force-vulkan \
          "$@"
      '';
    })
  ];
}