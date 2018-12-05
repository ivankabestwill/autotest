WORK_PATH=$1
INSTALL_PATH=$2
RESULT=$3
INT=$4
FUNC_PATH=$5

cp -fr ${FUNC_PATH}/config_files/nta.yaml.more_dev ${INSTALL_PATH}/nta/etc/nta/nta.yaml 
cp -fr ${FUNC_PATH}/config_files/pcap_save.ini.more_dev ${INSTALL_PATH}/nta/etc/pcap_save/pcap_save.ini
cp -fr ${FUNC_PATH}/config_files/nta_start.sh ${INSTALL_PATH}/nta/bin/nta_start.sh 
cp -fr ${FUNC_PATH}/config_files/supervisor_nta.sh ${INSTALL_PATH}/nta/bin/supervisor_nta.sh
${INSTALL_PATH}/nta/bin/pcap_save.sh restart >/dev/null 2>/dev/null
${INSTALL_PATH}/nta/bin/nta_start.sh restart >/dev/null 2>/dev/null
