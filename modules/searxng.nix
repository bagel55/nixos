{ config, pkgs, lib, ... }:
{
  # Self-hosted SearXNG on localhost:8888 — used by Brave (custom search engine)
  # and Open WebUI's built-in web search. Localhost only, so the limiter/bot
  # protection (and its Valkey/Redis) is left off.
  services.searx = {
    enable = true;
    package = pkgs.searxng;
    environmentFile = "/var/lib/searx-secret/env";
    settings = {
      server = {
        bind_address = "127.0.0.1";
        port = 8888;
        secret_key = "$SEARX_SECRET_KEY";
        limiter = false;
      };
      search.formats = [ "html" "json" ]; # json is needed by Open WebUI
    };
  };

  # Generate the secret key once, outside the Nix store.
  systemd.services.searx-secret = {
    description = "Generate SearXNG secret key";
    wantedBy = [ "multi-user.target" ];
    before = [ "searx-init.service" "searx.service" ];
    requiredBy = [ "searx-init.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      StateDirectory = "searx-secret";
      StateDirectoryMode = "0700";
    };
    script = ''
      f=/var/lib/searx-secret/env
      if [ ! -s "$f" ]; then
        umask 077
        echo "SEARX_SECRET_KEY=$(${pkgs.openssl}/bin/openssl rand -hex 32)" > "$f"
      fi
    '';
  };
}
