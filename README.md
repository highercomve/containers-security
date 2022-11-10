Make your container and docker more secure
==========================================

In order to run more secure containers there is a several path that we can take in the host device in order to have a more secure approach to containers. But for that we need to know a couple of things, almost all containers runs as root inside the containers, and using --privileged will add more capabilities to the containers that may need.

I want to tackle some of the features available on docker to make our containers environment more secure. I will talk about:

* [How to sign and run signed containers](sign_containers.md)
* [How to isolate containers with a user namespace](isolate_containers.md)
* Use Linux capabilities to run your container
* Restric syscalls when running your container (Seccomp security profiles for Docker)



### REFERENCES

1. [Content trust in Docker](https://docs.docker.com/engine/security/trust/)
2. [User namepaces](https://docs.docker.com/engine/security/userns-remap/)
4. [Seccomp security profiles for Docker](https://docs.docker.com/engine/security/seccomp/)