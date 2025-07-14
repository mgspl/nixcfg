{
  services.kanshi = {
    enable = true;
    settings = [
      {
        profile.name = "undocked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            mode = "1366x768@60.016Hz";
            adaptiveSync = false;
            position = "0,0";
          }
        ];
      }
      {
        profile.name = "docked";
        profile.outputs = [
          {
            criteria = "HDMI-A-1";
            mode = "1360x768@60.01Hz";
            adaptiveSync = false;
            position = "0,0";
          }
          {
            criteria = "eDP-1";
            mode = "1366x768@60.016Hz";
            adaptiveSync = false;
            position = "1360,0";
          }
        ];
      }
    ];
  };
}
