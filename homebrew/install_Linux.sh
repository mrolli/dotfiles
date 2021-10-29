#!/usr/bin/env bash

curl_version="7.78.0"
git_version="v2.33.0"
my_bash_profile=~/.bash_profile.local

# Do not run this script as user root
[ $UID -eq 0 ] && echo "Do not run this as root!" && exit 1

if [ -x /home/linuxbrew/.linuxbrew/bin/brew -o -x $HOME/.linuxbrew/bin/brew ]
then
  echo "Homebrew already installed"
  exit 0
fi

# Install required software
sudo yum -y groupinstall "Development tools"
sudo yum -y install wget git gcc autoconf expat-devel gettext-devel openssl-devel zlib-devel perl-ExtUtils-MakeMaker asciidoc xmlto

# Installt to ~/usr and make the compiled binary available
export PREFIX="${HOME}/usr"
export PATH="${PREFIX}/bin:${PATH}"
export PKG_CONFIG_PATH="${PREFIX}/lib/pkgconfig:${PKG_CONFIG_PATH}"
export LD_LIBRARY_PATH="${PREFIX}/lib:${LD_LIBRARY_PATH}"
export MANPATH="${PREFIX}/share/man:${MANPATH}"
export INFOPATH="${PREFIX}/share/info:${INFOPATH}"

# Unpack and compile cURL
mkdir -p $PREFIX/src
cd $PREFIX/src
wget -N https://curl.se/download/curl-${curl_version}.tar.xz
tar xf curl-${curl_version}.tar.xz
cd curl-${curl_version}
./configure --prefix=${PREFIX}                      \
            --disable-static                        \
            --with-openssl                          \
            --enable-threaded-resolver
make
make install
cd ..
rm -rf curl-${curl_version}

# Fetch and compile Git
cd $PREFIX/src
git clone https://github.com/git/git.git
cd git
git checkout $git_version
autoconf && ./configure --prefix="${PREFIX}" --with-curl="${PREFIX}" && make && make install && make man && make install-man

# Now install Homebrew using the compiled tools
/bin/bash -c "CI=true $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Find installed brew command and prepare the environment
if [ -x /home/linuxbrew/.linuxbrew/bin/brew ]
then
  brew_path=/home/linuxbrew/.linuxbrew/bin/brew
elif [ -x ~/.linuxbrew/bin/brew ]
then
  brew_path=~/.linuxbrew/bin/brew
else
  echo "Unable to find brew script"
  exit 1
fi
eval "$(${brew_path} shellenv)"

# For HOMEBREW_*_PATH to work, also HOMEBREW_DEVELOPER has to be set
export HOMEBREW_DEVELOPER=1
export HOMEBREW_CURL_PATH=~/usr/bin/curl
export HOMEBREW_GIT_PATH=~/usr/bin/git

# Install git using a compiled curl and bottled git and from then on use the brewed versions
brew install -s curl
brew install gcc git

# Get rid of temp env variables and the final needed froced curl version
unset HOMEBREW_DEVELOPER HOMEBREW_CURL_PATH HOMEBREW_GIT_PATH

# Show final config
HOMEBREW_FORCE_BREWED_CURL=1 brew config

# update the local bash_profile of current user
echo "export HOMEBREW_FORCE_BREWED_CURL=1" >> $my_bash_profile
echo "export HOMEBREW_NO_AUTO_UPDATE=1" >> $my_bash_profile
echo 'eval "$('$brew_path' shellenv)"' >> $my_bash_profile

exit 0
