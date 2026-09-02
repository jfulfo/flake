{
  config,
  lib,
  ...
}: let
  inherit (lib) listToAttrs nameValuePair;

  mkJob = job: let
    unitName = "cronjob-${job.name}";
  in {
    timer = nameValuePair unitName {
      description = "Timer for ${job.name}";
      wantedBy = ["timers.target"];
      timerConfig = {
        OnCalendar = job.schedule;
        Persistent = true;
      };
    };
    service = nameValuePair unitName {
      description =
        if job.description != ""
        then job.description
        else "Cron job: ${job.name}";
      serviceConfig = {
        Type = "oneshot";
        User =
          if job.user != null
          then job.user
          else config.variables.user;
      };
      script = job.command;
    };
  };

  jobs = map mkJob config.variables.cronJobs;
in {
  systemd.timers = listToAttrs (map (j: j.timer) jobs);
  systemd.services = listToAttrs (map (j: j.service) jobs);
}
