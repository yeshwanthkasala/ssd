	   echo "Ok Warning" >health_state
	   echo ${health_state}
     health_check=$(echo "${health_state}" | grep -v Ok | grep -v Warning)
    if [[ -z "${health_check}" ]] ; then
       echo "-----------------------------------------------------------"
       echo "Health Check status of individual nodes -1"
       echo ${health_state}
       echo "Read content in Health_Check"
       echo ${health_check}
       echo "-----------------------------------------------------------"
       echo "############################################################"
       echo "Deployment is completed to $env_name, please browse the URl"
       echo "#############################################################"
       
    else
       sleep 20
       health_state=$(aws elasticbeanstalk describe-instances-health --environment-name $env_name --region ${region} --attribute-names HealthStatus --query InstanceHealthList[] --output text)
       health_check=$(echo "${health_state}" | grep -v Ok | grep -v Warning)
       if [[ -z "${health_check}" ]] 
       then
           echo "-----------------------------------------------------------"
           echo "Health Check status individual nodes "
           echo ${health_state}
           echo "-----------------------------------------------------------"
           sh ${WDIR}/script_to_get_product_version_from_log_v3locitydev.sh ${client} ${region} ${env_name}
           echo "############################################################"
           echo "Deployment is completed to $env_name, please browse the URl"
           echo "#############################################################"
       else
           echo "-----------------------------------------------------------"
           echo "Health Check status individual nodes "
           echo ${health_state}
       echo "Read content in Health_Check"
           echo ${health_check}
           echo "-----------------------------------------------------------"
           echo "############################################################"
           echo "==============================================================================="
           echo "**** Techleads, seems deployment failed for $env_name environment, please check the Application logs to figure out the cause ********"
           echo "#############################################################"
           exit 1
       fi
    fi
}
