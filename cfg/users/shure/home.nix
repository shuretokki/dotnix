# https://home-manager-options.extranix.com/?query=home
{
  inputs,
  identity,
  ...
}: {
  imports = [
    inputs.self.homeModules.home
  ];

  # Consumed by bundlers; affects git, default apps, keybinds.
  _prefs = {
    gitname = "Tri R. Utomo";
    email = "tri.r.utomo@proton.me";
    browser = "zen-beta";
    terminal = "warp-terminal";
    editor = "";
    fileManager = "nautilus";
    musicPlayer = "spotify";
  };

  home = {
    inherit (identity) username;
    homeDirectory = "/home/${identity.username}";

    # Do not change after initial install.
    stateVersion = "25.11";
  };
}
