#!/bin/bash
usage="\nUsage: sh main.sh [OPTIONS]
\nStarts and stops main service(s) such as configuration, discovery and gateway. By default it tries to start service(s) assuming it is not running.
\nOptions:
\r  -s <RepoName>	To target specific service.
\r  -r		To restart service(s).
\r  -k		To kill/stop service(s).
\r  -h		Show usage."

while getopts ":s:rkh" opt; do
  case $opt in
      s) servicename="$OPTARG"
          ;;
	  r) restart="true"
          ;;
	  k) stop="true"
		 ;;
	  h) echo -e "$usage"
		 exit
          ;;
	esac
done


export PROFILE=staging

pushd $SOURCE_DIR

# Managing configuration service
if [ "$servicename" == "" ] || [ "$servicename" == "configurationservice" ]; then
	if [ "$restart" == "true" ] || [ "$stop" == "true" ]; then 
		echo -e "\nStopping Configuration service."
		kill -9 $(cat pid/configurationservice)
		>pid/configurationservice
	fi
	if [ "$stop" != "true" ]; then 
		echo -e "\nDeleting all log files of configuration service before starting it."
		# Here we find the file irrespective of case of the file name and then delete.
		pushd $AWARE_LOGS
		find . -maxdepth 1 -iname "*configurationservice*" -exec rm {} +;
		popd
		
		echo -e "\nStarting Configuration service."
		nohup java -jar $SOURCE_DIR/configurationservice/target/configurationservice*.jar --spring.profiles.active=$PROFILE &
		LASTPID=$!
		echo $LASTPID >> pid/configurationservice
		sleep 10
	fi	
fi

# Managing discovery service
if [ "$servicename" == "" ] || [ "$servicename" == "discoveryservice" ]; then 
	if [ "$restart" == "true" ] || [ "$stop" == "true" ]; then
		echo -e "\nStopping Discovery service."
		kill -9 $(cat pid/discoveryservice)
		>pid/discoveryservice
	fi
	if [ "$stop" != "true" ]; then
		echo -e "\nDeleting all log files of discovery service before starting it."
		# Here we find the file irrespective of case of the file name and then delete.
		pushd $AWARE_LOGS
		find . -maxdepth 1 -iname "*discoveryservice*" -exec rm {} +;
		popd
		
		echo -e "\nStarting Discovery service"
		nohup java -jar $SOURCE_DIR/discoveryservice/target/discoveryservice*.jar --spring.profiles.active=$PROFILE &
		LASTPID=$!
		echo $LASTPID >> pid/discoveryservice
		sleep 10
	fi	
fi

# Managing gateway service
if [ "$servicename" == "" ] || [ "$servicename" == "gatewayservice" ]; then 
	if [ "$restart" == "true" ] || [ "$stop" == "true" ]; then
		echo -e "\nStopping Gateway service."
		kill -9 $(cat pid/gatewayservice)
		>pid/gatewayservice
	fi
	if [ "$stop" != "true" ]; then
		echo -e "\nDeleting all log files of gateway service before starting it."
		# Here we find the file irrespective of case of the file name and then delete.
		pushd $AWARE_LOGS
		find . -maxdepth 1 -iname "*gatewayservice*" -exec rm {} +;
		popd
		
		echo -e "\nStarting Gateway service"
		nohup java -jar $SOURCE_DIR/gatewayservice/target/gatewayservice*.jar --spring.profiles.active=$PROFILE --eureka.instance.hostname=localhost &
		LASTPID=$!
		echo $LASTPID >> pid/gatewayservice
		sleep 10		
	fi
fi

echo -e "\nVerify Service Status via http://localhost:8761/"

popd