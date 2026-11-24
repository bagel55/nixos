{ config, pkgs, ... }:
{
  # Local LLM: llama.cpp server (Vulkan on the 7900 XT) + Open WebUI front end.
  # Drop .gguf files into /var/lib/llm-models (sudo); every model there shows up in Open WebUI.
  services.llama-cpp = {
    enable = true;
    package = pkgs.llama-cpp-vulkan; # swap to pkgs.llama-cpp-rocm to compare
    modelsDir = "/var/lib/llm-models";
    port = 8080;
    extraFlags = [ "-ngl" "99" "-c" "32768" "-ctk" "q8_0" "-ctv" "q8_0" ];
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/llm-models 0755 root root -"
  ];

  services.open-webui = {
    enable = true;
    port = 3000; # default 8080 clashes with llama-cpp
    environment = {
      SCARF_NO_ANALYTICS = "True";
      DO_NOT_TRACK = "True";
      ANONYMIZED_TELEMETRY = "False";
      OPENAI_API_BASE_URL = "http://127.0.0.1:8080/v1";
      OPENAI_API_KEY = "none";
      ENABLE_OLLAMA_API = "False";
      # Summarize older messages before the chat hits llama-cpp's 32k context
      ENABLE_CONTEXT_COMPACTION = "True";
      CONTEXT_COMPACTION_TOKEN_THRESHOLD = "24000";
      # Web search via local SearXNG (modules/searxng.nix)
      ENABLE_WEB_SEARCH = "True";
      WEB_SEARCH_ENGINE = "searxng";
      SEARXNG_QUERY_URL = "http://127.0.0.1:8888/search?q=<query>";
      # Image generation via local ComfyUI (modules/comfyui.nix)
      ENABLE_IMAGE_GENERATION = "True";
      IMAGE_GENERATION_ENGINE = "comfyui";
      COMFYUI_BASE_URL = "http://127.0.0.1:8188";
    };
  };
}
