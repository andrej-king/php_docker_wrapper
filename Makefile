# Run dev docker containers.
init: docker-down-clear docker-build docker-up

# Stop dev docker containers.
down: docker-down-clear

# Run docker containers from dev docker compose file.
docker-up:
	docker compose up --remove-orphans -d

# Stop docker containers. Remove orphan containers.
docker-down:
	docker compose down --remove-orphans

# Stop docker containers. Remove orphan containers and clear volumes.
docker-down-clear:
	docker compose down -v --remove-orphans

# Download docker images required for dev docker compose file.
docker-pull:
	docker compose pull

# Build docker images from dev docker compose file.
docker-build:
	docker compose build

# Force rebuild docker images from dev docker compose file.
docker-rebuild:
	docker compose build --no-cache
