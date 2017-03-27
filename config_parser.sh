#!/bin/bash

VARIABLE_FILE=./vars
source $VARIABLE_FILE


function config_cleanup {

    echo 'removing the comments and unecessary lines'
    grep -o '^[^#]*' $SSH_CONFIG_FILE | awk 'NF > 0' > $TMP_SSH_CONFIG_FILE;

}

function parsing_ssh_config {

    ## Redirecting all the output to harvest file
    exec 3>&1;
    exec > $SSH_HARVEST;
    
    while read -r line
    do
	key=$(echo $line | awk '{print $1}');
	value=$(echo $line | awk '{print $2}');
	
	## seperates the configuration between two different host
	[[ "$key" = "$HOST_SEPERATOR" ]] && seperator="" && echo

	echo -en $seperator$key:$value
	seperator=", "
			
    done < $TMP_SSH_CONFIG_FILE

    #redirecting back to stdout and removing file discriptor 6
    exec 1>&3 3>&-;

}


function extracting_host_info {

    ./extract_host_ip.awk $SSH_HARVEST | tee $HOST_N_IP
}

    
config_cleanup
parsing_ssh_config
extracting_host_info
