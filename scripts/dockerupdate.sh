for d in /srv/compose/*
    if test -f "$d/compose.yml"; or test -f "$d/docker-compose.yml"
        cd "$d"
        docker compose pull
        docker compose up -d --remove-orphans
    end
end
docker image prune -f
