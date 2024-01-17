#!/bin/bash

if  [ "$EUID" -ne 0 ];
then
    echo "User is not root. Skill issue."
    exit
fi

#things to download: homebrew

#downloads homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update
brew upgrade

brew install git curl vim tcpdump lynis net-tools tmux nmap fail2ban psad debsums clamav snoopy auditd

#linpeas
curl -L https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh | sh

