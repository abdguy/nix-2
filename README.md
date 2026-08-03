This is the Nix configuration for the whole system that will be used to configure your NixOS manually and automatically. You can also contribute to it.

Okay, but currently it is integrated with scripts. When you run install.sh on your NixOS system, it will automatically detect the UUID of your disk and automatically create the partitions.

The partitions will include /, /boot, /persist, and /nix.

/nix contains the actual installation of the system.
/persist consists of the secrets of the NixOS system and some important data so that after a reboot, the credentials still remain in /persist.
/boot is the boot directory, which consists of the bootloader.

Note that the whole system is configured to use the EFI bootloader, so make sure your system and Virt Manager are able to support that.

If you want to run NixOS in a virtual machine, then Virt Manager is the best option because it is suitable for QEMU.

To enable EFI in Virt Manager, set up the virtual machine for NixOS, and before running the installation, set the boot mode to UEFI.

To install NixOS in Virt Manager, boot the NixOS ISO image and install Disko in the terminal using the temporary shell command:

`nix-shell -p disko`

Press Enter. This will install Disko in a temporary shell. After that, run the following commands:
```
sudo mkdir -p /mnt/etc/nixos/
cd /mnt/etc/nixos
```

Create a disko.nix file and paste the following code into it.

```
{ lib, ... }:

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
            size = "50G";

            content = {
              type = "btrfs";

              subvolumes = {
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
```
after savin gthe code in disko.nix run the following command

```
disko --mode destroy,format,mount ./disko.nix

sudo nixos-config-generate --root /mnt
```
now open the hardware-configuration file which is present in directory /mnt/etc/nixos and ad the the following line inside the file system .you can also view the code present int he repo  hosts/amayadori/hardware-configuration.nix

```
fileSystems."/" =
    { device = "tmpfs";
      fsType = "tmpfs";
      options = [ "defaults" "size=2G" "mode=755"];
      neededForBoot = true;
    };
```
also add the 
` lib.mkForce `
in swap filesystem
