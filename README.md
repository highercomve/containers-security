Make your container and docker more secure
==========================================

In order to run more secure containers there is a several path that we can take in the host device in order to have a more secure approach to containers. But for that we need to know a couple of things, almost all containers runs as root inside the containers, and using --privileged will add more capabilities to the containers that may need.

I want to tackle some of the features available on docker to make our containers environment more secure. I will talk about:

* How to sign and run signed containers
* How to isolate containers with a user namespace
* Use Linux capabilities to run your container
* Restric syscalls when running your container (Seccomp security profiles for Docker)

## How to sign and run signed containers

In order to run containers you need to use the environment variable `DOCKER_CONTENT_TRUST=1`. With this docker will validate the signature before running the container.

You can check if a container has been signed by using:

```bash
docker trust inspect --pretty hello-world
```

This will give somethig similar to 

```bash
docker trust inspect --pretty highercomve/rtc

Signatures for highercomve/rtc

SIGNED TAG   DIGEST                                                             SIGNERS
latest       53df909c1eddea1346c018d5efee7f0bdd8387945be74a69ac0267853efa4f6f   (Repo Admin)

Administrative keys for highercomve/rtc

  Repository Key:	9e673aca6ae047a0b8b5f85ac28dca8377633945981747fe4fb094b4efc78479
  Root Key:	5633f2b325f0862d6e5ea392837acc519c6f1c00e739d5ce7abe0067b0f6ddf9
```

### REFERENCES

1. [Content trust in Docker](https://docs.docker.com/engine/security/trust/)
2. [User namepaces](https://docs.docker.com/engine/security/userns-remap/)
4. [Seccomp security profiles for Docker](https://docs.docker.com/engine/security/seccomp/)