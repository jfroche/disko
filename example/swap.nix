{ disks ? [ "/dev/vdb" ], ... }: {
  disk = {
    vdb = {
      device = builtins.elemAt disks 0;
      type = "disk";
      content = {
        type = "table";
        format = "gpt";
        partitions = [
          {
            type = "partition";
            name = "ESP";
            start = "1MiB";
            end = "100MiB";
            bootable = true;
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          }
          {
            name = "root";
            type = "partition";
            start = "100MiB";
            end = "-1G";
            part-type = "primary";
            bootable = true;
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          }
          {
            name = "root";
            type = "partition";
            start = "-1G";
            end = "100%";
            part-type = "primary";
            bootable = true;
            content = {
              type = "swap";
              randomEncryption = true;
            };
          }
        ];
      };
    };
  };
}

