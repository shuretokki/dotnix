{
  config,
  inputs,
  pkgs,
  ...
}:
let
  colors = config.lib.stylix.colors;
  nordend = inputs.nordend.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      # The window outline is a fixed black at 18 percent opacity.
      # This draws it in the border color of the theme instead, at 60 percent so it is not brighter than the compositor border.
      # Raise the 0.6F to make the outline brighter, or delete this replacement to get the black outline again.
      substituteInPlace src/ui/src/window.cpp \
        --replace-fail 'kBlack.with_alpha(0.18F));' 'Color::rgb(0x${colors.base02}).with_alpha(0.6F));'

      # The separators of the sidebar and the header are 18 percent of the text color over the background.
      # That is brighter than the compositor border, so this draws them in the same border color of the theme.
      # Delete this replacement to get the mixed separators again.
      substituteInPlace src/theme/src/gtk.cpp \
        --replace-fail 'p.outline_variant = mix(ink, *surface, 0.82F);' 'p.outline_variant = Color::rgb(0x${colors.base02});'
    '';
  });
in
{
  environment.systemPackages = [ nordend ];

  xdg.portal = {
    extraPortals = [ nordend ];
    config.hyprland."org.freedesktop.impl.portal.FileChooser" = [ "nordend" ];
  };
}
