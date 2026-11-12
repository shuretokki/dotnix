{
  config,
  inputs,
  ...
}:
let
  colors = config.lib.stylix.colors;
  c = name: "#${colors.${"base" + name}}";
  fonts = config.stylix.fonts;

  preset = {
    name = "Stylix";
    variant = "dark";

    bg = c "00";
    bg1 = c "01";
    bg2 = c "01";
    bg3 = c "02";
    bg4 = c "02";
    bg5 = c "03";
    bg6 = c "03";
    bg7 = c "03";
    bg8 = c "04";
    bg9 = c "04";
    bgD = c "00";
    bgD1 = c "00";

    fg = c "05";
    fg1 = c "06";
    fg2 = c "05";
    fg3 = c "04";
    fg4 = c "04";
    fg5 = c "03";
    fg6 = c "03";
    fg7 = c "02";
    fg8 = c "01";
    fgL = c "07";
    fg3D = c "04";
    fg4D = c "05";

    sliderBg = c "0D";

    borderBg = c "03";
    borderBg1 = c "02";
    borderBg2 = c "02";
    borderBg3 = c "01";
    borderBg4 = c "01";
    borderBgFocus = c "04";
    borderBgFocus1 = c "03";

    focusBg = c "02";
    focusBg1 = c "03";
    focusBgD = c "01";
    focusBgL = c "03";
    focusFg = c "05";
    focusFg1 = c "04";
    focusFg2 = c "04";

    accent = c "0D";
    coverArtGlowShadow = c "0D";

    ok = c "0B";
    okShell = c "0B";
    warnMed = c "0A";
    danger = c "08";
    mutedFg = c "08";
    mutedFgSlider = c "08";
    fgMuted = c "03";

    netFg = c "0C";
    netFgOff = c "03";
    netConnected = c "0D";
    netConnectedFg = c "07";
    netFail = c "08";
    netBtn = c "0D";
    netBtnHover = c "0D";
    btDeviceOff = c "03";
    vpnFg = c "0B";
    vpnOkFg = c "0B";
    ipFg = c "0C";

    ccActiveBg = c "01";
    ccActiveBg2 = c "02";
    ccDndBg = c "02";
    ccActiveFg = c "0D";
    ccDndFg = c "05";
    timerFg = c "0D";
    burstFg = c "09";
    timerRunningFg = c "0D";
    burstPalette = map c [
      "0A"
      "08"
      "0C"
      "0D"
      "0E"
      "0B"
    ];

    powerLock = c "0C";
    powerSleep = c "0D";
    powerLogout = c "0A";
    powerRestart = c "0E";
    powerShutdown = c "08";
    powerLogoutPending = c "0A";
    powerRestartConfirm = c "0E";
    powerLogoutConfirm = c "09";

    weatherText = c "05";
    weatherCondition = c "04";
    weatherTemp = c "06";
    weatherDay = c "03";
    weatherFeels = c "0E";
    weatherHumidity = c "0C";
    weatherWind = c "0B";
    weatherSunrise = c "0A";
    weatherSunset = c "09";
    weatherClear = c "0A";
    weatherCloudy = c "04";
    weatherRain = c "0C";
    weatherThunder = c "09";
    weatherSnow = c "06";

    notificationFg = c "04";
    notifFg = c "09";
    dateFg = c "04";
    todayFg = c "0E";
    calendarBg = c "01";
    osdBarBg = c "02";
    scrollIdle = c "02";
    scrollHover = c "03";
    scrollPressed = c "04";
    wsActiveBg = c "0D";
    wsInactiveBg = c "02";
    wsActiveFg = c "00";
    wsInactiveFg = c "04";
    rowBg = c "01";
    heroBg = c "01";
    toggleOffBg = c "02";
    notifHeaderBg = c "02";
    clearAllBg = c "01";
    clearAllBgHover = c "00";
    warning = c "0A";
    deleting = c "08";
  };
in
{
  imports = [ inputs.chillpill-shell.homeManagerModules.default ];

  programs.chillpill-shell = {
    enable = true;
    settings = {
      theme = "stylix";
      textFontFamily = fonts.sansSerif.name;
      nerdFontFamily = fonts.monospace.name;
      defaultTerminal = "warp-terminal";
    };
  };

  home.file.".cache/chillpill-shell/themes/stylix.json".text = builtins.toJSON preset;

  wayland.windowManager.hyprland.extraLuaFiles.chillpill = ./chillpill.lua;
}
