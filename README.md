# qflood (qBittorrent + flood)

<p align="center">
  <img src="https://engels74.net/img/image-logos/qflood.svg" alt="base-image" style="width: 30%;"/>
</p>

<p align="center">
  <a href="https://github.com/engels74/qflood"><img src="https://img.shields.io/docker/v/engels74/qflood?sort=semver" alt="GitHub tag (SemVer)"></a>
  <a href="https://github.com/engels74/qflood/blob/master/LICENSE"><img src="https://img.shields.io/badge/License%20(Image)-GPL--3.0-orange" alt="License (Image)"></a>
  <a href="https://hub.docker.com/r/engels74/qflood"><img src="https://img.shields.io/docker/pulls/engels74/qflood.svg" alt="Docker Pulls"></a>
  <a href="https://github.com/engels74/qflood/stargazers"><img src="https://img.shields.io/github/stars/engels74/qflood.svg" alt="GitHub Stars"></a>
</p>

## 📖 Documentation

All the documentation for the "qflood" is located here.

For more information about the Docker image itself, you can visit [engels74.net](https://engels74.net/containers/qflood).

## 🐋 Docker Image

### Docker Compose

To get started with qflood using Docker, follow these steps:

1. **Use this Docker Compose example**
    ```yaml
	services:
	  qflood:
	    container_name: qflood
	    image: ghcr.io/engels74/qflood
	    ports:
	      - "8080:8080"
	      - "3000:3000"
	    environment:
	      - PUID=1000
	      - PGID=1000
	      - UMASK=002
	      - TZ=Etc/UTC
          - LIBTORRENT=v2
	      - FLOOD_AUTH=true
	      - ARGS
	      - FLOOD_ARGS
	    volumes:
	      - /<host_folder_config>:/config
	      - /<host_folder_data>:/data
    ```

2. **Run the Docker container using `docker compose`:**
    ```sh
    docker compose -f /choose/path/to/docker-compose.qflood.yml up -d
    ```

## 🆘 Support

If you need assistance, you can try asking in the [hotio Discord](https://hotio.dev/discord), but you probably won't receive support for this image specifically.

## 💻 Source Code

- **Project Source Code** (qBittorrent): The source code for the "qBittorrent" project is hosted at [[qbittorrent/qBittorrent](https://github.com/qbittorrent/qBittorrent)].

- **Project Source Code** (flood): The source code for the "flood" project is hosted at [[jesec/flood](https://github.com/jesec/flood)].

- **Docker Image Source**: The source files for building the Docker image are hosted at [[engels74/qflood](https://github.com/engels74/qflood)]. If you can't find what you're looking for in the `master` branch, check other branches.

## 🌟 Show your support

You can show your support by:
- Giving us a star on Docker Hub or GitHub
- Making a [donation](https://hotio.dev/donate) to hotio, as he's the genius behind the Docker images

Your support is greatly appreciated!
