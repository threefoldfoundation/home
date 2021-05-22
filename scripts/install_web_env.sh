
set -ex

if [[ "$OSTYPE" == "darwin"* ]]; then
  # check brew is installed
  if ! [ -x "$(command -v brew)" ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"  
  fi
fi
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/crystaluniverse/publishtools/development/scripts/install.sh)"
mkdir -p ~/code
cd ~/code

echo "check ~/code/www_config_private exists"
if [ ! -d "~/code/www_config_private" ]; then
  echo "need to clone"
  git clone git@github.com:threefoldfoundation/www_config_private.git
fi

cd www_config_private
# go into wiki only dir
cd wiki_only
publishtools develop


