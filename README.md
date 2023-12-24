# High Secured Docker Env

Most of time docker containers runs with `root` account. This is a big vulnerability.
Because of that I created a docker files which runs everything with current
user account name and UID and GUID.

Once my servers were hacked. The hacker boy became root in my servers.
I don't know what is the main problem but I doubt from the docker containers
which runs with root account. After that time I decided to change
docker files. This project contains docker files which can run without root
account.

### Important Note

For now some features not working, I'm working on it.
