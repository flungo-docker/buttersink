# ButterSink for Docker
[ButterSink](https://github.com/AmesCornish/buttersink) synchronizes two sets of btrfs read-only subvolumes (snapshots).

This is a dockerisation of ButterSink built to allow it to be run in a container. It modifies the commands of the standard ButterSink and requires that for local directories, they are specified in a format that dictates which block device the directory is found on and its location relative to the root of that block device.

## How it works?
The docker container uses a bootstrapping script that reads your command input in order to allow the new location format. The location for local snapshots should be specified with this new format (see [Usage](#Usage)) and the bootstrapping script will mount these locations inside the container and give buttersink locations that it can access within the container. This allows access to the btrfs functionality within the container.

## Usage
ButterSink can be run directly but an executable `buttersink` is provided which you can put into your executable path allowing easy access to run ButterSink for Docker using the `buttersink` command as you normally would. It will then use the same commands and syntax as the original [ButterSink](https://github.com/AmesCornish/buttersink) with the exception of how you reference local directories.

To reference local directories and snapshots, you must use the following format for the paths:

```
[btrfs://]<block dev>//<path relative to root of block dev>/[snapshot]
```

### Example use
Below is an example usage to sync the snapshots in `/snapshots` of the block device `/dev/sda` to an S3 bucket.

```
buttersink /dev/sda//snapshots s3://bucket/sda-snapshots/
```

## Installing ButterSink for Docker
If you have make available on your system you can download the repository and run `make install`.

```
cd /opt
git clone https://github.com/flungo-docker/buttersink.git
cd buttersink
make install
```

Alternatively, you can just download the [buttersink](buttersink) script to your `/usr/local/bin/` directory (or any other directory on your executable path).

```
cd /usr/local/bin
wget https://raw.githubusercontent.com/flungo-docker/buttersink/master/buttersink
chmod +x buttersink
```

## Warnings
The docker container runs in priviliged mode and can be a security risk. Use of this script (and docker in general) should be limited to users with root access on the host system.
