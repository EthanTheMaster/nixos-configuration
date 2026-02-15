{ config, pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    policies = {
      # See: mozilla.github.io/policy-templates/#extensionsettings
      # Extension ID can be found by
      #   - Navigating to add-ons page 
      #   - Checking all versions at the bottom of the page (e.g. https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/versions/)
      #   - Downloading an XPI file
      #   - Extracting "manifest.json" from the XPI file
      #   - Retrieving value ".browser_specific_settings.gecko.id" from "manifest.json"
      ExtensionSettings = {
        "*".installation_mode = "blocked"; # blocks all addons except the ones specified below
        # Bitwarden 
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/{446900e4-71c2-419f-a6a7-df9c091e268b}/latest.xpi";
          private_browsing = true;
        };
        # uBlock Origin
        "uBlock0@raymondhill.net" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/uBlock0@raymondhill.net/latest.xpi";
          private_browsing = true;
        };
      }; 
    };
  };
}