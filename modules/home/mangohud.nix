{ lib, ... }:
let
  # Right Shift + F12 cycles: off -> Minimal -> Standard -> Full -> off.
  #
  # How MangoHud combines things: the active preset is applied first and
  # MangoHud.conf is applied on top of it. So MangoHud.conf below only holds
  # keybinds, behaviour and styling; everything that appears on screen is
  # defined per preset in presets.conf.

  # Same rendering home-manager uses for MangoHud.conf
  # (true -> "key", false -> "key=0", lists -> "a,b").
  render = attrs: lib.concatStringsSep "\n" (lib.mapAttrsToList (k: v:
    if v == true then k
    else if v == false then "${k}=0"
    else if lib.isList v then "${k}=${lib.concatMapStringsSep "," toString v}"
    else "${k}=${toString v}") attrs);

  presets = {
    # 1 - Minimal: what you want while just playing
    "1" = {
      hud_compact = true;
      fps = true;
      frametime = true;
      frame_timing = false;
      gpu_stats = true;
      gpu_temp = true;
      gpu_junction_temp = true;
      cpu_stats = true;
      cpu_temp = true;
    };

    # 2 - Standard: performance at a glance
    "2" = {
      fps = true;
      fps_metrics = "avg,0.01";
      frametime = true;
      frame_timing = true;

      gpu_stats = true;
      gpu_temp = true;
      gpu_junction_temp = true;
      gpu_core_clock = true;
      gpu_power = true;
      gpu_power_limit = true;
      gpu_fan = true;
      vram = true;

      cpu_stats = true;
      cpu_temp = true;
      cpu_power = true;
      cpu_mhz = true;
      ram = true;

      throttling_status = true;
      gamemode = true;
    };

    # 3 - Full: diagnostics
    "3" = {
      fps = true;
      fps_metrics = "avg,0.01,0.001";
      frametime = true;
      frame_timing = true;

      gpu_stats = true;
      gpu_temp = true;
      gpu_junction_temp = true;
      gpu_core_clock = true;
      gpu_mem_clock = true;
      gpu_power = true;
      gpu_power_limit = true;
      gpu_fan = true;
      gpu_voltage = true;
      vram = true;

      cpu_stats = true;
      cpu_temp = true;
      cpu_power = true;
      cpu_mhz = true;
      ram = true;

      vulkan_driver = true;
      wine = true;
      winesync = true;
      present_mode = true;
      resolution = true;
      throttling_status = true;
      device_battery = true;
      gamemode = true;
    };
  };
in
{
  programs.mangohud = {
    enable = true;

    settings = {
      ### Presets / keys
      preset = "0,1,2,3"; # 0 = hidden (starts hidden)
      toggle_preset = "Shift_R+F12";
      toggle_hud = "Shift_R+F9"; # moved off F12 so it doesn't fight the preset key

      ### Behaviour
      fps_limit_method = "early";
      vsync = true;

      ### Colour cues (apply to every preset)
      fps_color_change = true;
      gpu_load_change = true;
      cpu_load_change = true;

      ### Layout
      position = "top-left";
      font_size = 20;
      background_alpha = 0.4;
      round_corners = 5;

      ### Colors
      gpu_color = "2E9762";
      cpu_color = "2E97CB";
      vram_color = "AD64C1";
      ram_color = "C26693";
    };
  };

  xdg.configFile."MangoHud/presets.conf".text =
    lib.concatStringsSep "\n\n"
      (lib.mapAttrsToList (n: p: "[preset ${n}]\n${render p}") presets) + "\n";
}
