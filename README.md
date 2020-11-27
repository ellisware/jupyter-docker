# Jupyter Docker
This is a Linux Docker image for Miniconda running Jupyter Notebook.

Miniconda is a packaged python distribution.  Jupyter Notebook is an inline developer notebook.
# Usage
It is assumed that the user has already acquired a working Docker installation. If that is not the case, go do that and come back here when you're done.
## Command
With this image, you can create a new Miniconda installation with one command (note that running said command indicates agreement to the Minecraft EULA). Here is an example:

```sudo docker run -p 8888:8888 mtcanuck1/jupyter```

While this command will work just fine in many cases, it is only the bare minimum required to start a functional server and can be vastly improved by specifying some...
## Options
There are several command line options that users may want to specify when utilizing this image. These options are listed below with some brief explanation. An example will be provided with each. In the example, the part that the user can change will be surrounded by angle brackets (`< >`). Remember to *remove the angle brackets* before running the command.
- Port
  - This option must be specified. Use port `8888` if you don't know what this is.
  - Set this to the port number that the Jupyter Notebook will be accessed from.
  - `-p <8888>:8888`
- Volume
  - Set this to a name for the server's Docker volume (defaults to randomized gibberish).
  - Alternatively, set this to a path to a folder on your computer.
  - `-v <my_volume_name>:/opt/notebooks`
  - `-v </path/to/files>:/opt/notebooks`
- Detached
  - Include this to make the container independent from the current command line.
  - `-d`
- Terminal/Console
  - Include these flags if you want access to the server's command line via `docker attach`.
  - These flags can be specified separately or as one option.
  - `-t` and `-i` in any order
  - `-ti` or `-it`
- Restart Policy
  - If you include this, the server will automatically restart if it crashes.
  - Stopping the server from its console will still stop the container.
  - It is highly recommended to only stop the server from its console (not via Docker).
  - `--restart on-failure`
- Name
  - Set this to a name for the container (defaults to a couple of random words).
  - `--name "<my-container-name>"`
There is one more command line option, but it is a bit special and deserves its own section.
### Environment Variables
Environment variables are options that are specified in the format `-e <NAME>="<VALUE>"` where `<NAME>` is the name of the environment variable and `<VALUE>` is the value that the environment variable is being set to. This image has four environment variables:

- Time Zone
  - **Name:** `TZ`
  - Set this to the local time zone.
  - `-e TZ="<America/Toronto>"`
- Language Encoding
  - **Name:** `LANG`
  - Set this to language encoding used by miniconda.
  - `-e LANG="<LANG=C.UTF-8 LC_ALL=C.UTF-8>"`
- Including Miniconda in the environment path
  - **Name:** `PATH`
  - Do not change this
  - `-e PATH="</opt/conda/bin:$PATH>"`

## Further Setup
From this point, the server should be configured in the same way as any other docker server. The port that was specified earlier will probably need to be forwarded as well. For details on how to do this and other such configuration, Google it, because it works the same as any other server.
# Technical
This container image is redicoulously insecure.  Only run it on an air gapped network, and understand what you are doing.  It creates a very easy attack surface to run python scripts on the server.

**PLEASE NOTE:** This is an unofficial project. I did not create Miniconda or Jupyter :)

## Project Pages
This Project:
- [GitHub page](https://github.com/ellisware/jupyter-docker).
- [Docker Hub page](https://hub.docker.com/r/mtcanuck1/jupyter).
