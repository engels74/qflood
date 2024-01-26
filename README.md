# Qflood Nightly Docker Image

This is a fork of Hotio's rflood Docker image, that uses qBittorrent instead of rtorrent.

The qflood image currently only has "nightly support," which means it updates automatically after a successful run of [this workflow file](https://github.com/jesec/flood/actions/workflows/publish-rolling.yml).

This means that whenever the official flood repository receives a push commit, this docker image should automatically be updated. All thanks to hotio's brilliant setup.


## Why only "nightly"?

This docker image was created because, for whatever reason, jesec never seems to push an official release. And recent qBittorrent releases has [broken](https://github.com/jesec/flood/issues/629) hotio's old qflood image, which led him to deprecate the Docker image entirely.

This fixes it, while also keeping the image updated. If a release of flood happens in the future, I might create an official `release` image as well. But for now, only the `nightly` image will be available.

All credits goes to Hotio :)!


## Image Overview

There's only one Docker image to choose from: "[nightly](https://github.com/engels74/qflood/tree/nightly)"


## Using the images


**Nightly** ([info](https://github.com/engels74/qflood/pkgs/container/qflood))

`docker pull ghcr.io/engels74/qflood:nightly`

Alternatively, you can also use `latest` instead of nightly. It points to the same image.


## Docker Compose example

```yaml
version: "3.9"

services:
  qflood:
    container_name: qflood
    image: ghcr.io/engels74/qflood:nightly
    ports:
      - "3000:3000"
    environment:
      - PUID=1000
      - PGID=1000
      - UMASK=002
      - TZ=Etc/UTC
      - FLOOD_AUTH=false
    volumes:
      - /<host_folder_config>:/config
      - /<host_folder_data>:/data
    restart: unless-stopped
```

## Enabling Wireguard/VPN

Check out hotio's guide [here](https://hotio.dev/containers/wireguard/) if the example doesn't make sense to you.

```yaml
version: "3.9"

services:
  qflood:
    container_name: qflood
    image: ghcr.io/engels74/qflood:nightly
    ports:
      - "3000:3000"
    environment:
      - PUID=1000
      - PGID=1000
      - UMASK=002
      - TZ=Etc/UTC
      - FLOOD_AUTH=false
      - VPN_ENABLED=true
      - VPN_PROVIDER=generic
      - VPN_LAN_NETWORK=192.168.1.0/24
      - VPN_CONF=wg0
      - VPN_ADDITIONAL_PORTS
      - VPN_AUTO_PORT_FORWARD=true
      - VPN_PIA_USER
      - VPN_PIA_PASS
      - VPN_PIA_PREFERRED_REGION
      - PRIVOXY_ENABLED=false
    cap_add:
      - NET_ADMIN
    dns:
      - 1.1.1.1
    sysctls:
      - net.ipv4.conf.all.src_valid_mark=1
      - net.ipv6.conf.all.disable_ipv6=1
    volumes:
      - /<host_folder_config>:/config
      - /<host_folder_data>:/data
    restart: unless-stopped
```

## Support

You can try to get support on the [Hotio discord](https://hotio.dev/discord), but you won't likely get support for this Docker image. 

However, if you have problems configuring Wireguard, they may be able to assist you if you ask nicely:)


## Donate

You can show your support by giving Hotio a star on Hotio's [Docker Hub](https://hub.docker.com/u/hotio) or/and [GitHub](https://github.com/hotio), it's also possible to make a [donation](https://hotio.dev/donate) to Hotio!
