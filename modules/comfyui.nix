{ comfyui-nix, ... }:
{
  # ComfyUI on localhost:8188 (ROCm on the 7900 XT), from github:utensils/comfyui-nix.
  # Models, outputs and UI-installed nodes live in /var/lib/comfyui (state, not config).
  # Open WebUI sends image requests here (see local-llm.nix).
  imports = [ comfyui-nix.nixosModules.default ];

  services.comfyui = {
    enable = true;
    gpuSupport = "rocm";
    enableManager = true; # built-in ComfyUI Manager, for downloading models/nodes from the UI
    port = 8188;
    listenAddress = "127.0.0.1";
  };

  # Prebuilt ComfyUI/PyTorch binaries, so the rebuild doesn't compile them.
  nix.settings = {
    extra-substituters = [ "https://comfyui.cachix.org" ];
    extra-trusted-public-keys = [ "comfyui.cachix.org-1:33mf9VzoIjzVbp0zwj+fT51HG0y31ZTK3nzYZAX0rec=" ];
  };
}
