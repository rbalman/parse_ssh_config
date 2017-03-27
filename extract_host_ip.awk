#!/usr/bin/awk -f
# Parsing the HostName & HostIp from a sample like:
# Host:myhost.com, HostName:54.17.71.109, User:deploy, Port:2020


BEGIN {
    
    printf("%-45s %-45s\n","HostName","HostIp");
    printf("%-45s ------","--------");
    FS=", ";
}

{
    
    number_of_fields=NF
    
    for (i=1; i <= number_of_fields; i++)
    {
	field=i;
	
	if ($field ~ /^Host/)                     # if field start with the Host then
	{
	    split($field, field_array, ":");
	    our_fruit=field_array[2];             # fruit of our parsing either hostname/hostip
	    printf("%-45s ",our_fruit);
	}
    }
    printf("\n");
}

END {print "---------------------------------------------------------------------------------------"}
