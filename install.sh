## Install Dependencies
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install boost cmake

## Make folder
mkdir -p ~/Go
cd ~/Go

## Build Leela Zero
git clone --recursive --branch next http://github.com/gcp/leela-zero.git
cd leela-zero

# Use stand alone directory to keep source dir clean
mkdir build && cd build
cmake ..
cmake --build .
./tests
