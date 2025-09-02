# rypz.io

My personal website

## Building

This project is built using [zine](https://zine-ssg.io/). The following `make` targets are provided for convenience:

- `build`: builds the whole site into a deployment-ready `./public` directory
- `serve`: serves the site locally at `localhost:8085` with live reloading
- `post`: creates a blank post (`content/woods/new-post.smd`) with required frontmatter
- `clean`: removes temporary/ignored files

Where necessary, these targets automatically download and use a repo-local copy of zine from the [official releases](https://github.com/kristoff-it/zine/releases), selecting the appropriate version, architecture and OS.

## License

[LICENSE](./LICENSE)

Source code: BSD Zero Clause License (0BSD)

Written work: CC-BY-SA-4.0
