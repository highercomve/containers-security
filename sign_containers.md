How to sign and run signed containers
==================

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

#### How to create/load a key for signing

You can create or load key to be used by docker to sign the containers on push. 

```
docker trust key generate highercomve
```

If you want to load a key from a pem file, you can do it by:

```
docker trust key load key.pem --name highercomve
```

This will give you an output similar to this one:

```
Generating key for highercomve...
Enter passphrase for new highercomve key with ID 4edf2b8:
Repeat passphrase for new highercomve key with ID 4edf2b8:
Successfully generated and loaded private key.
Corresponding public key available: /home/sergio/highercomve.pub
```

After that key is created you can now assign that key as signer to an speficic registry or to all registries.

```
docker trust signer add highercomve --key /home/sergio/highercomve.pub highercomve/rtc
```

With this step ready, the next time you push a new image to that repository is going to signed as part of the last step.

```
docker push highercomve/rtc
Using default tag: latest
The push refers to repository [docker.io/highercomve/rtc]
aee2b47d7e0b: Layer already exists 
a07a2faf6946: Layer already exists 
994393dc58e7: Layer already exists 
latest: digest: sha256:53df909c1eddea1346c018d5efee7f0bdd8387945be74a69ac0267853efa4f6f size: 949
Signing and pushing trust metadata
Enter passphrase for repository key with ID 9e673ac: 
Successfully signed docker.io/highercomve/rtc:latest
```
