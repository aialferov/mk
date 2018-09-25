# Mk

[![License: MIT][MIT Badge]][MIT]
[![GitHub Release Badge]][GitHub Releases]

Set of [Makefiles] to simplify software building and packaging process.

## Usage

Clone into a directory with the main Makefile:

```
$ git clone https://github.com/aialferov/mk
```

The setup procedure removes not needed files leaving the "mk" directory with
makefiles and a Version file only:

```
$ make -C mk setup
```

Now the makefiles can be included into the main Makefile:

```
include mk/<Makefile>
```

Where "Makefile" is one of the following:

 * [Erlanglib.mk](erlanglibmk)
 * [Erlangbin.mk](erlangbinmk)
 * [Docker.mk](docker)

### Erlanglib.mk

Provides targets for building an [Erlang] library. Based on [Rebar3] and expects
it is located either in the PATH or in the same directory with the main
Makefile.

Defined variables:

 * `VERSION` — the library semantic version. Is read from the "src/*.app.src"
    file that is expected to be an [Erlang App] file with "vsn" key defined
 * `GIT_SHA` — first 8 characters of current Git SHA if available
 * `REBAR` — rebar3 executable path
 * `BASE_PATH` — common directory for compilation artefacts and downloaded
    dependencies
 * `LIB_PATH` — subdirectory of the "BASE_PATH" for the project compiled
    modules, dependencies download and dependencies compiled modules
 * `PLUGIN_PATH` — subdirectory of the "BASE_PATH" for rebar3 plugins and its
    compiled modules.

Targets:

 * `compile` — compiles the library
 * `check` — runs [EUnit] based unit tests
 * `clean` — removes all the files generated by the "compile" target
 * `distclean` — removes the "_build" directory recursively, assuming it is the
    build output directory
 * `shell` — gets into an Erlang shell with all the library and dependencies
    modules loaded
 * `upgrade` — upgrades the library dependencies
 * `git-release` — creates and pushes a tag named after the current version
    (uses "VERSION" variable)
 * `version` — prints out the full current version, i.e. semantic one and the
    current Git SHA (uses "VERSION" and "GIT_SHA" variables).

### Erlangbin.mk

Provides targets for building an [Erlang] application as a single binary.
Includes [Erlanglib.mk] which makes it also dependent on [Rebar3] expecting it
either in the PATH or in the same directory with the main Makfile.

Required variables:

 * `PROJECT` — should be set to the project name

Defined variables:

 * `DESTDIR` — intends to be part of the compiled executable installation path.
    Usually represents root of the installation, that is why should be empty for
    final installation or set to a directory which is temporary relative root of
    an upcoming package
 * `PREFIX` — intends to be part of the compiled executable installation path.
    Usually represents installation destination such as "usr" or "usr/local"
 * `BINDIR` — intends to be part of the compiled executable installation path.
    It is usually "bin" on the most of the systems
 * `BIN_PATH` — compiled executable installation final path
 * `BIN_PATH_IN` — compiled executable output path
 * `ERL_PATH` — created Erlang release output path.

Targets:

 * `install` — installs the compiled executable
 * `uninstall` — removes the compiled executable
 * `run` — runs the compiled executable with a switch "run"
 * `join` — attaches to the running executable Erlang machine with remote shell
 * `erlang` — uses [R3erlang] to create an Erlang release with runtime and the
    libraries needed to run the compiled executable
 * `erlang-clean` — removes recursively the directory with created Erlang
    release
 * `erlang-install` — installs Erlang release forwarding "DESTDIR" and "PREFIX"
    variables to the Makfile generated by R3erlang
 * `package-ready` — prepares everything for packaging (compiles the executable
    and creates Erlang release).

### Docker.mk

Provides targets to simplify [Docker] image buliding.

Required variables:

 * `USER` — used as Docker ID
 * `PROJECT` — used as Docker image name
 * `VERSION` — used Docker image tag

Defined variables:

 * `IMAGE` — full docker image name
 * `IMAGE_LATEST` — full docker image with always "latest" as a tag
 * `DOCKER_RUN_ARGS` — all the arguments used for running a container
 * `DOCKER_RUN_ARGS_EXTRA` — additional arguments for docker run
 * `DOCKER_BUILD_ARGS` — all the arguments used for building a container
 * `DOCKER_BUILD_ARGS_EXTRA` — additional arguments for docker build
 * `DOCKER_STOP_ARGS` — all the arguments used to stop a running container.

Targets:

 * `docker-build` — build docker image
 * `docker-push` — push docker images into registry
 * `docker-release —` create "latest" tag and push into registry.
    Also perform "docker-push"
 * `docker-release-local` — create "latest" tag
 * `docker-run` — run image container
 * `docker-run-d` — run image container in background
 * `docker-stop` — stop running container
 * `docker-join` — join a running in a container Erlang application with remote
    shell
 * `docker-shell` — exec shell in a running container
 * `docker-attach` — attach into a running container (no detach target,
    to detach the used windows should be closed)
 * `docker-logs` — print logs of a running container
 * `docker-logs-f` — continuosly print logs of a running container
 * `docker-clean` — remove image of the current version
 * `docker-distclean` — remove both "latest" and the current version images.

<!-- Links -->
[MIT]: https://opensource.org/licenses/MIT
[GitHub Releases]: https://github.com/aialferov/mk/releases
[EUnit]: http://erlang.org/doc/apps/eunit/chapter.html
[Docker]: https://docs.docker.com
[Erlang]: http://erlang.org
[Rebar3]: https://www.rebar3.org
[R3erlang]: https://github.com/aialferov/r3erlang
[Makefiles]: https://www.gnu.org/software/make
[Erlang App]: http://erlang.org/doc/man/app.html
[Dockerfile]: Dockerfile
[Erlanglib.mk]: https://github.com/aialferov/mk#erlanglibmk

<!-- Badges -->
[MIT Badge]: https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square
[GitHub Release Badge]: https://img.shields.io/github/release/aialferov/mk/all.svg?style=flat-square
