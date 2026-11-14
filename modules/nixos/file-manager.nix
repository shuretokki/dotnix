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

      # The rows of the columns and the details are 28 px high at the usual size, which looks tight.
      # This makes the usual row 34 px and the next zoom step 40 px, so the steps stay different.
      # Delete this replacement to get the 28 px rows again.
      substituteInPlace src/views/include/nordend/views/list_size.hpp \
        --replace-fail '{.row = 28.0F, .icon = 18.0F, .text = 14.0F, .detail = 13.0F},' '{.row = 34.0F, .icon = 18.0F, .text = 14.0F, .detail = 13.0F},' \
        --replace-fail '{.row = 34.0F, .icon = 22.0F, .text = 15.0F, .detail = 13.0F},' '{.row = 40.0F, .icon = 22.0F, .text = 15.0F, .detail = 13.0F},'

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
