{
  disko.devices = {
    disk.main = {
      device = "/dev/nvme0n1";
      type = "disk";

      content = {
        type = "gpt";

        partitions = {
          ESP = {
            size = "512M";
            type = "EF00";

            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };

          swap = {
            size = "8G";
            content = {
              type = "swap";
            };
          };

          system = {
            size = "52G"; # Increased to accommodate the 2G root subvolume.

            content = {
              type = "btrfs";

              subvolumes = {
                "@" = {
                  mountpoint = "/";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                  neededForBoot = true;
                };

                "@nix" = {
                  mountpoint = "/nix";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                };

                "@persist" = {
                  mountpoint = "/persist";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                  neededForBoot = true;
                };
              };
            };
          };

          rest = {
            size = "100%";
          };
        };
      };
    };
  };
}
