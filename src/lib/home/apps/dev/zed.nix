{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (config.stylix) fonts;
in {
  programs.zed-editor = {
    enable = lib.mkDefault true;
    # package = pkgs.zed-editor;

    userSettings = {
      project_name = null;
      icon_theme = "Zed (Default)";
      base_keymap = "VSCode";
      theme = lib.mkDefault {
        mode = "system";
        light = "One Light";
        dark = "One Dark";
      };

      ui_font_family = lib.mkDefault fonts.sansSerif.name;
      ui_font_size = lib.mkDefault fonts.sizes.desktop;
      ui_font_weight = 400;
      buffer_font_family = lib.mkDefault fonts.monospace.name;
      buffer_font_size = lib.mkDefault fonts.sizes.terminal;
      buffer_font_weight = 400;
      buffer_line_height = "comfortable";

      cursor_blink = true;
      cursor_shape = "bar";
      current_line_highlight = "all";
      selection_highlight = true;
      rounded_selection = true;
      show_completions_on_input = true;
      show_completion_documentation = true;
      show_whitespaces = "selection";
      colorize_brackets = false;
      indent_guides = {
        enabled = true;
        line_width = 1;
        active_line_width = 1;
        coloring = "fixed";
      };

      vim_mode = false;
      helix_mode = false;
      use_autoclose = true;
      use_auto_surround = true;
      auto_indent = "syntax_aware";
      auto_indent_on_paste = true;
      format_on_save = "on";
      remove_trailing_whitespace_on_save = true;
      ensure_final_newline_on_save = true;
      always_treat_brackets_as_autoclosed = false;
      allow_rewrap = "in_comments";
      show_edit_predictions = true;

      project_panel = {
        button = true;
        dock = "left";
        default_width = 240;
        file_icons = true;
        folder_icons = true;
        git_status = true;
        auto_reveal_entries = true;
        auto_fold_dirs = true;
        show_diagnostics = "all";
      };

      outline_panel = {
        button = true;
        dock = "left";
        default_width = 300;
        file_icons = true;
        folder_icons = true;
        git_status = true;
        auto_reveal_entries = true;
      };

      collaboration_panel = {
        button = true;
        dock = "left";
        default_width = 240;
      };

      scrollbar = {
        show = "auto";
        cursors = true;
        git_diff = true;
        search_results = true;
        selected_text = true;
      };

      minimap = {
        show = "never";
        display_in = "active_editor";
      };

      title_bar = {
        show_branch_name = true;
        show_project_items = true;
        show_user_picture = true;
      };

      toolbar = {
        breadcrumbs = true;
        quick_actions = true;
      };

      terminal = {
        font_family = lib.mkDefault fonts.monospace.name;
        font_size = lib.mkDefault fonts.sizes.terminal;
        line_height = "standard";
        working_directory = "current_project_directory";
        blinking = "terminal_controlled";
        cursor_shape = "block";
        copy_on_select = false;
        env = {
          # "KEY" = "value";
        };
      };

      git = {
        disable_git = false;
        enable_status = true;
        enable_diff = true;
        git_gutter = "tracked_files";
        inline_blame = {
          enabled = true;
          delay_ms = 0;
        };
      };

      languages = {
        Nix = {
          language_servers = ["nil" "..."];
          format_on_save = "on";
          formatter = {
            external = {
              command = "nixfmt";
            };
          };
        };
        # Markdown = {
        #   soft_wrap = "editor_width";
        # };
      };

      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      auto_update = true;

      diagnostics = {
        button = true;
        include_warnings = true;
        inline = {
          enabled = false;
        };
      };

      inlay_hints = {
        enabled = false;
      };

      file_finder = {
        file_icons = true;
        modal_max_width = "small";
      };

      preview_tabs = {
        enabled = true;
        enable_preview_from_project_panel = true;
      };

      autosave = "on";
      restore_on_startup = "last_session";
      confirm_quit = false;
      close_on_file_delete = false;
      show_wrap_guides = true;
      preferred_line_length = 80;
      tab_size = 4;
      hard_tabs = false;
      middle_click_paste = true;
      scroll_beyond_last_line = "one_page";
    };
  };
}
