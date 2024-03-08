{ pkgs, ...}:
{
  services.ananicy = {
    enable = true;
    # Use ananicy-cpp
    package = pkgs.ananicy-cpp;
    # Use cachy rules provided from chaotic
    rulesProvider = pkgs.ananicy-cpp-rules;
    # Ravendawn rule :3
    extraRules = [
      {
        name = "ravendawn_dx-1709339838.exe";
        type = "Game";
      }
    ];
  };
}
