#!/bin/bash
set -e
curl -fsSLO "https://raw.githubusercontent.com/Homebrew/install/master/uninstall"
chmod 0755 uninstall && ./uninstall -fq && rm -f uninstall
/usr/bin/sudo /usr/bin/find /usr/local -mindepth 2 -delete && hash -r
export OS_MAJOR=$(uname -r | cut -f 1 -d .)
curl -fsSLO "https://dl.bintray.com/macports-ci-bot/macports-base/MacPorts-${OS_MAJOR}.tar.bz2"
sudo tar -xpf "MacPorts-${OS_MAJOR}.tar.bz2" -C /
rm -f "MacPorts-${OS_MAJOR}.tar.bz2"
unset CC && source /opt/local/share/macports/setupenv.bash
echo "ui_interactive no" | sudo tee -a /opt/local/etc/macports/macports.conf
sudo /opt/local/postflight && sudo rm -f /opt/local/postflight
sudo port -v sync
set +e
