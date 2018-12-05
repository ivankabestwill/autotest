

WORK_PATH=$1
INSTALL_PATH=$2
RESULT=$3

SUDO_PWD=$4


${INSTALL_PATH}/nta/bin/nta_start.sh stop >/dev/null 2>/dev/null
sleep 5
rm -fr /tmp/nta >/dev/null 2>/dev/null
