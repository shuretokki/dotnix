{
  services.snapper.configs.home = {
    SUBVOLUME = "/home";
    ALLOW_USERS = [ "shure" ];
    TIMELINE_CREATE = true;
    TIMELINE_CLEANUP = true;
    TIMELINE_LIMIT_HOURLY = 5;
    TIMELINE_LIMIT_DAILY = 7;
    TIMELINE_LIMIT_WEEKLY = 2;
    TIMELINE_LIMIT_MONTHLY = 1;
    TIMELINE_LIMIT_QUARTERLY = 0;
    TIMELINE_LIMIT_YEARLY = 0;
  };
}
