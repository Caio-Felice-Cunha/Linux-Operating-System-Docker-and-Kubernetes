# Linux, Docker, and Kubernetes

A hands-on, 8-part lab repository covering Linux administration inside containers, Docker, Docker Compose, Docker Swarm, and Kubernetes. Each folder is a self-contained lab with a `Script & Explanations` walkthrough plus the code and config files used in it.

These are my study materials and lab exercises from the "Preparação para Carreira de Cientista de Dados" track provided by [Data Science Academy](https://www.datascienceacademy.com.br/).

## What this is

The goal is to go from "run a single Ubuntu container" to "deploy and orchestrate a multi-service stack," one lab at a time. Labs build on each other: you learn the Linux filesystem and permissions first, then networking, then bash automation, then packaging a Python app, then composing several services, then scaling and updating them with Swarm and Kubernetes.

## Labs

1. [Linux Terminal in Docker](01-Linux-Management-With-Docker): users, groups, permissions, files and folders inside a container.
2. [Directory Structure, File System, Partitions, and Volumes](02-Linux-Docker-Filesystem): bind mounts and named volumes, host-to-container file sharing.
3. [Networking with Docker and Linux](03%20-%20Networking%20with%20Docker%20and%20Linux): container networking basics.
4. [Automating Tasks with Bash Script](04%20-%20CreatingBash%20Scripts%20for%20Automation): bash scripts run inside a mounted container.
5. [Python Application Deployment with Linux and Docker](05%20-%20Deploying%20Python%20Applications%20with%20Linux%20and%20Docker): a small Flask app packaged in a Docker image.
6. [Container Deployment with Docker Compose](06%20-%20Container%20Deployment%20with%20Docker%20Compose): two Compose stacks, a Flask + Redis hit counter (deploy1) and a web + Node API + Postgres stack (deploy2).
7. [Container Orchestration with Docker](07%20-%20Docker%20Container%20Orchestration): the same hit counter scaled and updated with Docker Swarm.
8. [Container Orchestration with Kubernetes](08%20-%20Container%20Orchestration%20with%20Kubernetes): running the app on Minikube.

## Run the two app demos

### Lab 5: Flask app (no Docker needed)

```sh
cd "05 - Deploying Python Applications with Linux and Docker/Files"
python -m venv .venv && . .venv/Scripts/activate      # or: source .venv/bin/activate
pip install -r requirements.txt
flask run --host 0.0.0.0 --port 3000
```

Open http://localhost:3000. The page reads `file.json` and renders the superhero squad (name, hometown, and each member). A pytest suite covers this:

```sh
pip install pytest && pytest
```

Verified on Python 3.13: `5 passed`.

### Lab 6 deploy2: Node API (no Docker needed)

```sh
cd "06 - Container Deployment with Docker Compose/mydeployments/deploy2/my_api/src"
npm install
node server.js
```

Then `GET http://localhost:5000/api/test` returns:

```json
{"result": "Success! The API works!"}
```

This API is a stub: it returns a fixed response and does not query a database. In the full Compose stack it sits behind an Nginx web server alongside a Postgres container.

### Lab 6 / 7 full stacks (need Docker)

The Compose and Swarm labs need Docker running. For deploy2, copy `.env.example` to `.env` first (it holds the demo Postgres credentials and `MY_ENVIRONMENT`), then `docker compose up`. The Swarm lab in folder 7 follows the `docker service create` flow documented in its `Script and Explanations.md`.

## Notes

- No real secrets are committed. The demo database credentials live in `.env.example` and the real `.env` is gitignored.
- Runtime artifacts (`volume/`, `node_modules/`, `__pycache__/`) are gitignored.

Contributions, issues, and pull requests are welcome.
