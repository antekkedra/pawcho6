# Sprawozdanie 2
## Opis Dockerfile

## Użyte komendy
### Polecenie użyte do budowy obrazu
```bash
DOCKER_BUILDKIT=1 docker build \
        --no-cache \
        --ssh default \
        --build-arg VERSION=2.0 \
        -t pawcho6:lab6 .
```
### Polecenie uruchamiające serwer
```bash
docker run -dp 8080:80 ghcr.io/antekkedra/pawcho6:lab6
docker run -dp 8080:80 --name lab6 pawcho6:lab6
```
### Polecenie potwierdzające poprawne funkcjonowanie
```bash
docker inspect --format='{{.State.Health.Status}}' lab6
```
### Polecenie potwierdzające że aplikacja realizuje wymaganą funkcjonalność
```bash
curl http://localhost:8080
```
