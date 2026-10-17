{
  lib,
  username,
  ...
}: {
  services.power-profiles-daemon.enable = true;
  services.printing.browsed.enable = false;
  services.joycond.enable = lib.mkForce false;
  hardware.bluetooth.powerOnBoot = lib.mkForce false;
  systemd.user.services.docker.wantedBy = lib.mkForce [];
  services.fwupd.enable = true;

  systemd.services.battery-charge-threshold = {
    wantedBy = ["multi-user.target"];
    unitConfig.ConditionPathExists = "/sys/class/power_supply/BAT0/charge_control_end_threshold";
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      echo 80 > /sys/class/power_supply/BAT0/charge_control_end_threshold
      echo 75 > /sys/class/power_supply/BAT0/charge_control_start_threshold
    '';
  };

  home-manager.users.${username}.services.hypridle.settings.listener = lib.mkForce [
    {
      timeout = 600;
      on-timeout = "pidof hyprlock || hyprlock";
    }
    {
      timeout = 720;
      on-timeout = "hyprctl dispatch dpms off";
      on-resume = "hyprctl dispatch dpms on";
    }
    {
      timeout = 1800;
      on-timeout = ''[ "$(cat /sys/class/power_supply/AC/online)" = 0 ] && systemctl suspend'';
    }
  ];
}
