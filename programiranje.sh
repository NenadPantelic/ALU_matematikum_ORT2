#!/bin/bash

msg="$(djtgcfg enum)"                                            #Start first instruction and saves it 
if [ "$msg" == "No devices found" ]; then                        #Check if device is plugged and turned on
	echo "Check if your device is turned on."
else
	out=${msg#*Device:}
	out=(${out[0]})                                                     #Device name

	initial="$(djtgcfg init -d  ${out})"                        #Second instruction
	initial=${initial#*}
	initial=(${initial[0]})
	if [ "$initial" == "Initializing" ]; then                   #Checks init errosПроверава да ли је дошло до грешке у иницијализацији
		bitfile=(`find ./ -maxdepth 1 -name "*.bit"`)                   #Search for .bit files
		if [ ${#bitfile[@]} == 1 ]; then                                #only one .bit file?
			djtgcfg prog -d ${out} -i 0 -f ${bitfile[0]#*/.}            #Start programming of that .bit fileПокреће програмирање за ту једну .bit дадотеку
		else
			echo "Type location and name of .bit file: "
			read location                                              #Reads path
			temp="${location%\'}"
			temp="${temp#\'}"                                           #Solves problems with quotation marks

			djtgcfg prog -d ${out} -i 0 -f ${temp}	                    #Start programming

		fi
	else
		echo "Init error. Check typing, names and try manaul initialization with: "
		echo "djtgcfg enum"
		echo "djtgcfg init -d  Device name"
		echo "djtgcfg prog -d Device name -i 0 -f location.bit"	
	fi
fi
