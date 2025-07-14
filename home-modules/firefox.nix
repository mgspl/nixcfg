{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.betterfox.homeManagerModules.betterfox];

  programs.firefox = {
    enable = true;

    betterfox = {
      enable = true;
      version = "main";
    };

    profiles.miguel = {
      isDefault = true;
      name = "Miguel";

      betterfox = {
        enable = true;
        enableAllSections = true;
      };

      extensions.packages = with inputs.rycee-nurpkgs.packages.${pkgs.system}; [
        bitwarden
        ublock-origin
        canvasblocker
        new-tab-override
        ctrl-number-to-switch-tabs
        seventv
        skip-redirect
        sponsorblock
      ];

      settings = {
        # Enable extensions
        "extensions.autoDisableScopes" = 0;
        # Disable AI Chat >3
        "browser.ml.chat.enabled" = false;
        "browser.ml.chat.hideFromLabs" = true;
        "browser.ml.chat.hideLabsShortcuts" = true;
        "browser.ml.chat.hideLocalhost" = true;

        # Enable Firefox Sync
        "identity.fxaccounts.enabled" = false;

        # Disable login manager
        "signon.rememberSignons" = false;

        # Disable address and credit card manager
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.creditCards.enabled" = false;

        # Disable the Firefox View tour from popping up
        "browser.firefox-view.feature-tour" = "{\"screen\":\"\",\"complete\":true}";

        # Disable Translations PopUP
        "browser.translations.automaticallyPopup" = false;
        "browser.translations.enable" = false;
        "browser.translations.panelShown" = false;

        # Enable DRM by default
        "browser.eme.ui.enabled" = true;
        "media.eme.enabled" = true;
      };
    };
  };
}
