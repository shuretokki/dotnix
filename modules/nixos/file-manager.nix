{
  config,
  inputs,
  pkgs,
  ...
}:
let
  colors = config.lib.stylix.colors;
  lucideIcons = (import ../../pkgs pkgs).nordend-lucide-icons;
  nordend = inputs.nordend.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      # The outline icons are a font of Tabler glyphs that is compiled into the program.
      # This swaps it for a font of Lucide glyphs that has the same glyph names, so every icon keeps its place.
      # Delete this line to get the Tabler icons again.
      cp --no-preserve=mode ${lucideIcons}/tabler-icons.ttf third_party/tabler-icons/tabler-icons.ttf

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

      # The row highlight of a column ends 6 px from the right edge, where the scrollbar is, so they almost touch.
      # This ends the highlight 18 px from the right edge, which leaves a gap before the scrollbar, and moves the icon, the name and the arrow in with it.
      # Delete this replacement to get the tight columns again.
      substituteInPlace src/views/src/column.cpp \
        --replace-fail 'constexpr float kRowInset = 6.0F;' 'constexpr float kRowInset = 8.0F;
      constexpr float kRowInsetRight = 18.0F;' \
        --replace-fail 'bounds.width - (2.0F * kRowInset),' 'bounds.width - kRowInset - kRowInsetRight,' \
        --replace-fail 'constexpr float kIconX = 14.0F;' 'constexpr float kIconX = 22.0F;' \
        --replace-fail 'constexpr float kRightPadding = 12.0F;' 'constexpr float kRightPadding = 28.0F;'

      # The scrollbar thumb is the text color at 45 percent opacity in every view.
      # This draws it in the border color of the theme.
      # Delete this replacement to get the text colored thumb again.
      substituteInPlace src/views/src/column.cpp src/views/src/column_view.cpp src/views/src/details_view.cpp src/views/src/grid_view.cpp \
        --replace-fail 'palette.on_surface_variant.with_alpha(0.45F)' 'ui::Color::rgb(0x${colors.base02})'

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
