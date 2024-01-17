#!/bin/bash

if [ "$EUID" -ne 0 ]; then 
  echo "Must run as superuser"
  exit
fi

if [ ../intel/versionDetection.sh -ne "Cope" ]; then
    version=$(../intel/versionDetection.sh | awk '{print $4}')
else
    version="Cope"
fi
archType=($../intel/archType.sh)
if [ "$version" -ne "Cope" && $"archType" == "x86_64" ]; then
    echo "WAZUH_MANGER='IDK'" > /tmp/wazuh_envs && installer -pkg wazuh-agent-4.7.2-1.intel64.pkg -target /
elif [ "$version" == "Big Sur" || "$version" == "Monterey" || "$version" == "Ventura" || "$version" == "Sonoma" ]; then
    if [ "$archType" == "arm64"]; then
        echo "WAZUH_MANAGER='10.0.0.2'" > /tmp/wazuh_envs && installer -pkg wazuh-agent-4.7.2-1.arm64.pkg -target /
    fi
else
    echo "This is to old we F'ed"
    exit
fi

/Library/Ossec/bin/wazuh-control start
echo "Wazuh Agent Installed"