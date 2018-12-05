#!/bin/env bash
APP_DIR=/opt/hansight/nta
# APP_DIR=/home/nenote/nta
APP_BIN=${APP_DIR}/bin
APP_NAME=nta
APP_CONF=${APP_DIR}/etc/${APP_NAME}
APP_EXE=${APP_BIN}/${APP_NAME}
CRON_INFO=nta_cron
APP_WEB_DIR=${APP_DIR}/web
APP_PROME_DIR=${APP_DIR}/prometheus
APP_NIC_CONFIG=${APP_DIR}/bin/nta_nic.sh
APP_SUPERVISOR_FILE=${APP_DIR}/bin/supervisor_nta.sh
# suricata_dir=/tmp/suricata   # 存储路径
# nic_name=enp4s0f2			 # 网卡


parse_yaml() {
   # local prefix=$2
   local s='[[:space:]]*' w='[a-zA-Z0-9_\-]*' fs=$(echo @|tr @ '\034')
   sed -ne "s|^\($s\)\($w\)$s:$s\"\(.*\)\"$s\$|\1$fs\2$fs\3|p" \
   		-e "s|^\($s\)\($w\)$s:$s\(.*\)$s#.*\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\) -$s\($w\)$s:|\1 ${fs}array_\2${fs}|p" \
        -e "s|^\($s\) -$s\($w\)$s|\1 ${fs}array_$fs\2|p" $1 |
   awk -F$fs '{
      indent = length($1)/2;
      # printf("%d    %d\n",indent, $NF)
      if (length($1) == 0) {  
      	#statements
      	for (i in vname) {if (i > indent) {delete vname[i]}}
      }
      vname[indent] = $2;
      # printf("######### %s\n", vname[indent])
      # for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {
         	if (vname[i] != ""){
         		vn=(vn)(vname[i])("_")
         	}
         }
         vn=(vn)($2)
         gsub("-", "_", vn)
         gsub(" ", "", $3)
         printf("%s=\"%s\"\n", vn, $3);
      }
   }'
}

start_nta_by_supervisor()
{
    NTA_START_PARAM="${APP_EXE} -k none --af-packet  -l ${nta_dir} --pidfile ${pid_file}"
    rm ${APP_SUPERVISOR_FILE} -f
    echo "#!/bin/sh" > ${APP_SUPERVISOR_FILE}
    echo "rm ${pid_file} -f" >> ${APP_SUPERVISOR_FILE}
    echo "rm /dev/mqueue/hipc* -f" >> ${APP_SUPERVISOR_FILE}
    echo "pkill oracle_parser" >> ${APP_SUPERVISOR_FILE}
    echo "pkill pop3_parser" >> ${APP_SUPERVISOR_FILE}
    echo "exec ${NTA_START_PARAM}" >> ${APP_SUPERVISOR_FILE}
    chmod +x ${APP_SUPERVISOR_FILE}
    ret=`supervisorctl update nta`
    if [ -z "$ret" ]; then
        supervisorctl start nta:*
    fi
}
start(){
	echo "正在启动 NTA 服务...."
  if [[ -d ${APP_WEB_DIR} ]]; then
    #statements
    rst=$(ps -ef | grep 'PM2' | grep -v 'grep')
    if [[ -z ${rst} ]]; then
      #statements
      cd ${APP_WEB_DIR}; . ./run.sh ; cd -
    fi
  fi
  if [[ -d ${APP_PROME_DIR} ]]; then
    #statements
    rst=$(pidof prometheus)
    if [[ -z ${rst} ]]; then
      #statements
      . ${APP_PROME_DIR}/prome.sh start
    fi
  fi
    eval $(parse_yaml ${APP_CONF}/${APP_NAME}.yaml)
    rst=`supervisorctl status nta | grep RUNNING`
    if [[ -n ${rst} ]]; then
    	#statements
    	echo "ntas had run; please stop!"
    	exit
    fi
    if [[ -d ${nta_dir} ]]; then
      #statements
      echo ""
    else
      rm -f ${nta_dir}
      mkdir -p ${nta_dir}
    fi
    if [[ -d "/var/log/nta" ]]; then
      echo ""
    else
      mkdir -p /var/log/nta/
    fi
    ${APP_NIC_CONFIG}
    start_nta_by_supervisor
}

stop(){
    echo "正在停止服务...."
    eval $(parse_yaml ${APP_CONF}/${APP_NAME}.yaml)
    case $1 in
      "nta" )
       supervisorctl stop nta:*
        ;;
      "web" )
       cd ${APP_WEB_DIR}; . ./stop.sh ; cd -
        ;;
      "prometheus" )
       . ${APP_PROME_DIR}/prome.sh stop
        ;;
      "all" )
       supervisorctl stop nta:*
       cd ${APP_WEB_DIR}; . ./stop.sh ; cd -
       . ${APP_PROME_DIR}/prome.sh stop
        ;;
      * )
       supervisorctl stop nta:*
        ;;
    esac
    
    
}

restart(){              # restart函数 
    stop 
    eval $(parse_yaml ${APP_CONF}/${APP_NAME}.yaml)
    rst=`supervisorctl status nta | grep RUNNING`
    while [[ -n ${rst} ]]
    do 
      sleep 2
      rst=`supervisorctl status nta | grep RUNNING`
    done
    start          # 直接调用stop、start函数， 
} 

status(){                        # status函数 
    echo ""
    echo -n "NTA running status: "
    rst=`supervisorctl status nta | grep RUNNING`
    if [[ -n "${rst}" ]]; then 
        echo "$0 服务正在运行"
    else
        echo "$0 服务已经停止"
    fi
    
} 

case "$1" in        # case分支结构匹配，$1位置参数对控制参数调用 
"start") 
        start      # 调用start函数
        ;; 
"stop")            # 调用stop函数 
        stop $2
        ;; 
"status")            # 调用status函数 
        status 
        ;; 
"restart")            # 调用restart函数 
        restart 
        ;; 
"parse")
        eval $(parse_yaml ${2})
        parse_yaml ${2}
        ;;
"setup")
	;;
"clear")
        ;;
*)                # 其他参数就输出脚本正确用法 
        echo "用法：$0 start|stop [nta | web | prometheus | all]|status|restart"
        ;; 
esac
