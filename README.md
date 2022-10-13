# cafe-grader-docker
Dockerized Cafe Grader

## Setup
1. `git clone --recursive https://github.com/plumsirawit/cafe-grader-docker.git`
2. Change all the passwords
3. Generate an SSL certificate (recommended: `certbot certonly --standalone`; more info: https://certbot.eff.org/)
4. Copy the content of the certificate into the `cert` directory and edit `nginx.conf` accordingly. (warning: don't use symlink if you don't know what you're doing since it doesn't work directly on Docker)
5. `docker compose up --build` should do it.

### Remarks
- This project is quite old (and it was my first try dockerizing something related to my personal life such as a competitive programming online judge, apart from the fossil grader).
- It may not (or may) be maintainable since we're trying to migrate everything from `cafe-grader` to `ioi-cms` in programming training camps.
