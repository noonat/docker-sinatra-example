Docker Sinatra Example
======================

This is an example Dockerfile for a simple Sinatra app. It uses
[noonat/rbenv-nodenv] as a base image, and provides a Rakefile for common
Docker commands:

```bash
$ rake --tasks
rake docker:build  # Build the Docker image
rake docker:pull   # Pull the Docker image from the registry
rake docker:push   # Push the Docker image up to the registry
rake docker:run    # Run the Docker container in the foreground
rake docker:shell  # Run Bash within the Docker container
rake githooks      # Install Git hooks
rake lint          # Validate source files
rake server:run    # Run the server
rake watch         # Use Guard to watch for changes and reload things
```

Note that the Rakefile is a convenience but is not required. If you don't have
Ruby available for some reason on your host machine, you can just run the
Docker commands in the Rakefile directly.

To get started, first install Docker as appropriate for your platform. You can
make sure it's running properly with:

```bash
$ docker ps
CONTAINER ID    IMAGE    COMMAND    CREATED    STATUS    PORTS    NAMES
```

Then, build the Docker image:

```bash
$ rake docker:build
Sending build context to Docker daemon 84.48 kB
Sending build context to Docker daemon
Step 0 : FROM noonat/rbenv-nodenv
... snip ...
Successfully built d951ecbfb464
```

This command will take a while the first time, but the Ruby installation step
will be cached by Docker for future builds.

Finally, run the Docker image:

```bash
$ rake docker:run
docker run --rm --interactive --tty --publish 80:80 --name docker-sinatra-example noonat/docker-sinatra-example
rackup --env production --port 80 --server thin
Thin web server (v1.6.3 codename Protein Powder)
Maximum connections set to 1024
Listening on 0.0.0.0:80, CTRL+C to stop
```

You should be able to access the site via your browser on the IP that the
Docker host is running on. Note that, for Mac, you can get this IP address by
running `boot2docker ip` or `docker-machine ip` depending on how you installed
Docker.

[noonat/rbenv-nodenv]: https://registry.hub.docker.com/u/noonat/rbenv-nodenv
