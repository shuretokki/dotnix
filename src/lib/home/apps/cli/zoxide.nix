# https://github.com/ajeetdsouza/zoxide
# https://home-manager-options.extranix.com/?query=programs.zoxide
{lib, ...}: {
  programs.zoxide = {
    enable = lib.mkDefault true;
    enableBashIntegration = true;
    options = [];
  };
}
