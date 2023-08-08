#!/bin/bash

function install_with_retry {
    local command="$1"
    local retry_count=2
    local tries=0
    local success=false

    while [ $tries -le $retry_count ]; do
        $command && success=true && break
        tries=$((tries+1))
    done

    if [ "$success" = false ]; then
        echo "Command failed after $retry_count retries: $command"
        exit 1
    fi
}

# Install Node.js and npm using Node Version Manager (nvm)
install_with_retry "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash"
source ~/.bashrc
install_with_retry "nvm install 14"
install_with_retry "nvm use 14"

# Install TypeScript and related tools
install_with_retry "npm install -g typescript"
install_with_retry "npm install -g prettier eslint eslint_d ts-node"

echo "TypeScript development environment is set up!"

