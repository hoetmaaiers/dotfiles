mkdir -p "$HOME/.docker/cli-plugins"

ln -sfn "$(brew --prefix)/opt/docker-compose/bin/docker-compose" \
    "$HOME/.docker/cli-plugins/docker-compose"
