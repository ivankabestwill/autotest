WORK_PATH=$1
INSTALL_PATH=$2
RESULT=$3
INT=$4
FUNC_PATH=$5

# ###########################################
# check nta
# ###########################################
# check nta and record pid
pid=`pgrep nta`
if [ "$pid" == "" ] ; then
	echo "got pid fail" >> $RESULT
	exit 1
else
	echo "${pid}" > ${FUNC_PATH}/tmp/tmp_nta.info
fi

flag="pidstat -t -p `pgrep nta` | grep Hansight-nta-Ma"
flag=`eval $flag`
if [ "$flag" == "" ] ; then
	echo "got thread Hansight-nta-Ma fail" >> $RESULT
	exit 1
fi
flag="pidstat -t -p `pgrep nta` | grep W#01 | grep enp1s0f0"
flag=`eval $flag`
if [ "$flag" == "" ] ; then
	echo "got thread W#01-enp1s0f0 fail" >> $RESULT
	exit 1
fi
flag="pidstat -t -p `pgrep nta` | grep W#01 | grep enp0s31f6"
flag=`eval $flag`
if [ "$flag" == "" ] ; then
	echo "got thread W#01-enp0s31f6 fail" >> $RESULT
	exit 1
fi

flag="pidstat -t -p `pgrep nta` | grep W#02| grep enp1s0f0"
flag=`eval $flag`
if [ "$flag" == "" ] ; then
	echo "got thread W#02-enp1s0f0 fail" >> $RESULT
	exit 1
fi
flag="pidstat -t -p `pgrep nta` | grep W#02| grep enp0s31f6"
flag=`eval $flag`
if [ "$flag" == "" ] ; then
	echo "got thread W#02-enp0s31f6 fail" >> $RESULT
	exit 1
fi

flag="pidstat -t -p `pgrep nta` | grep W#03| grep enp1s0f0"
flag=`eval $flag`
if [ "$flag" == "" ] ; then
	echo "got thread W#03-enp1s0f0 fail" >> $RESULT
	exit 1
fi
flag="pidstat -t -p `pgrep nta` | grep W#03| grep enp0s31f6"
flag=`eval $flag`
if [ "$flag" == "" ] ; then
	echo "got thread W#03-enp0s31f6 fail" >> $RESULT
	exit 1
fi

flag="pidstat -t -p `pgrep nta` | grep W#04| grep enp1s0f0"
flag=`eval $flag`
if [ "$flag" == "" ] ; then
	echo "got thread W#0-enp1s0f0 fail" >> $RESULT
	exit 1
fi
flag="pidstat -t -p `pgrep nta` | grep W#04 | grep enp0s31f6"
flag=`eval $flag`
if [ "$flag" == "" ] ; then
	echo "got thread W#0-enp0s31f6 fail" >> $RESULT
	exit 1
fi

flag="pidstat -t -p `pgrep nta` | grep W#05| grep enp1s0f0"
flag=`eval $flag`
if [ "$flag" == "" ] ; then
	echo "got thread W#05-enp1s0f0 fail" >> $RESULT
	exit 1
fi
flag="pidstat -t -p `pgrep nta` | grep W#05| grep enp0s31f6"
flag=`eval $flag`
if [ "$flag" == "" ] ; then
	echo "got thread W#05-enp0s31f6 fail" >> $RESULT
	exit 1
fi

flag="pidstat -t -p `pgrep nta` | grep W#06"
flag=`eval $flag`
if [ "$flag" == "" ] ; then
	echo "got thread W#06 fail" >> $RESULT
	exit 1
fi
flag="pidstat -t -p `pgrep nta` | grep W#06"
flag=`eval $flag`
if [ "$flag" == "" ] ; then
	echo "got thread W#06 fail" >> $RESULT
	exit 1
fi

flag="pidstat -t -p `pgrep nta` | grep W#07| grep enp1s0f0"
flag=`eval $flag`
if [ "$flag" == "" ] ; then
	echo "got thread W#07-enp1s0f0 fail" >> $RESULT
	exit 1
fi
flag="pidstat -t -p `pgrep nta` | grep W#07| grep enp0s31f6"
flag=`eval $flag`
if [ "$flag" == "" ] ; then
	echo "got thread W#07-enp0s31f6 fail" >> $RESULT
	exit 1
fi

flag="pidstat -t -p `pgrep nta` | grep W#08| grep enp1s0f0"
flag=`eval $flag`
if [ "$flag" == "" ] ; then
	echo "got thread W#08-enp1s0f0 fail" >> $RESULT
	exit 1
fi
flag="pidstat -t -p `pgrep nta` | grep W#08| grep enp0s31f6"
flag=`eval $flag`
if [ "$flag" == "" ] ; then
	echo "got thread W#08-enp0s31f6 fail" >> $RESULT
	exit 1
fi

flag="pidstat -t -p `pgrep nta` | grep FM"
flag=`eval $flag`
if [ "$flag" == "" ] ; then
	echo "got thread FM fail" >> $RESULT
	exit 1
fi
flag="pidstat -t -p `pgrep nta` | grep FR"
flag=`eval $flag`
if [ "$flag" == "" ] ; then
	echo "got thread FR fail" >> $RESULT
	exit 1
fi
flag="pidstat -t -p `pgrep nta` | grep CW"
flag=`eval $flag`
if [ "$flag" == "" ] ; then
	echo "got thread CW fail" >> $RESULT
	exit 1
fi
flag="pidstat -t -p `pgrep nta` | grep CS"
flag=`eval $flag`
if [ "$flag" == "" ] ; then
	echo "got thread CS fail" >> $RESULT
	exit 1
fi
flag="pidstat -t -p `pgrep nta` | grep US_web"
flag=`eval $flag`
if [ "$flag" == "" ] ; then
	echo "got thread US_web fail" >> $RESULT
	exit 1
fi
flag="pidstat -t -p `pgrep nta` | grep US| grep -v web"
flag=`eval $flag`
if [ "$flag" == "" ] ; then
	echo "got thread US fail" >> $RESULT
	exit 1
fi

# ###########################################
# check pcap_save
# ###########################################
# check pcap_save and record it pid
pid=`pgrep pcap_save_file`
if [ "$pid" == "" ] ; then
	echo "got pcap_save_file pid fail" >> $RESULT
	exit 1
else
	echo "${pid}" > ${FUNC_PATH}/tmp/tmp_pcap.info
fi
flag="pidstat -t -p `pgrep pcap_save_file` | grep '|' | sed 's/[ ][ ]*/,/g' |grep pcap_save_file|cut -d ',' -f 4"
flag=`eval $flag`
if [ "$flag" == "" ] ; then
	echo "got pcap_save_file thread pcap_delete fail" >> $RESULT
	exit 1
else
	echo "${flag}" > ${FUNC_PATH}/tmp/tmp_pcap_pcap_save_file.info
fi
flag="pidstat -t -p `pgrep pcap_save_file` | grep '|' | sed 's/[ ][ ]*/,/g' |grep log4rs |cut -d ',' -f 4"
flag=`eval $flag`
if [ "$flag" == "" ] ; then
	echo "got pcap_save_file thread log4rs fail" >> $RESULT
	exit 1
else
	echo "${flag}" > ${FUNC_PATH}/tmp/tmp_pcap_log4rs.info
fi

flag="pidstat -t -p `pgrep pcap_save_file` | grep '|' | sed 's/[ ][ ]*/,/g' |grep pcap_storage |cut -d ',' -f 4"
flag=`eval $flag`
if [ "$flag" == "" ] ; then
	echo "got pcap_save_file thread pcap_storage fail" >> $RESULT
	exit 1
else
	echo "${flag}" > ${FUNC_PATH}/tmp/tmp_pcap_storage.info
fi
flag="pidstat -t -p `pgrep pcap_save_file` | grep '|' | sed 's/[ ][ ]*/,/g' |grep 'cap#enp1s0f0' |cut -d ',' -f 4"
flag=`eval $flag`
if [ "$flag" == "" ] ; then
	echo "got pcap_save_file thread cap#enp1s0f0 fail" >> $RESULT
	exit 1
else
	echo "${flag}" > ${FUNC_PATH}/tmp/tmp_pcap_cap_enp1s0f0.info
fi
flag="pidstat -t -p `pgrep pcap_save_file` | grep '|' | sed 's/[ ][ ]*/,/g' |grep 'cap#enp0s31f6' |cut -d ',' -f 4"
flag=`eval $flag`
if [ "$flag" == "" ] ; then
	echo "got pcap_save_file thread cap#enp0s31f6 fail" >> $RESULT
	exit 1
else
	echo "${flag}" > ${FUNC_PATH}/tmp/tmp_pcap_cap_enp0s31f6.info
fi
flag="pidstat -t -p `pgrep pcap_save_file` | grep '|' | sed 's/[ ][ ]*/,/g' |grep pcap_delete |cut -d ',' -f 4"
flag=`eval $flag`
if [ "$flag" == "" ] ; then
	echo "got pcap_save_file thread pcap_delete fail" >> $RESULT
	exit 1
else
	echo "${flag}" > ${FUNC_PATH}/tmp/tmp_pcap_delete.info
fi

# ##########################################
# check pop3
# ##########################################
pid=`pgrep pop3_parser`
if [ "$pid" == "" ] ; then
	echo "got pop3_parser pid fail" >> $RESULT
	exit 1
else
	echo "${pid}" > ${FUNC_PATH}/tmp/tmp_pop3_parser.info
fi


exit 0

