---
seo:
  title: SDN - The Modular NixOS Desktop
  description: A professional, modular, and declarative NixOS configuration built for productivity and aesthetics.
---

::u-page-hero
#title
The Modular NixOS Desktop.

#description
**SDN** (shuredotnix) is a professional NixOS configuration designed for clarity and aesthetic excellence. It strictly separates your personal data from system logic, creating a deterministic environment that is easy to fork and maintain.

#links
:::u-button
---
color: neutral
size: xl
to: /en/quick-start/installation
trailing-icon: i-lucide-arrow-right
---
Get Started
:::

:::u-button
---
color: neutral
icon: i-simple-icons-github
size: xl
to: https://github.com/shuretokki/dotnix
variant: outline
---
Source Code
:::
::

::u-page-section
  :::u-page-grid
    ::::u-page-card
    ---
    spotlight: true
    class: group col-span-2 lg:col-span-1
    to: /en/quick-start/project-structure
    ---
    #title
    [4-Layer Architecture]{.text-primary}

    #description
    Organized into **Core**, **Display**, **Home**, and **Profiles**. A clean separation of concerns makes the system easy to scale and debug.
    ::::

    ::::u-page-card
    ---
    spotlight: true
    class: col-span-2
    to: /en/configuration/identity
    ---
      :::::tabs
        ::::::tabs-item
        ---
        class: mt-5 mb-2 text-xs overflow-x-auto
        icon: i-lucide-user
        label: identity.nix
        ---
        ```nix
        {
          username = "shure";
          locale = "en_US.UTF-8";
          timezone = "Asia/Jakarta";
          theme = "sh";
        }
        ```
        ::::::
      :::::

    #title
    [Identity-First]{.text-primary} Configuration

    #description
    Configure your username, locale, and timezone in one central file. The entire system, from user accounts to time settings, adapts to your identity automatically.
    ::::

    ::::u-page-card
    ---
    spotlight: true
    class: col-span-2 md:col-span-1
    to: /en/features/display/theming
    ---
    #title
    Unified Aesthetics via [Stylix]{.text-primary}

    #description
    Theming is decoupled from implementation. Select a preset in `theme.nix` and watch Stylix apply your chosen colors and fonts across every application, from the terminal to the browser.
    ::::

    ::::u-page-card
    ---
    spotlight: true
    class: col-span-2 md:col-span-1
    to: /en/features/core/overview
    ---
      :::::div{.bg-elevated.rounded-lg.p-3.overflow-x-auto}
      ```nix [cfg/theme.nix]
      {
        theme.preset = "dark";
        theme.visual.rounding = 12;
        theme.hyprland.gaps = 6;
      }
      ```
      :::::

    #title
    Declarative [Visual Handling]{.text-primary}

    #description
    Control gaps, rounding, opacity, and blur globally. No need to edit CSS files or dotfiles manually.
    ::::

    ::::u-page-card
    ---
    spotlight: true
    class: col-span-2
    to: /en/features/core/encrypted-dns
    ---
    #title
    [Private by Design]{.text-primary}

    #description
    Hardened security defaults including Encrypted DNS (DNSCrypt) and SOPS-managed secrets for sensitive data. Your privacy is protected at the network level.
    ::::
  :::
::
