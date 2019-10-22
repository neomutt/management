#!/bin/bash
set -e

# Uninstall Homebrew
brew --version
/usr/bin/sudo /usr/bin/find /usr/local -mindepth 2 -delete && hash -r

# Download and install MacPorts built by https://github.com/macports/macports-base/blob/travis-ci/.travis.yml
OS_MAJOR=$(uname -r | cut -f 1 -d .)
curl -fsSLO "https://dl.bintray.com/macports-ci-bot/macports-base/2.6r0/MacPorts-${OS_MAJOR}.tar.bz2"
sudo tar -xpf "MacPorts-${OS_MAJOR}.tar.bz2" -C /
rm -f "MacPorts-${OS_MAJOR}.tar.bz2"

unset CC && source /opt/local/share/macports/setupenv.bash
echo "ui_interactive no" | sudo tee -a /opt/local/etc/macports/macports.conf
sudo /opt/local/postflight && sudo rm -f /opt/local/postflight
sudo port -v sync
