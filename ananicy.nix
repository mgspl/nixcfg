{ pkgs, ...}:
{
  services.ananicy = {
    enable = true;
    # Use ananicy-cpp
    package = pkgs.ananicy-cpp;
    # Use cachy rules provided from chaotic
    rulesProvider = pkgs.ananicy-rules-cachyos_git;
    # Eternal Return rule :3
    extraRules = [
      {
        name = "EternalReturn.exe";
        type = "Game";
      }
    ];
  };
}
