{
  inputs,
  username,
  prettyname,
  ...
}: {
  imports = [inputs.betterfox.homeManagerModules.betterfox];

  programs.firefox = {
    enable = true;

    betterfox = {
      enable = true;
      version = "main";
    };

    profiles.${username} = {
      isDefault = true;
      name = "${prettyname}";

      betterfox = {
        enable = true;
        enableAllSections = true;

        fastfox.enable = true;
        peskyfox.enable = true;
      };

      settings = {
        # Disable AI Chat >3
        "browser.ml.chat.enabled" = false;
        "browser.ml.chat.hideFromLabs" = true;
        "browser.ml.chat.hideLabsShortcuts" = true;
        "browser.ml.chat.hideLocalhost" = true;

        # Enable Firefox Sync
        "identity.fxaccounts.enabled" = true;

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
