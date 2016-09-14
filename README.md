> Had to change the repo name because the [trademark guidelines of Docker Inc.](https://www.andreas-jung.com/contents/dont-use-docker-in-github-repo-names-or-as-twitter-handle) don't allow fair use by the community.

# Demo setup for Jenkins 2 using Docker.
It pre-installs a few useful plug-ins, including:

- GitHub auth
- Build pipeline setup
- Build timeouts
- Blue Ocean (beta) interface
- Build Docker images in CI

**Note:** If you want to push your Docker images to the registry after successful build, you have to log into your DockerHub account _on the host machine_ first.


## Setup

#### Optional: Link `/var/run/docker.sock` (OS X only)
If you want to use Docker for your CI environment inside docker, it's a good idea to [use the host's Docker socket](https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/) for that. On Docker for Mac, check first if `/var/run/docker.sock` exists on your system. If that's not the case, you can [create it as symlink](https://forums.docker.com/t/cant-find-docker-sock-after-system-upgrade-to-10-11-5/13323/12). The link will persist even if the Docker Engine restarts:

`sudo ln -sf /Users/YOURUSERNAME/Library/Containers/com.docker.docker/Data/s60 /var/run/docker.sock`

#### Optional: Create self-signed certificate for localhost to use HTTPS
Create SSL keys for `localhost` using `generate-ssh-cert`. If you are using OS X, open Keychain, drag `jenkins.crt` onto the list of certificates and select `Always trust`.

Comment in the line `JENKINS_OPTS` in [docker-compose.yml](docker-compose.yml).


## Configuring Jenkins

1. Start the container using `docker-compose up`.
2. Open `https://localhost:8080`, Jenkins should be running.
3. Enter the initial admin password (from the console output or `/var/jenkins_home/secrets/initialAdminPassword`)
4. Skip setup process (press 'x' in the top right corner)
5. Go to "Manage Jenkins" > "Configure Global Security"
6. Select "Github Authentication Plugin" on "Security Realm"
7. Open https://github.com/settings/applications/new in a new tab, fill out the form.  
   Authorization callback URL is `https://localhost:8080/securityRealm/finishLogin`.
8. Add Client ID/Secret in Jenkins and login with your GitHub account.


## Further ideas

- Integrate Docker image security scanner
- Integrate ZAP proxy for application security tests


## Links

- [Official Jenkins Docker image](https://github.com/jenkinsci/docker)
- [Inspiration: Jenkins setup of Docker Meetup DUS #3](https://github.com/ivx/docker-meetup-jenkins2)
