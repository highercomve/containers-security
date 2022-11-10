How to isolate containers with a user namespace
===================

Docker in general will run containers, using actual users from the host machine. Example if you run a containers as root, and you give a volume to that container, it will have the same permissions as the root user from the host container, that is why some solutions as podman and the same docker allow you to run the containers as the user that run the container.

But there is another alternative, and that will be create a linux namespace for the users used by docker. Using the setuid/setgid to configurate this. This will allow to remap a container user to another user on the host machine. Example, the user 0 (aka: root), can be the user 25600 in the host machine and with this will never get permissions as root in the host.

#### How to setup the user namespace

The user and group IDs mappings should be configured in the host OS
(/etc/subuid and /etc/subgid)

Each file contains three fields: the username or ID of the user, followed by a beginning UID or GID (which is treated as UID or GID 0 within the namespace) and a maximum number of UIDs or GIDs available to the user. 

For instance, given the following entry:

```
sergio:230000:65536
```

In this example sergio is the name of my personal user in the host machine, you could create a new user for this if you want.

This means that user-namespaced processes started by sergio are owned by host UID 230000 (which looks like UID 0 inside the namespace) through 295535 (230000 + 65536 - 1). These ranges should not overlap, to ensure that namespaced processes cannot access each other’s namespaces.

After this is set, you will need to edit the file `/etc/docker/daemon.json` as root in your host machine.

if the file is empty add this:

```
{
  "userns-remap": "sergio"
}
```

then restart your docker.

```
sudo systemctl restart docker
```

This could vary depending on your distribution.

after that eventought your containers is running as "root" wont have access to anything that is root in the host machine.

```
docker run -it --rm --device /dev/rtc0 --entrypoint /bin/sh highercomve/rtc
/ # id
uid=0(root) gid=0(root) groups=0(root),1(bin),2(daemon),3(sys),4(adm),6(disk),10(wheel),11(floppy),20(dialout),26(tape),27(video)
/ # rtc
panic: failed to open rtc: open /dev/rtc0: permission denied

goroutine 1 [running]:
main.main()
	/app/main.go:13 +0x114

```

As you can see the rtc command fails because doesn't have permission to access the `/dev/rtc0`

You can override this behaviour by running the container with the argument `--userns=host` or you can give permissions to the remaped users (in this case the user 230000)

```
 docker run -it --rm --device /dev/rtc0 --userns=host --entrypoint /bin/sh highercomve/rtc
/ # rtc
Current time: 2022-11-10T23:30:08Z
```
