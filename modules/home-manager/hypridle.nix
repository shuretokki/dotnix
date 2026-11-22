{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "macshell-lock";
        before_sleep_cmd = "macshell-lock";
        after_sleep_cmd = "hyprctl dispatch 'hl.dsp.dpms({action = \"on\"})'";
      };
      listener = [
        {
          timeout = 300;
          on-timeout = "macshell-lock";
        }
        {
          timeout = 600;
          on-timeout = "hyprctl dispatch 'hl.dsp.dpms({action = \"off\"})'";
          on-resume = "hyprctl dispatch 'hl.dsp.dpms({action = \"on\"})'";
        }
      ];
    };
  };
}
