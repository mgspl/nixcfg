{
  pkgs,
  lib,
  ...
}: {
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
      "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock
      "ammjkodgmmoknidbanneddgankgfejfh" # 7TV
    ];

    commandLineArgs = lib.concatLists [
      # Aesthetics
      [
        "--force-dark-mode"
        "--gtk-version=4"
      ]

      # Performance
      [
        "--enable-gpu-rasterization"
        "--enable-oop-rasterization"
        "--enable-zero-copy"
        "--ignore-gpu-blocklist"
      ]

      # Wayland
      [
        "--ozone-platform=wayland"
        "--enable-features=UseOzonePlatform"
      ]

      # Etc
      [
        "--disable-reading-from-canvas"
        "--no-first-run"
        "--disable-wake-on-wifi"
        "--disable-breakpad"
        "--no-default-browser-check"
        "--disable-speech-api"
        "--disable-speech-synthesis-api"
        "--webrtc-ip-handling-policy"
      ]

      [
        (
          "--enable-features="
          + lib.concatMapStrings (x: x + ",") [
            # Disable Draging Links (Ungoogled Chromium)
            "DisableLinkDrag"
            # Enable visited link database partitioning
            "PartitionVisitedLinkDatabase"
            # Enable prefetch privacy changes
            "PrefetchPrivacyChanges"
            # Enable split cache
            "SplitCacheByNetworkIsolationKey"
            "SplitCodeCacheByNetworkIsolationKey"
            # Enable partitioning connections
            "EnableCrossSiteFlagNetworkIsolationKey"
            "HttpCacheKeyingExperimentControlGroup"
            "PartitionConnectionsByNetworkIsolationKey"
            # Enable strict origin isolation
            "StrictOriginIsolation"
            # Enable reduce accept language header
            "ReduceAcceptLanguage"
            # Enable content settings partitioning
            "ContentSettingsPartitioning"
          ]
        )
      ]

      [
        (
          "--disable-features="
          + lib.concatMapStrings (x: x + ",") [
            # Disable autofill
            "AutofillPaymentCardBenefits"
            "AutofillPaymentCvcStorage"
            "AutofillPaymentCardBenefits"
            # Disable third-party cookie deprecation bypasses
            "TpcdHeuristicsGrants"
            "TpcdMetadataGrants"
            # Disable hyperlink auditing
            "EnableHyperlinkAuditing"
            # Disable showing popular sites
            "NTPPopularSitesBakedInContent"
            "UsePopularSitesSuggestions"
            # Disable article suggestions
            "EnableSnippets"
            "ArticlesListVisible"
            "EnableSnippetsByDse"
            # Disable content feed suggestions
            "InterestFeedV2"
            # Disable media DRM preprovisioning
            "MediaDrmPreprovisioning"
            # Disable autofill server communication
            "AutofillServerCommunication"
            # Disable new privacy sandbox features
            "PrivacySandboxSettings4"
            "BrowsingTopics"
            "BrowsingTopicsDocumentAPI"
            "BrowsingTopicsParameters"
            # Disable translate button
            "AdaptiveButtonInTopToolbarTranslate"
            # Disable detailed language settings
            "DetailedLanguageSettings"
            # Disable fetching optimization guides
            "OptimizationHintsFetching"
            # Partition third-party storage
            "DisableThirdPartyStoragePartitioningDeprecationTrial2"

            # Disable media engagement
            "PreloadMediaEngagementData"
            "MediaEngagementBypassAutoplayPolicies"
          ]
        )
      ]
    ];
  };
}
