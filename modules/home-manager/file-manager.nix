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
      # This draws it in the border color of the theme instead.
      # Delete this replacement to get the black outline again.
      substituteInPlace src/ui/src/window.cpp \
        --replace-fail 'kBlack.with_alpha(0.18F));' 'Color::rgb(0x${colors.base02}));'
    '';
  });
in
{
  home.packages = [ nordend ];
}
