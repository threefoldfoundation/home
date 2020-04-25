
set -ex
    
if ! [ -x "$(command -v wget)" ]; then
    brew install wget
fi

if ! [ -x "$(command -v git)" ]; then
    brew install git
fi

if ! [ -x "$(command -v tfwiki)" ]; then
    cd $TMPDIR
    rm -rf tfwiki
    wget 'https://github.com/threebotserver/publishingtools/releases/download/v1.0/tfwiki'
    chmod 770 tfwiki
    cp tfwiki /usr/local/bin/tfwiki
fi


if ! [ -x "$(command -v caddy)" ]; then
    # cd $TMPDIR
    # rm -rf caddy*
    # wget 'https://github.com/caddyserver/caddy/releases/download/v2.0.0-rc.3/caddy_2.0.0-rc.3_mac_amd64.tar.gz'
    # tar xvzf caddy_2.0.0-rc.3_mac_amd64.tar.gz
    # cp caddy /usr/local/bin/caddy
    # rm -rf caddy*
    curl https://getcaddy.com | bash -s personal
fi

mkdir -p $HOME/threefold/websites
cd $HOME/threefold/websites

if [ -d www_threefold ]; then
    cd www_threefold
    git checkout . -f
    git pull
    cd ..
else
    git clone --depth 1 'https://github.com/threefoldfoundation/www_threefold.io_new.git' www_threefold
fi

if [ -d info_tfgridsdk ]; then
    cd info_tfgridsdk
    git checkout . -f
    git pull
    cd ..
else
    git clone --depth 1 'https://github.com/threefoldfoundation/info_tfgridsdk' info_tfgridsdk
fi


if [ -d info_threefold ]; then
    cd info_threefold
    git checkout . -f
    git pull
    cd ..
else
    git clone --depth 1 'https://github.com/threefoldfoundation/info_threefold' info_threefold
fi

if [ -d home ]; then
    cd home
    git checkout . -f
    git pull
    cd ..
else
    git clone --depth 1 'https://github.com/threefoldfoundation/home' home
fi


set +ex
killall tfwiki
tmux kill-ses -t tf_sdk
set -ex

#start wiki for tfgridsdk
echo 'tfwiki -s -p 3001 -d $HOME/threefold/websites/info_tfgridsdk/src' > $TMPDIR/tf_sdk.sh
chmod 770 $TMPDIR/tf_sdk.sh
tmux new-session -d -s "tf_sdk" $TMPDIR/tf_sdk.sh
#to go to it
#tmux a -t tf_sdk 

#start wiki for info_threefold
echo 'tfwiki -s -p 3002 -d $HOME/threefold/websites/info_threefold/src' > $TMPDIR/info_threefold.sh
chmod 770 $TMPDIR/info_threefold.sh
tmux new-session -d -s "info_threefold" $TMPDIR/info_threefold.sh

#start caddy
echo 'cd $HOME/threefold/websites/home/caddy;caddy' > $TMPDIR/caddy.sh
chmod 770 $TMPDIR/caddy.sh
tmux new-session -d -s "caddy" $TMPDIR/caddy.sh


#remove entries from threefold from hosts file
sudo sed -i .back "/threefold/d" /private/etc/hosts
#now add the required domain names
sudo -- sh -c -e "echo 127.0.0.1 info.threefold.io >> /private/etc/hosts";
sudo -- sh -c -e "echo 127.0.0.1 www.threefold.io >> /private/etc/hosts";
sudo -- sh -c -e "echo 127.0.0.1 sdk.threefold.io >> /private/etc/hosts";

