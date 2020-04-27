# Configuration Guides for Boom-saver

## Services

Currently there are two services enabled to allow remote access.

The default password is raspberry. Please Change it upon usage.

  1. SSH via Port 22.
     * Simply use ssh pi@{device-IP-Address}
     * Example: ``pi@192.168.1.40``

  1. VNC via port 5900
      * Guides Disabling/Enabling [Here](https://www.raspberrypi.org/documentation/remote-access/vnc/)

## Installing Distro

To install Image on your own Raspberry Pi:

  1. [Download the Image here](https://drive.google.com/file/d/1VkWLFhh_3iPu2vYr3kx_lb-SHk-QeT-l/view?usp=sharing)
     * Requires a Valid IIT email
     * Verify MD5 sum matches this:
  1. Extract File
     * via gui or CLI

      ```gunzip -v boom-scan-RPI-test-deploy.img.gz```

  1. Insert SD card to Computer
  1. Start Image Flash software
  1. Flash boom-scan-RPI-test-deploy.img.gz to SD card
  1. Insert Image into Raspberry Pi

Useful Guides:

[Via Ubuntu](https://www.ev3dev.org/docs/tutorials/writing-sd-card-image-ubuntu-disk-image-writer/)
