{ config, pkgs, ... }:
{
  zramSwap = {
    enable = true;
    memoryPercent = 25;
  };
  
  # Pop_OS default values, stated in arch wiki :3
  boot.kernel.sysctl = {
    "vm.swappiness" = 180;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0;
  };
}
