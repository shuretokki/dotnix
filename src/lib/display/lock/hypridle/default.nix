# https://wiki.hyprland.org/Hypr-Ecosystem/hypridle/
# https://home-manager-options.extranix.com/?query=services.hypridle
# Timeouts configured via theme.hypridle.* options
{config, ...}: {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = config.theme.hypridle.lockTimeout;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = config.theme.hypridle.dpmsTimeout;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
