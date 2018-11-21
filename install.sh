## Make folder
mkdir -p ~/Go
cd ~/Go

## Install Dependencies
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install boost cmake wget gnu-sed

## Build Leela Zero
git clone --recursive --branch next http://github.com/gcp/leela-zero.git
cd leela-zero

# Use stand alone directory to keep source dir clean
mkdir build && cd build
cmake -DUSE_CPU_ONLY=1 ..
cmake --build .
./tests
cd ..

## Lizzie
wget https://github.com/featurecat/lizzie/releases/download/0.6/Lizzie.0.6.Mac-Linux.zip
unzip Lizzie.0.6.Mac-Linux.zip
rm Lizzie.0.6.Mac-Linux.zip
cd Lizzie
ln -s ../leela-zero/build/leelaz .
cd ..

## Go Review Partner
wget https://github.com/pnprog/goreviewpartner/archive/v0.14.2.zip
unzip v0.14.2.zip
rm v0.14.2.zip
cd goreviewpartner-0.14.2
gsed -i \
    -e '86s|^.*$|slowcommand = ~/Go/leela-zero/build/leelaz|'\
    -e '87s|^.*$|slowparameters = --gtp --noponder --weights ~/Go/Lizzie/network.gz|'\
    -e '89s|^.*$|fastcommand = ~/Go/leela-zero/build/leelaz|'\
    -e '90s|^.*$|fastparameters = --gtp --noponder --weights ~/Go/Lizzie/network.gz|' \
    config.ini
    
