#!/bin/bash

prvaporuka="$(djtgcfg enum)"                                            #Покреће прву наредбу и чува њен садржај. 
if [ "$prvaporuka" == "No devices found" ]; then                        #Провера да ли је плоча прикључена
	echo "Проверите да ли је плоча укључена или повезана."
else
	out=${prvaporuka#*Device:}
	out=(${out[0]})                                                     #Узима се име плоче

	inicijalizacija="$(djtgcfg init -d  ${out})"                        #Покреће другу наредбу
	inicijalizacija=${inicijalizacija#*}
	inicijalizacija=(${inicijalizacija[0]})
	if [ "$inicijalizacija" == "Initializing" ]; then                   #Проверава да ли је дошло до грешке у иницијализацији
		bitfile=(`find ./ -maxdepth 1 -name "*.bit"`)                   #Тражи .bit дадотеке
		if [ ${#bitfile[@]} == 1 ]; then                                #Проверава да ли постоји тачно једна .bit дадотека
			djtgcfg prog -d ${out} -i 0 -f ${bitfile[0]#*/.}            #Покреће програмирање за ту једну .bit дадотеку
		else
			echo "Унесите локацију и име .bit датотеке: "
			read lokacija                                               #Чита унету локацију
			temp="${lokacija%\'}"
			temp="${temp#\'}"                                           #Решава проблем са наводницима

			djtgcfg prog -d ${out} -i 0 -f ${temp}	                    #Покреће програмирање за дату адресу

		fi
	else
		echo "Грешка у иницијализацији плоче. Проверите назив и покушајте ручну иницијализацију са наредбама: "
		echo "djtgcfg enum"
		echo "djtgcfg init -d  Назив_уређаја"
		echo "djtgcfg prog -d Назив_уређаја -i 0 -f локација.bit"	
	fi
fi
