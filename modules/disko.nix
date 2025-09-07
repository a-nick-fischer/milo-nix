{
  ...
}:
{
  disko.devices = {
    disk.main = {
      device = "/dev/nvme0n1";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          boot = {
            name = "boot";
            size = "1G";
            type = "EF02";
          };
          esp = {
            name = "ESP";
            size = "1G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          swap = {
            size = "8G";
            content = {
              type = "swap";
              resumeDevice = true;
            };
          };
          zfs = {
            name = "root";
            size = "100%";
            content = {
              type = "zfs";
              pool = "zroot";
            };
          };
        };
      };
    };
    zpool = {
      zroot = {
        type = "zpool";
        rootFsOptions = {
          acltype = "posixacl";
          dnodesize = "auto";
          xattr = "sa";
          relatime = "on";
          normalization = "formD";
          mountpoint = "none";
          encryption = "aes-256-gcm";
          keyformat = "passphrase";
          keylocation = "prompt";
          compression = "zstd";
          "com.sun:auto-snapshot" = "false";
        };
        datasets = {
          root = {
            type = "zfs_fs";
            mountpoint = "/";
            options.mountpoint = "legacy";
          };
          nix = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            options.atime = "off";
            mountpoint = "/nix";
          };
          log = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            mountpoint = "/var/log";
          };
          volumes = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            options."com.sun:auto-snapshot" = "true";
            mountpoint = "/volumes";
          };
          home = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            options."com.sun:auto-snapshot" = "true";
            mountpoint = "/home";
          };
        };
      };
    };
  };
  fileSystems = {
    "/".neededForBoot = true;
    "/nix".neededForBoot = true;
    "/volumes".neededForBoot = true;
    "/home".neededForBoot = true;
    "/boot".neededForBoot = true;
  };
}


