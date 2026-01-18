# https://search.nixos.org/options?query=users.users
{
  pkgs,
  identity,
  ...
}: {
  users.users.${identity.username} = {
    uid = 1000; # Consistent across reinstalls for file ownership.
    isNormalUser = true;
    description = identity.username;
    extraGroups = ["networkmanager" "wheel" "input" "video" "audio"];

    # TODO(shure): Consider switching to zsh/fish via home-manager.
    shell = pkgs.bash;
  };
}
