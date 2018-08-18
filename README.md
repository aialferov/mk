# Mk

[![License: MIT][MIT badge]][MIT]

Set of [Makefiles] to simplify software building process.

## Usage

Clone into the directory with the main Makefile:

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

See below the available makefiles description.

### Erlanglib.mk

Provides targets for building an [Erlang] library. Based on [Rebar3], so it
should be located either in the PATH or in a directory with the main Makefile.

Mandatory variables:

* PROJECT — name of the library to build

Targets:

* compile (default) — compile (build) the library
* check — run unit tests
* clean — remove all the beam files including dependencies and plugins
* distclean — delete the "_build" directory recursively
* shell — get into an Erlang shell with all the modules loaded
* upgrade — upgrade dependencies
* git-release — create current library version tag and push to repository
* version — prints full version (i.e. library and git SHA)

### Erlangbin.mk

Provides targets for building an [Erlang] application as a single binary.
Includes all the targets from [Erlanglib.mk] and also based on [Rebar3].

Mandatory variables are the same as for Erlanglib.mk.

Targets (in addition to Erlanglib.mk):

* install — install built executable
* uninstall — uninstall installed executable
* run — run built executable
* join — join the running executable Erlang machine with remote shell
* erlang-compile — create an Erlang release minimal for the executable to run
* erlang-clean — delete the Erlang release
* erlang-install — install Erlang release

The "install" and "uninstall" targets use the following path:

```
$(DESTDIR)/$(PREFIX)/$(BINDIR)/$(PROJECT)
```

with the following default settings:

* DESTDIR — ""
* PREFIX — "usr/local"
* BINDIR — "bin"
* PROJECT — set by user

The "erlang-" targets are based on the [R3erlang] plugin that Rebar3 downloads
automatically.

### Docker.mk

Provides targets to simplify [Docker] image buliding.

Mandatory variables:

* USER — used as Docker ID
* PROJECT — used as Docker image name
* VERSION — used Docker image tag

Targets:

* docker-build — build docker image
* docker-push — push docker images into registry
* docker-release — create "latest" tag and push into registry
* docker-release-local — create "latest" tag
* docker-run — run image container with default entry point
* docker-start — run image container with default entry point in background
* docker-stop — stop running container
* docker-join — join a running in container Erlang application with remote shell
* docker-shell — exec shell in a running container
* docker-attach — attach into a running container
* docker-logs — print logs of a running container
* docker-logs-f — continuosly print logs of a running container
* docker-clean — remove image of the current version
* docker-distclean — remove both "latest" and the current version images

The "run" and "start" targets enable "--rm" and "-it" swithes to enable
terminal emulation, interactive mode and delete the container when stopped.

There is no "detach" target, so to detach you need to close the used terminal
window.

<!-- Links -->
[MIT]: https://opensource.org/licenses/MIT
[Docker]: https://docs.docker.com
[Erlang]: http://erlang.org
[Rebar3]: https://www.rebar3.org
[R3erlang]: https://github.com/aialferov/r3erlang
[Makefiles]: https://www.gnu.org/software/make
[Dockerfile]: Dockerfile
[Erlanglib.mk]: https://github.com/aialferov/mk#erlanglibmk

<!-- Badges -->
[MIT badge]: https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square
