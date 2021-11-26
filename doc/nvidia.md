NVIDIA hybrid card configuration
================================

This is a description about how to configure NVIDIA driver on hybrid laptopt together with integrated graphic card
from AMD Ryzen processor.

| Property | Value |
|----------|-------|
| Laptop | Lenovo Legion 5 15ARH05 |
| OS     | Debian testing |
| NVIDIA Card | 
| Processor | AMD Ryzen 7 4800H |
| NVIDIA card | GeForce GTX 1650 Ti Mobile |

Steps:

Install `xserver-xorg-video-nvidia` package together with some related ones. PRIME Render offload should work as expected with correct environment variables.

In order for Reverse PRIME to work (which is required for HDMI and USB-C connected monitors to work) add `modeset=1` option to `nvidia_drm` kernel module. This should be done by adding the following line into a file in `/etc/modprobe.d/`:
```
options nvidia_drm modeset=1
```

Then use
```
xrandr --listproviders
```
to list providers and get their name or id.

Then add the following line to `/usr/share/sddm/scripts/Xsession` script:
```
xrandr --setprovideroutputsource <name-or-id-of-nvidia-provider> <name-or-id-of-amdpgu-provider>
```
then after reboot external monitors should work properly.
