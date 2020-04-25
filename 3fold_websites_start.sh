
set -ex
    
if ! [ -x "$(command -v wget)" ]; then
    brew install wget
fi
if ! [ -x "$(command -v git)" ]; then
    brew install git
fi
if ! [ -x "$(command -v caddy)" ]; then
    cd $TMPDIR
    rm -rf caddy*
    wget 'https://github.com/caddyserver/caddy/releases/download/v2.0.0-rc.3/caddy_2.0.0-rc.3_mac_amd64.tar.gz'
    tar xvzf caddy_2.0.0-rc.3_mac_amd64.tar.gz
    cp caddy /usr/local/bin/caddy
    rm -rf caddy*
fi


# mkdir $HOME/threefold/websites
# cd $HOME/threefold/websites

# mkdir -p code


