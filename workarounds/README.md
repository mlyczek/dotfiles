# Workarounds

## Systemd - encrypted swap

When using encyrpted swap with a key-file on the main partition, there may occur the following [issue](https://github.com/systemd/systemd/issues/10179), which causes the error:

```bash
Dependency failed for dev-mapper-nvme1n1p3_crypt.swap - /dev/mapper/nvme1n1p3_crypt.
lip 18 22:43:58 mat-legion systemd[1]: dev-mapper-nvme1n1p3_crypt.device: Job dev-mapper-nvme1n1p3_crypt.device/start timed out.
lip 18 22:43:58 mat-legion systemd[1]: Timed out waiting for device dev-mapper-nvme1n1p3_crypt.device - /dev/mapper/nvme1n1p3_crypt.
lip 18 22:43:58 mat-legion systemd[1]: dev-mapper-nvme1n1p3_crypt.device: Job dev-mapper-nvme1n1p3_crypt.device/start failed with result 'timeout'.
```

to resolve it, link the `crypt-swap-override.conf` file into `/etc/systemd/system/systemd-cryptsetup@.service.d/override.conf`.
