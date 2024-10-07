# rypz.io

My personal website

## Building

This project is built using [zola](https://www.getzola.org/). The following `make` targets are provided for convenience:

- `build`: builds the whole site in a deployment-ready `./public` directory
- `serve`: serves the site locally at `0.0.0.0:8085` with live reloading

These targets are configured to use the [official zola container images](https://github.com/getzola/zola/pkgs/container/zola). If you are using a container tool that isn't `podman`, you can configure `make` to use a different one by defining `CONTAINER_RUNNER` in the included `.env` file.

## License

[LICENSE](./LICENSE)

Source code: BSD Zero Clause License (0BSD)

Written work: CC-BY-SA-4.0
