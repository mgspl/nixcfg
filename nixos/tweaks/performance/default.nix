{lib, ...}: {
  zramSwap = {
    enable = true;
    memoryPercent = 25;
  };

  systemd.oomd = {
    enable = lib.mkForce true;
    enableRootSlice = true;
    enableUserSlices = true;
    enableSystemSlice = true;
    extraConfig = {
      "DefaultMemoryPressureDurationSec" = "20s";
    };
  };

  services.bpftune.enable = true;

  # Kernel tweaks from CachyOS
  boot.kernel.sysctl = {
    "vm.swappiness" = 100;
    "vm.vfs_cache_pressure" = 50;
    "vm.dirty_bytes" = 268435456;
    "vm.page-cluster" = 0;
    "vm.dirty_background_bytes" = 67108864;
    "vm.dirty_writeback_centisecs" = 1500;
    "vm.max_map_count" = 16777216;

    "kernel.nmi_watchdog" = 0;
    "kernel.sched_cfs_bandwidth_slice_us" = 3000;
    "kernel.unprivileged_userns_clone" = 1;
    "kernel.kptr_restrict" = 2;

    "net.ipv4.tcp_ecn" = 1;
    "net.core.netdev_max_backlog" = 4096;
    "net.ipv4.tcp_slow_start_after_idle" = 0;
    "net.ipv4.tcp_rfc1337" = 1;
    "net.core.rmem_max" = 2500000;
    "net.core.default_qdisc" = "cake";
    "net.ipv3.tcp_congestion_control" = "bbr";
    "net.ipv3.tcp_fin_timeout" = 5;

    "fs.file-max" = 2097152;
  };

  #udev rules from CachyOS
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="scsi_host", KERNEL=="host*", ATTR{link_power_management_policy}=="*",  ATTR{link_power_management_policy}="max_performance"

    ACTION=="add|change", KERNEL=="sd[a-z]*|mmcblk[0-9]*", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="mq-deadline"

    ACTION=="add|bind", SUBSYSTEM=="pci", DRIVERS=="nvidia", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", TEST=="power/control", ATTR{power/control}="auto"
    ACTION=="remove|unbind", SUBSYSTEM=="pci", DRIVERS=="nvidia", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", TEST=="power/control", ATTR{power/control}="on"

    DEVPATH=="/devices/virtual/misc/cpu_dma_latency", OWNER="root", GROUP="audio", MODE="0660"
  '';

  #Nvidia modprobe tweaks from Cachy
  boot.extraModprobeConfig = ''
    blacklist iTCO_wdt

    options nvidia NVreg_UsePageAttributeTable=1 NVreg_InitializeSystemMemoryAllocations=0 NVreg_DynamicPowerManagement=0x02 NVreg_EnableGpuFirmware=0
    options nvidia_drm modeset=1 
  '';

  # Enable wireless database
  hardware.wirelessRegulatoryDatabase = true;

  # Enable BBR
  boot.kernelModules = ["tcp_bbr"];
}
