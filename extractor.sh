#!/bin/bash
read fname 
#reading url path from user
echo "Process started."
#script started

###########################################################################################
#Debugging function ignore

###########################################################################################

#working just for debugging
get_domain()
{
	#getting domain name so that we may prevent files outside parent
	echo $fname | cut -d'/' -f3 >domain
	echo $n_domain | cut -d'/' -f3 >newdomain
	domain=$(cat domain)
	new_domain=$(cat newdomain)
	touch list.log
}



###########################################################################################
#Debugging function ignore

###########################################################################################







#working
moved_domain()
{
	#void output if no redirection,checking link redirection
	curl -i "$fname" -L | egrep -A 10 '301 Moved Permanently|302 Found' | grep 'Location' | awk -F': ' '{print $2}' | tail -1 >moved.txt
	n_domain=$(cat moved.txt)
}

#working
get_css()
{
	#getting links which redired to css file
	grep css list.log >>cssf.log
}

#working
get_file_for_link()
{
	#if new domain name is void means domain hhas not changed
	if [ "$n_domain" == "" ]
		then
   			echo "Domain has not changed"
   			curl $fname >file
		else
			#so new url i.e. fname will be n_domain
   			echo "Domain has changed"
   			#downloading new url's content in file
   			curl $n_domain >file
   			fname=n_domain
   		fi
	
	#wget $fname -O file	
}

#working
get_links_from_files()
{	
	#storing each links in file output_temp
	grep -Po "(?<=href=')[^']*" file > output_temp.log
	grep -Po '(?<=href=")[^"]*' file > output_temp.log
	grep -Po '(?<=:url)[^)]*' file >link_css
	#:url(/images/nav_logo242.png)
	#output is (/images/nav_logo229.png	
}

#working temprary must be removed soon
get_linecount()
{
	temp_lines=$( cat output_temp.log | wc -l )
	lines=$( cat list.log | wc -l )
	lines_css=$( cat link_css | wc -l )
}

#Check if worked remove get_linecount
get_linecount_arguments()
{
	# $1 is aruments (file name) whose line is to be counted
	p_lines=$( cat $1 | wc -l )
}

#Check
correcting_css()
{

	a=0
	while [ "$a" -lt "$lines_css" ]    # run loop till no of lines in temp
	do
		#read line and store them in variable line
   		css_line=$(head -"$a" link_css | tail -1)
   		((a++))
		#echo $css_line
		echo $css_line>temp_css_line

		#output is (/images/nav_logo229.png
		cat css_line | cut -c 2- 
		#corrected output is /images/nav_logo229.png

		if [[ ($css_line == "'"*)||($css_line == '"'*) ]]; 
		then 
			#if link is of type :url('/images/nav_logo242.png') 
			#strong in file tempv
			echo $css_line>tempv
			#reading from file tempv without "*" or '*' and storing them in css_temp
			grep -Po "(?<=')[^']*" tempv >> css_temp
			grep -Po '(?<=")[^"]*' tempv >> css_temp
		else
			echo "ok $css_line"
		fi

   		
	done
	#if link is of type :url('/images/nav_logo242.png')
}


#Check if worked remove correcting_links
correcting_links_parameters()
{
	current=fname
	#required
	((p_lines++))
	#initialisation
	a=1
	while [ "$a" -lt "$p_lines" ]    # run loop till no of lines in temp
	do
		#read line and store them in variable line
		# $1 is aruments (file name) whose line is to be counted
   		line=$(head -"$a" $1 | tail -1)
   		((a++))
		#echo $line
		#check wheter the url already contains the full path
		echo $line>check
		echo $line | cut -d'/' -f3 >check
		temp_domain=$(cat check )
		if [ "$domain" == "$temp_domain" ]
		then
   			#echo "Link is acessible"
   			echo $line >>final_list
		else
	
			if [[ $line == /* ]]; 
			then 
				#links starting with / are now corrected to redirect to site
				foo=$fname$line
				#echo $foo
				echo $foo >>final_list_temp
			else 
   				echo $line>>rejected.list
   				#echo "$line :_with domain_: $temp_domain "

			fi
   			
   		fi
   		
	done

}


#working temprary must be removed soon
correcting_links()
{
	current=fname
	#required
	((temp_lines++))
	#initialisation
	a=1
	while [ "$a" -lt "$temp_lines" ]    # run loop till no of lines in temp
	do
		#read line and store them in variable line
   		line=$(head -"$a" output_temp.log | tail -1)
   		((a++))
		#echo $line
		echo $line>check
		echo $line | cut -d'/' -f3 >check
		temp_domain=$(cat check )
		#check wheter the url already contains the full path
		if [ "$domain" == "$temp_domain" ]
		then
   			#echo "Link is acessible"
   			echo $line >>final_list
		else
	
			if [[ $line == /* ]]; 
			then 
				#links starting with / are now corrected to redirect to site
				foo=$fname$line
				#echo $foo
				echo $foo >>final_list_temp
			else 
   				echo $line>>rejected.list
   				#echo "$line :_with domain_: $temp_domain "

			fi
   			
   		fi
   		
	done

}

#not completed
storing_to_list()
{
	#required
	((temp_lines++))
	#initialisation
	a=1
	while [ "$a" -lt "$temp_lines" ]    # run loop till no of lines in temp
	do
		#read line and store them in variable line
   		line=$(head -"$a" output_temp.log | tail -1)
   		((a++))
		#echo $line
		#linear search second loop
		b=1
		found=0
		#while [[ ]]; do
			#statements
		#done
   		
	done
}

##main program starts here
moved_domain
get_file_for_link
get_domain
get_links_from_files
get_linecount

echo $temp_lines
echo $lines
echo $domain
echo $new_domain
correcting_links
#storing_to_list
